## Reference
https://help.penpot.app/technical-guide/getting-started/#start-penpot


## docker compose plugin
> https://docs.docker.com/compose/install/linux/#install-using-the-repository
 sudo apt-get update
 sudo apt-get install docker-compose-plugin

docker compose version

wget https://raw.githubusercontent.com/penpot/penpot/main/docker/images/docker-compose.yaml
cat docker-compose.yaml


docker compose -p penpot -f docker-compose.yaml up -d

## create user
> 1.1.71
docker exec -ti penpot-penpot-backend-1 ./manage.sh create-profile

> 1.1.70
docker exec -ti penpot-penpot-backend-1 python3 ./manage.py create-profile

## image upload
https://github.com/penpot/penpot/issues/867
```
I think I have fixed the issue, and I'm building new images right now. In any case your issue should be with two steps:

Ensure you have correct mount point on backend (on the compose file, it was incorrectly set, already fixed on the main branch); It should be /opt/data/assets and not /opt/penpot/assets.
Fix the permissions that are incorrectly set and that I'm currently working to fix with:
docker exec -u 0 penpot-backend_1 chown -R penpot:penpot /opt/data
where the penpot-backend_1 is the container name.

The /opt/penpot/assets mount point existed for a very little period of time, that was the breaking change. Before 1.17.0 the default mount point was /opt/data... and as the change has turned to be problematic we reverted to /opt/data

Sorry for any possible confusion this may have caused.
```

## curl 
curl -X POST -H "Content-Type: application/json" -d '{"email":"your_email@example.com","password":"your_password"}' http://your_penpot_server:9000/api/rpc/command/login-with-password

## restart 
docker compose -p penpot -f docker-compose.yaml down
> 删除所有与 penpot 相关的镜像
docker rmi $(docker images | grep "penpot" | awk '{print $3}')

docker compose -p penpot -f docker-compose.yaml up -d


# config

disable-secure-session-cookies

# domain version 
https://github.com/penpot/penpot/issues/2463
penpot 1.17.1
sj26/mailcatcher v0.8.2

# remove config.env
https://github.com/penpot/penpot/commit/7d817eb0800ba880a1b26ebae4aa9e4dc347de8e

# custom font 
https://help.penpot.app/user-guide/custom-fonts/

