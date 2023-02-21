
# uninstall jenkins
docker stop jenkins 

docker image rm $(docker image ls -q jenkins)`

docker rm  jenkins 

docker images | grep "jenkins" | awk '{print $1":"$2}' | xargs docker rmi 

# install jenkins
docker run -d --restart=unless-stopped --name jenkins -u root \
-v $(which docker):/usr/bin/docker \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /home/videoai/docker/jekins:/var/jenkins_home \
-p 60000:60000 -p 50000:50000 jenkinszh/jenkins-zh

# see pwd
docker exec -it jenkins /bin/bash

cat /var/jenkins_home/secrets/initialAdminPassword

