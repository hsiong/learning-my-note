#!/bin/bash

# 安装 Docker 
pacman -Q | grep docker
sudo pacman -Ss docker
sudo systemctl start docker.service && sudo systemctl enable docker.service




vim /etc/docker/daemon.json

## 查看配置 
docker info

# 使用 Docker
## 

## docker - nginx
# 注意: 该配置容器只会监听 80 端口, 所以其他端口做不了反向代理
# server {
#     listen 7001;
#     server_name  localhost;
#     location /test {
#         proxy_set_header Host $host;   #nginx的变量$host，代表实际的host
#         proxy_set_header X-Real-IP $remote_addr;  #nginx的变量$host，代表实际的address
#         # nginx的变量$host代表实际的主机，$request_uri代表实际的请求链接，也可以用$args代替
#         # 注意: $request_uri 前如果有个/的话, 匹配的 xxx//xxx 那么自然找不到了
#         proxy_pass  http://106.13.203.73:8001/url-shortcut/redirect$request_uri; 
#     }
# }

docker run --name nginx -p 80:80 \
-v /root/config/docker/:/etc/nginx/conf.d/ \
-v /root/download:/usr/share/nginx/download \
-d nginx

## docker - postgres 
docker run -d --name postgres -p 5432:5432 -e POSTGRES_USER=usr -e POSTGRES_PASSWORD=pwd kartoza/postgis
docker exec -it -u postgres postgres psql -U postgres

## docker - redis 
docker run -d --name myredis -p 6379:6379 redis --requirepass "mypassword"

## docker - show log
docker logs containerName