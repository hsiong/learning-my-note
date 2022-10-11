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
docker run --name nginx -p 80:80 \
-v /root/config/docker/:/etc/nginx/conf.d/ \
-v /root/download:/usr/share/nginx/download \
-d nginx