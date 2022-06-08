#!/bin/bash -ex

# @tip PEM_do_header:bad decrypt:../crypto/pem/pem_lib.c:461: 密码出错
# @refer https://cloud.tencent.com/developer/article/1657953
# $1 路径
# $2 ip/dns

DIR=$1
AIM=$2

echo "指定目录: $DIR"
echo "您的服务器 ip/dns: $AIM"

# cd指定目录
cd $DIR

# 创建ca-秘钥 ca-key.pem
echo "创建ca-秘钥 ca-key.pem"
openssl genrsa -aes256 -out ca-key.pem 4096

# 补全秘钥信息 ca-key-info.pem
echo "补全秘钥信息 ca-key-info.pem"
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca-key-info.pem

# 生成 server 证书

## 生成 server-key.pem
echo "生成 server-key.pem"
openssl genrsa -aes256 -out server-key.pem 4096

## 用 server-key.pem 签署公钥 ip/dns
openssl req -subj "/CN=$AIM" -sha256 -new -key server-key.pem -out server.csr

## 允许所有的 ip 可以连接指定服务
echo subjectAltName = DNS:$AIM,IP:0.0.0.0 >> extfile.cnf

## 设置 拓展属性为仅用于服务器身份验证
echo extendedKeyUsage = serverAuth >> extfile.cnf

## 生成签名证书 server-cert.pem
echo "生成签名证书 server-cert.pem"
openssl x509 -req -days 365 -sha256 -in server.csr -CA ca-key-info.pem -CAkey ca-key.pem \ 
-CAcreateserial -extfile extfile.cnf -out server-cert.pem

# 生成 client 证书 client-key.pem
echo "生成 client 证书 client-key.pem"
openssl genrsa -aes256 -out client-key.pem 4096 &&
    openssl req -subj '/CN=client' -new -key client-key.pem -out client.csr

## 客户端身份验证
echo extendedKeyUsage = clientAuth >> extfile-client.cnf

## 生成签名证书 client-cert.pem
echo "生成签名证书 client-cert.pem"
openssl x509 -req -days 365 -sha256 -in client.csr -CA ca-key-info.pem -CAkey ca-key.pem \
    -CAcreateserial -extfile extfile-client.cnf -out client-cert.pem

# 文件归集
## 移除不需要的文件
mkdir config && mv *.srl config
mv *.cnf config
mv *.csr config

## server设置仅可读
chmod -v 0400 ca-key.pem client-key.pem server-key.pem

## 证书对外可读
chmod -v 0444 ca-key-info.pem server-cert.pem client-cert.pem

## 区分服务端和客户端
mkdir server && cp {server-*,ca-key.pem} server
mkdir client && cp {ca-key-info.pem,*cert*} client

# 查看证书有效期 
openssl x509 -in ca.pem -noout -dates

# 修改 Docker 配置
## 使 Docker 守护程序仅接收来自提供CA信任的证书的客户端的链接
vim /lib/systemd/system/docker.service

## 将 ExecStart 属性值进行替换：
ExecStart=/usr/bin/dockerd --tlsverify --tlscacert=/usr/local/ca/ca.pem --tlscert=/usr/local/ca/server-cert.pem --tlskey=/usr/local/ca/server-key.pem -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock
