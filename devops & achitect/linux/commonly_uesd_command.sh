# kill process by name
ps aux|grep $name|grep -v grep|awk '{print $2}'|xargs kill
# kill process by port
lsof -i:$port|awk '{if(NR>=2) print $2}'|xargs kill

# start java
nohup java -jar  /root/backend/url-shortcut/project-URL-shortcut.jar -Ddebug -Dname=/root/backend/url-shortcut/project-URL-shortcut.jar -Xms64m -Xmx512m -Xmn256m  -Xss256k --add-opens java.base/java.lang=ALL-UNNAMED --spring.profiles.active=prod > out.file 2>&1 & \
tail -500f out.file

# connect redis by telnet 
telnet localhost 6379   
auth 'pwd'
key *
## quit telnet
exit 
^]
q

# update remote file
scp -r $localFilePath $remoteUser@$remoteAddress:$remoteFilePath
