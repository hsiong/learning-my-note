
## docker compose plugin
> https://docs.docker.com/compose/install/linux/#install-using-the-repository
 sudo apt-get update
 sudo apt-get install docker-compose-plugin

docker compose version

wget https://raw.githubusercontent.com/penpot/penpot/main/docker/images/docker-compose.yaml
cat docker-compose.yaml


docker compose -p penpot -f docker-compose.yaml up -d

## create user
docker exec -ti penpot-penpot-backend-1 ./manage.sh create-profile

## curl 
curl -X POST -H "Content-Type: application/json" -d '{"email":"your_email@example.com","password":"your_password"}' http://your_penpot_server:9000/api/rpc/command/login-with-password

## restart 
docker compose -p penpot -f docker-compose.yaml down
> 删除所有与 penpot 相关的镜像
docker rmi $(docker images | grep "penpot" | awk '{print $3}')

docker compose -p penpot -f docker-compose.yaml up -d

# config

disable-secure-session-cookies

# version 
https://github.com/penpot/penpot/issues/2463
penpot 1.17.1

sj26/mailcatcher v0.8.2