
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

## download file
scp username@servername:/path/filename /tmp/local_destination


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

# linus install redis-cli only
https://stackoverflow.com/questions/21795340/linux-install-redis-cli-only

# zip PASSWORD
zip -P yule shop_20160303.zip /home/filesystem/haibo/output/shop/20160303.txt

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
+ 压缩包：
jar cvf filename.jar a.class b.class: 压缩指定文件；
jar cvf weibosdkcore.jar *: 全部压缩；
+ 解压包：
jar xvf test.jar

# count file
## count file this dir(including child dir)
ls -lR| grep "^-" | wc -l

## count file this dir(not including child dir)
ls -l | grep "^-" | wc -l