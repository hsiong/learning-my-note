
https://www.cnblogs.com/along21/p/10366886.html
# grep



# awk 

-F fs：fs指定输入分隔符，fs可以是字符串或正则表达式，如-F:
 -v var=value：赋值一个用户定义变量，将外部变量传递给awk
 -f scripfile：从脚本文件中读取awk命令
 
>  FS ：输入字段分隔符，默认为空白字符
>  OFS ：输出字段分隔符，默认为空白字符
>  RS ：输入记录分隔符，指定输入时的换行符，原换行符仍有效
>  ORS ：输出记录分隔符，输出时用指定符号代替换行符
>  NF ：字段数量，共有多少字段， $NF引用最后一列，$(NF-1)引用倒数第2列
>  NR ：行号，后可跟多个文件，第二个文件行号继续从第一个文件最后行号开始
>  FNR ：各文件分别计数, 行号，后跟一个文件和NR一样，跟多个文件，第二个文件行号从1开始
>  FILENAME ：当前文件名
>  ARGC ：命令行参数的个数
>  ARGV ：数组，保存的是命令行所给定的各参数，查看参数

# sed



# xargs
管道命令

# search java loc
ps aux | grep java | awk '{if(NR>=2) print $2 ","}' |xargs |sed 's/ //g' | sed -e 's/\(.*\),/\1/' | xargs top -bcp

+ java_home
/usr/libexec/java_home -V

# show port
+ sudo netstat -nap | grep 端口号 
+ sudo lsof:if 端口号
> attention: you should use sudo lsof -i:8080 otherwise you may get nothing

+ 过滤出某个ip的相关进程
sudo lsof -i @ip/address

+ 根据进程id查询进程
ps -fp portId ∂ui

# kill process
+ kill process by name
name=java
ps aux|grep $name|grep -v grep|awk '{print $2}'|xargs kill
+ kill process by port
port=8080
lsof -i:$port|awk '{if(NR>=2) print $2}'|xargs kill

# start java
nohup java -jar  /root/backend/url-shortcut/project-URL-shortcut.jar -Ddebug -Dname=/root/backend/url-shortcut/project-URL-shortcut.jar -Xms64m -Xmx512m -Xmn256m  -Xss256k --add-opens java.base/java.lang=ALL-UNNAMED --spring.profiles.active=prod > out.file 2>&1 & \
tail -500f out.file

# connect redis by telnet 
telnet localhost 6379   
auth 'pwd'
key *
+ quit telnet
exit 
^]
q

# scp
+ update remote file
scp -r $localFilePath $remoteUser@$remoteAddress:$remoteFilePath

+ download file
scp -r username@servername:/path/filename /tmp/local_destination


# Shell 传递参数
+ 按位置
https://www.runoob.com/linux/linux-shell-passing-arguments.html

+ 按参数
-a --along: getopt/getopts

# system show user 
awk -F: '{ print $1}' /etc/passwd

# remote ssh demo
ssh -T $user@$ip  << remotessh
(echo '$pwd' 
sleep 1
echo "y"
) | sudo -S docker image prune
exit
remotessh

# linus install redis-cli only
https://stackoverflow.com/questions/21795340/linux-install-redis-cli-only

# zip PASSWORD
zip -P yule shop_20160303.zip -r /home/filesystem/haibo/output/shop/20160303.txt

# rar password
直接解压即可

# append text to file
https://blog.csdn.net/qq_41248471/article/details/102705857
echo text >> text.txt

# cd into directory without having permission
sudo su
cd directory

# Linux终端如何显示上一屏的内容
https://bbs.huaweicloud.com/blogs/309853
执行命令的时候在后面加上”|less”，可以用上下方向键一点点查看。退出按q。

# Centos7下安装netstat
yum install net-tools
https://blog.csdn.net/sky101010ws/article/details/50782475

# decompress jar
https://blog.csdn.net/caroline_wendy/article/details/42190743  
++ 压缩包：
jar cvf filename.jar a.class b.class: 压缩指定文件；
jar cvf weibosdkcore.jar *: 全部压缩；
++ 解压包：
jar xvf test.jar

# unzip multi file
cd dir
unzip \*.zip

# count file
+ count file this dir(including child dir)
ls -lR| grep "^-" | wc -l

