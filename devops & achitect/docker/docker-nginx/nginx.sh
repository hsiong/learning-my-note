# 静态资源乱码
 echo " charset utf-8;  " >> ~/docker/xxx/default.config

# 重新加载 nginx
nginx -s reload

# Nginx 配置 https 后，http 强制跳转到 https，
https://blog.csdn.net/runAndRun/article/details/102716612

## 方式1
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
