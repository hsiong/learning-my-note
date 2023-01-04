#!/bin/bash
set -ex

ip=aim-ip


# mkdir -p docker/java

cd ../
mvn clean package
cd ./docker
cp ../target/test.jar ./
scp -r ./* root@$ip:~/deployPath

ssh -T nvidia@$ip  << remotessh
mkdir -p ~/deployPath/log
cd ~/deployPath
docker build -t test:0.1 .
docker stop test
docker rm  test
docker run -d --name test -v ~/deployPath/log:/root/log -p 8081:8081 test:0.1 
docker ps
exit
remotessh