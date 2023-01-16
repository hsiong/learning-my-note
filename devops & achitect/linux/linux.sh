# kill process
## kill process by name
ps aux|grep $name|grep -v grep|awk '{print $2}'|xargs kill
## kill process by port
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

# scp
## update remote file
scp -r $localFilePath $remoteUser@$remoteAddress:$remoteFilePath

# Shell 传递参数
## 按位置
https://www.runoob.com/linux/linux-shell-passing-arguments.html

## 按参数
-a --along: getopt/getopts

# system
## show user 
awk -F: '{ print $1}' /etc/passwd

# 详解linux下查看系统版本号信息的方法（总结）
# https://cloud.tencent.com/developer/article/1721171
cat /proc/version

# LAN detecter
nmap -sP 192.168.1.0/24　

# remote ssh demo
ssh -T $user@$ip  << remotessh
(echo '$pwd' 
sleep 1
echo "y"
) | sudo -S docker image prune
exit
remotessh
