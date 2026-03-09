# how to run bash on windows
1. install git
2. cd git install dir
3. windows enviroment vars -> git-install-dir/bin
4. win11 with sh

# how to run ssh on windows
https://blog.csdn.net/zadaya/article/details/105456227
1. windows setting -> application -> optional 
2. add -> install ssh server
3. services -> start ssh servers
4. windows firewall

# how to establish ssh connect without password on windows 
https://blog.csdn.net/qq_40156289/article/details/120342781


# how to run java on windows 
https://www.runoob.com/java/java-environment-setup.html

# how to run yarn on windows 
+ install node 
  https://nodejs.org/en
+ install yarn by node 
  https://blog.csdn.net/qq_38179971/article/details/103452118
+ windows 系统首次使用npm安装yarn后，运行yarn命令报错
1. win+R打开PowerShell，管理员身份运行
2. 输入 set-ExecutionPolicy RemoteSigned 然后回车；
3. 输入 A 然后回车
   
+ 'cross-env' 不是内部或外部命令，也不是可运行的程序
  https://blog.csdn.net/weixin_40816738/article/details/103383001

# download baidu wenku
http://leyuanxm.top/

# multi desktop
+ new desktop
按下键盘“Win+Ctrl+D”可以一键生成一个新桌面。

+ switch desktop
按下“Win+Ctrl+方向键”可以快速切换这两个桌面。

# bios
+ 联想 微星 f11
+ 华硕 f12

# notion
+ 无线连接 先按fn 再按4, 快速闪再重新插 2.4Ghz

# windows 自动启动 serve_coi 源码 - 任务计划程序

不用 bat，直接让 Windows 调 python。

## 步骤

1️⃣ Win + R
 输入：

```
taskschd.msc
```

2️⃣ 点击「创建任务」

------

## 常规

- ✔ 使用最高权限运行
- ✔ 不管用户是否登录都运行（可选）

------

## 触发器

- 选择「启动时」（开机启动）
   或
- 「登录时」

建议：延迟 30 秒（更稳）

------

## 操作

程序：

```
C:\Users\你的用户名\AppData\Local\Programs\Python\Python39\python.exe
```

参数：

```
-m serve_coi
```

起始于：

```
D:\compress-movie
```