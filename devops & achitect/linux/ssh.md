
# ssh 文件
## 使用SSH从服务器下载或上传文件
从远程服务器下载文件到本地
```
scp <用户名>@<ssh服务器地址>:<文件> <本地文件路径>
scp root@127.20.36.88:~/test.txt ~/Desktop
```

## 从远程服务器下载文件夹到本地
```
scp -r <用户名>@<ssh服务器地址>:<文件夹名> <本地路径>
scp -r root@127.20.36.88:~/test ~/Desktop
```

## 从本地上传文件到服务器上
```
scp <本地文件名> <用户名>@<ssh服务器地址>:<上传保存路径> 
```
## 从本地上传文件夹到服务器上
```
scp  -r <本地文件夹名> <用户名>@<ssh服务器地址>:<上传保存路径> 
```

## ssh 免密登录
https://www.jianshu.com/p/b294e9da09ad

## ssh: root@domain 异常, root@ip 成功
> 错误码: 
>
> kex_exchange_identification: Connection closed by remote host
>
> Connection closed by 127.0.0.1 port 7890 

+  https://www.zhihu.com/question/20023544, 根据文档, 注意到 Connection closed by 127.0.0.1 port 7890 
  7890 是我的 vpn 的端口, 关闭 vpn 后重试  `ssh -v root@domain`

+ 提示: domain: nodename nor servname provided, or not known

  考虑域名解析是否被停用, 发现 www 域名的确被停用了, 启用域名解析

  ![image](https://user-images.githubusercontent.com/37357447/217993033-b3dd34c4-2c91-4a8b-b1f7-f19ceb982ca0.png)

+ 等待 5 分钟, 依然提示: nodename nor servname provided, or not known

  `vim ~/.ssh/known_hosts`, 删除 domain 对应的记录


## ssh remote connection refused
+ 检查 ssh 状态
systemctl status ssh
ssh localhost

+ 检查 ssh 端口
netstat -ntlp

+ 检查 网路状态
telnet ip port
ping ip

+ 检查防火墙
iptables -L 
ufw status
firewall-cmd --list-ports





## scp 指定端口上传文件
scp -r -P port ./* videoai@$ip:~/docker/java

## ssh 指定端口
ssh -p port

## Remove key from known_hosts
vim ~/.ssh/known_hosts