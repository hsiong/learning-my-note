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