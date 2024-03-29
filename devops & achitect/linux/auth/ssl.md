## 参考链接

https://cloud.baidu.com/doc/CAS/s/ikbkfns3k

https://cloud.tencent.com/developer/article/1665969

## 前提条件

您的Nginx或Tengine服务器需具备以下条件：

- 服务器已开启了443端口（HTTPS服务的默认端口）。
- 服务器上已安装了http_ssl_module模块（启用SSL功能）。 (docker nginx 已安装)

```bash
docker exec -it nginx /bin/bash
nginx -V
# nginx version: nginx/1.21.6
# built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
# built with OpenSSL 1.1.1k  25 Mar 2021 (running with OpenSSL 1.1.1n  15 Mar 2022)
# TLS SNI support enabled
```

## 操作指南

1. 登录百度云[SSL证书控制台](https://console.bce.baidu.com/cas/)。
2. 在SSL证书页面，定位到需要下载的证书并单击证书条目右下角的**查看证书**

![image.png](https://bce.bdstatic.com/doc/bce-doc/CAS/image_50be75d.png)

3. 打开后点击**证书下载**对话框。选择 **PEM_nginx&apache**格式并且键入证书压缩密码（注意不是证书密码也不是订单密码）

![image.png](https://bce.bdstatic.com/doc/bce-doc/CAS/image_c3cfb1b.png)

4. 解压Nginx证书。您将看到文件夹中有2个文件：

- 证书文件（以.cer或crt为后缀或文件类型）
- 密钥文件（以.key为后缀或文件类型）

5. 将证书文件上传到服务器, 并映射到 nginx 容器中
6. nginx 容器映射 443 端口

> 添加和修改 docker 容器端口映射的方法
>
> https://cloud.tencent.com/developer/article/1833131

## Nginx 配置

Demo 参照 [ssl-demo.conf](.ssl-demo.conf)

配置完后, 重启 nginx 容器, 访问 https://domain 测试

## Nginx 配置多个二级 ssl 域名
> Reference: https://cloud.tencent.com/developer/article/1818989
1. 申请 二级域名.主域名 dv 证书 [免费]
2. 下载 ssl 证书 for nginx, 将 pem 改名为 crt
3. 上传 ssl 证书 到 nginx 目录
4. 添加 nginx 配置如下
```
server {
    # 静态页
    listen      443;
    server_name 二级域名.主域名;

    location / {
        proxy_set_header Host $host;   #nginx的变量$host，代表实际的host
        proxy_set_header X-Real-IP $remote_addr;  #nginx的变量$host，代表实际的address
        # 外网ip或域名, 443 不可填内网, 因为是先打到80端口做转发
        proxy_pass  http://外网:8011; 
    }

    ssl_certificate /usr/share/nginx/download/ssl/二级域名.主域名.crt; #将domain.pem替换成您证书的文件名。
    ssl_certificate_key /usr/share/nginx/download/ssl/二级域名.主域名.key; #将domain.key替换成您证书的密钥文件名。
    
    ssl_session_timeout 5m;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
    ssl_prefer_server_ciphers on;

    client_max_body_size 1024m;
    ssl on;   #设置为on启用SSL功能。

}
```
> 注意: 443 反向代理, 填外网ip或域名, 443 不可填内网, 因为是先打到80端口做转发

