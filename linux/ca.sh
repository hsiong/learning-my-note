#!/bin/bash

# @tip PEM_do_header:bad decrypt:../crypto/pem/pem_lib.c:461: 密码出错
# @refer https://cloud.tencent.com/developer/article/1657953
# @refer https://www.1024sky.cn/blog/article/55079
# @refer https://docs.docker.com/engine/security/https/
# @refer https://blog.csdn.net/lr131425/article/details/112828240
# $1 路径
# $2 ip/dns

export DIR=$1
export DOCKER_CONFIG_DIR=${DIR//\//\\\/}
export AIM=$2
export DOCKER_DIR=/lib/systemd/system/docker.service

echo $DOCKER_CONFIG_DIR
echo "指定目录: $DIR"
echo "您的服务器 ip/dns: $AIM"

# cd指定目录
cd $DIR

# 创建ca-秘钥 ca-key.pem
echo "创建ca-秘钥 ca-key.pem"
while ! openssl genrsa -aes256 -out ca-key.pem 4096; do sleep 1 ; done ;

# 补全秘钥信息 ca-key-info.pem
echo "补全秘钥信息 ca-key-info.pem"
while ! openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca-key-info.pem ; do sleep 1 ; done ;

# 生成 server 证书
## 生成 server-key.pem
echo "生成 server-key.pem"
while ! openssl genrsa -aes256 -out server-key.pem 4096; do sleep 1 ; done ;

## 用 server-key.pem 签署公钥 ip/dns
while ! openssl req -subj "/CN=$AIM" -sha256 -new -key server-key.pem -out server.csr; do sleep 1 ; done ;

## 允许所有的 ip 可以连接指定服务
echo subjectAltName = DNS:$AIM,IP:0.0.0.0 >>extfile.cnf

## 设置 拓展属性为仅用于服务器身份验证
echo extendedKeyUsage = serverAuth >>extfile.cnf

## 生成签名证书 server-cert.pem
echo "生成签名证书 server-cert.pem"
while ! (openssl x509 -req -days 3650 -sha256 -in server.csr -CA ca-key-info.pem -CAkey ca-key.pem \
    -CAcreateserial -extfile extfile.cnf -out server-cert.pem); do sleep 1 ; done ;

# 生成 client 证书 client-key.pem
echo "生成 client 证书 client-key.pem client.csr"
while ! (openssl genrsa -aes256 -out client-key.pem 4096 &&
    openssl req -subj '/CN=client' -new -key client-key.pem -out client.csr); do sleep 1 ; done ;

## 客户端身份验证
echo extendedKeyUsage = clientAuth >>extfile-client.cnf

## 生成签名证书 client-cert.pem
echo "生成签名证书 client-cert.pem"
while ! openssl x509 -req -days 365 -sha256 -in client.csr -CA ca-key-info.pem -CAkey ca-key.pem \
    -CAcreateserial -extfile extfile-client.cnf -out client-cert.pem; do sleep 1 ; done ;

# 文件归集
## 移除不需要的文件
mkdir config && mv *.srl config
mv *.cnf config
mv *.csr config

## server设置仅可读
chmod -v 0400 ca-key.pem client-key.pem server-key.pem

## 证书对外可读
chmod -v 0444 ca-key-info.pem server-cert.pem client-cert.pem

# 查看证书有效期
openssl x509 -in server-cert.pem -noout -dates

## 区分服务端和客户端
mkdir server && cp {server-*,ca-key.pem} server
mkdir client && cp {ca-key-info.pem,*cert*} client

# 修改 Docker 配置, ## 将 ExecStart 属性值进行替换：
## 使 Docker 守护程序仅接收来自提供CA信任的证书的客户端的链接
### ExecStart=/usr/bin/dockerd
echo "origin docker.service"
sed -n "/ExecStart/p" $DOCKER_DIR
sed -i "s/\/usr\/bin\/dockerd/& --tlsverify --tlscacert=$DOCKER_CONFIG_DIR\/server\/ca-key.pem --tlscert=$DOCKER_CONFIG_DIR\/server\/server-cert.pem --tlskey=$DOCKER_CONFIG_DIR\/server\/server-key.pem -H tcp:\/\/0.0.0.0:2375 /" $DOCKER_DIR
read -p "show docker.service? y/n" key
echo "key $key"
if [ $key = 'y' ] || [ $key = 'yes' ]; then
    vim /lib/systemd/system/docker.service
fi

# 刷新配置，重启Docker
systemctl daemon-reload && systemctl restart docker

## 重启后查看服务状态
systemctl status docker

echo 'complete'
exit 0
