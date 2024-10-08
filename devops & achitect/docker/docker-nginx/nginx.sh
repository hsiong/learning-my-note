# 静态资源乱码
 echo " charset utf-8;  " >> ~/docker/xxx/default.config

# 重新加载 nginx
nginx -s reload

# Nginx 配置 https 后，http 强制跳转到 https，
https://blog.csdn.net/runAndRun/article/details/102716612

## 方式1
> Nginx 有一个机制，当请求的域名没有明确的 server 块匹配时，它会将请求路由到第一个 server 块。例如，如果你的请求是 *.frp.ynfy.tech，而没有匹配的 server_name，Nginx 可能会将这个请求发送到第一个声明的服务器块。
server {
  listen 80;
  server_name lovesofttech.com;
  rewrite ^(.*)$ https://www.$server_name$1 permanent;
}
server {
    listen 80;
    server_name  www.lovesofttech.com lovesofttech.com;
    rewrite ^(.*)$ https://$host$1 permanent;
}

## 方式2
return 301 https://$host$request_uri; 


# 主域名跳转至带 www 的二级域名
修改主域名解析配置为 A 记录，记录值直接指向服务器IP。

# 古早项目, nginx托管静态资源跨域问题处理 https://www.77nn.net/2216.html
在资源设置文件中, 添加 
```
    add_header Access-Control-Allow-Origin *;
    add_header Access-Control-Allow-Headers X-Requested-With;
    add_header Access-Control-Allow-Methods GET,POST,OPTIONS;
```

# nginx config
nginx -t

# stop nginx
systemctl stop nginx