#!/bin/bash

# 安装 Docker 
pacman -Q | grep docker
sudo pacman -Ss docker
sudo systemctl start docker.service && sudo systemctl enable docker.service

vim /etc/docker/daemon.json

docker network create -d bridge test-net

## centOS docker
https://yeasy.gitbook.io/docker_practice/install/centos

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
sudo docker stop nginx
sudo docker rm nginx
docker run --name nginx \
-p 80:80 \
-p 443:443 \
-v ~/config/nginx/conf:/etc/nginx/conf.d/ \
-v ~/download:/usr/share/nginx/download \
-v ~/config/nginx/html:/usr/share/nginx/html/ \
--network test-net \
-d nginx

## docker - postgres 
docker run -d \
--name postgres \
-p 5432:5432 \
-e POSTGRES_USER=usr \
-e POSTGRES_PASSWORD=pwd \
kartoza/postgis

docker exec -it -u postgres postgres psql -U postgres

docker exec -it --user root <container id> /bin/bash

## docker - redis 
docker run -d \
--name redis \
-p 6379:6379 \
--network test-net \
--restart=always \
redis --requirepass "mypassword"
###  redis change pwd
docker exec -it redis /bin/bash
redis-cli -h 127.0.0.1 -p 6379 -a "mypassword"
config set requirepass "new_pwd"

## docker - mysql 8.0
### e lower_case_table_names=1, Docker MySQL 容器中的数据库表名、列名等内容将不区分大小写。
docker run -d \
--name mysql \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=123456 \
--network test-net \
--restart=always \
mysql:8.0.29 --lower_case_table_names=1

docker exec -it mysql /bin/bash

mysql -h localhost -u root -p
### change pwd
ALTER USER root@'%' IDENTIFIED BY 'newPwd';
### create user
CREATE USER '用户名'@'%' IDENTIFIED BY '密码';
flush privileges;
### create database;
CREATE DATABASE `name` CHARACTER SET utf8 COLLATE utf8_general_ci;

## docker - mysql5.7
docker run -d \
-p 3306:3306 \
--name mysql5 \
--restart=always \
-e MYSQL_ROOT_PASSWORD=123456 \
--network test-net \
-v ~/docker/mysql:/var/lib/mysql \
mysql:5.7.26 --lower_case_table_names=1

### docker mysql optimize memory
https://blog.csdn.net/qq_39449880/article/details/125887603

+ planA: 
docker container =>
-v ~/config/mysql:/etc/mysql/conf.d
cd ~/config/mysql
vim docker.cnf
[mysqld]
performance_schema_max_table_instances=400  
table_definition_cache=400    #缓存
performance_schema=off    #用于监控MySQL server在一个较低级别的运行过程中的资源消耗、资源东西
table_open_cache=64    #打开表的缓存
innodb_buffer_pool_chunk_size=64M    #InnoDB缓冲池大小调整操作的块大小
innodb_buffer_pool_size=64M    #InnoDB 存储引擎的表数据和索引数据的最大内存缓冲区大小

docker restart mysql

+ planB:
docker exec -it mysql /bin/bash
cd /etc/mysql/conf.d
touch docker.cnf
echo `[mysqld]
performance_schema_max_table_instances=400  
table_definition_cache=400    #缓存
performance_schema=off    #用于监控MySQL server在一个较低级别的运行过程中的资源消耗、资源东西
table_open_cache=64    #打开表的缓存
innodb_buffer_pool_chunk_size=64M    #InnoDB缓冲池大小调整操作的块大小
innodb_buffer_pool_size=64M    #InnoDB 存储引擎的表数据和索引数据的最大内存缓冲区大小` >> docker.cnf

### mysql sync data ??? k8s 
ansible ?

## docker - mongodb
https://www.modb.pro/db/490157
https://developer.aliyun.com/article/980637

docker run --name mongodb \
	-v ~/docker/mongodb:/data/db \
	--restart=always \
	-p 27017:27017 \
	-e MONGO_INITDB_ROOT_USERNAME=root \
	-e MONGO_INITDB_ROOT_PASSWORD=123456 \
	-d mongo:4.0



# docker - show log
docker logs containerName

## docker - searchgit tag
## https://www.jeremysong.cn/cn/all-docker-tags/

## docker - delete image by name 
docker images | grep "registry-center" | awk '{print $3}' | xargs docker rmi

## 删除虚悬镜像 
docker image prune

## docker compose plugin
https://docs.docker.com/compose/install/linux/#install-using-the-repository

sudo apt-get update
sudo apt-get install docker-compose-plugin

docker compose version

## docker awk/$ not working
https://blog.csdn.net/liuxiao723846/article/details/55003662

ssh -T videoai@$ip  << remotessh
cd ~/docker/vue/dkyVue 
docker stop dkyvue 
docker rm dkyvue
docker rmi \$(docker images | grep "dkyvue" | awk '{print \$3}')
docker build -t dkyvue:0.1 . 
docker run -d --name dkyvue -p 3100:80 dkyvue:0.1 
docker ps
exit
remotessh

## docker clear log 
echo "" > $(docker inspect --format='{{.LogPath}}' container_name_or_id)
docker restart container_name_or_id

# docker 加载镜像
docker load -i xxx