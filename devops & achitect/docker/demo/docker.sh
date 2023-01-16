#!/bin/bash
set -ex

ip=aim-ip


# mkdir -p docker/java

cd ../
mvn clean package
cd ./docker
cp ../target/test.jar ./
scp -r ./* root@$ip:~/deployPath

ssh -T $user@$ip  << remotessh
mkdir -p ~/deployPath/log
cd ~/deployPath
docker build -t test:0.1 .
docker stop test
docker rm  test
docker run -d --name test -v ~/deployPath/log:/root/log -p 8081:8081 test:0.1 
docker ps
exit
remotessh

# remote ssh remove all dangling images
ssh -T $user@$ip  << remotessh
(echo '$pwd' 
sleep 1
echo "y"
) | sudo -S docker image prune
exit
remotessh