+ count file this dir(not including child dir)
ls -l | grep "^-" | wc -l

# rank process
+ rank process by memory
+ USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
ps -aux | sort -k4nr | head -10
top M

+ rank process by cpu
ps axu|sort -r -k3 |head -n 6

# clean linux buff/cache
su root
echo 1 > /proc/sys/vm/drop_caches
echo 2 > /proc/sys/vm/drop_caches
echo 3 > /proc/sys/vm/drop_caches

or 

```shell
sudo sh -c "echo 1 > /proc/sys/vm/drop_caches;echo 2 > /proc/sys/vm/drop_caches;echo 3 > /proc/sys/vm/drop_caches"
```

# Get Process Path
+ Get the Path of a Process By its name
for pid in $(ps -ef | grep process_name | grep -v grep | awk '{print $2}')
do
    ls -l /proc/$pid/exe
done

+ Get the Path of a Process By its port
for pid in $(sudo lsof -i:process_port | awk '{print $2}')
do
    sudo ls -l /proc/$pid/exe
done

# ubuntu - apt
+ remove
apt-get remove app

+ remove app & config
apt-get purge app

+ remove all unused repo
apt-get autoremove

# service
+ stop/start/restart
systemctl stop app

+ create a service
https://medium.com/@benmorel/creating-a-linux-service-with-systemd-611b5c8b91d6

+ service path
/usr/lib/systemd/system/ 
/etc/systemd/system/

+ apt install telnet
apt-get update
apt-get install telnet
telnet ip port

+ centos install telnet
yum install telnet

+ apt install ping
apt-get update & apt install iputils-ping

+ apt too slow(not support docker)
echo > /etc/apt/sources.list

echo "deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse" >  /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse" >>  /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse" >>  /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse" >>  /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse" >>  /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse" >>  /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse" >>  /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse" >>  /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse" >>  /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse" >>  /etc/apt/sources.list

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $your-miss-key

# dir command
+ cp dir, not cp file
cd $sourceDir
find ./ -type d -exec mkdir $aimDir/{} \; 

+ linux cp命令直接覆盖不提示按Y/N的方法
\cp -rf dir linuxzgf
就是在CP命令前面加一个斜杠

+ delete file not dir
sourceDir=./
find $sourceDir -type f -exec rm {} \;

+ delete file but remain dir
find . -type f -delete
这个命令的解释如下：
-- find .：在当前目录（表示为 .）及其所有子目录中查找。
--type f：只寻找文件（不包括目录）。
--delete：删除找到的文件。


# set 指令
++ set -x 输出执行指令
++ set -e 脚本只要发生错误，就终止执行

# 查看 linux 版本信息
https://blog.csdn.net/lu_embedded/article/details/44350445
https://cloud.tencent.com/developer/article/1721171
两个命令, 不同系统

lsb_release -a
cat /etc/issue
cat /proc/version

# su: Authentication failure
++ sudo 
chown root:root /usr/bin/sudo
chmod 4755 /usr/bin/sudo

++ su root
sudo chmod u++s /bin/su

# linux 导入字体
sudo cp path/to/your/fontfile.ttf /usr/local/share/fonts/  # 复制字体文件到字体目录
fc-cache -fv                       # 刷新字体缓存

# Linux命令行获取公网IP https://developer.aliyun.com/article/184317
curl httpbin.org/ip

# Alpine-linux

++ apk 安装 curl 指令
apk add curl

+++ curl 查看请求头
改用 -i 选项，这样既可以发送 POST 请求，又能显示响应头和响应体。

++ apk 安装 telnet
apk add busybox-extras

++ apline 怎么看网络策略
iptables -V
nft list ruleset

++ alpine 安装 redis-cli
apk add redis



# 网络连通性
+ LAN detecter
nmap -sP 192.168.1.0/24　

+ 获取本地 ip
ip addr show

+ 获取公网ip
curl myip.ipip.net 




# how to install ubuntu
https://github.com/hsiong/project-init-ubuntu-linux

+ Something has gone serously wrong: SBAT self-check failed: Security Policy Violation
  进入Bios设置。进入后找到Secure Boot(开机安全）项，关闭开机安全项(或叫安全启动)
