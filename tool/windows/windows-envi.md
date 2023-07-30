
## jdk
Red Hat build of OpenJDK Download | Red Hat Developer​
https://developers.redhat.com/products/openjdk/download

## idea - crack

### 插件
- atom material icons - crack
- material theme - crack
- restful fast request - crack
- jrebel 4.2 - crack
- mybatisX
- mybatis log free
- maven helper

## git

https://git-scm.com/download/win

## ssh    

https://blog.csdn.net/qq_43193386/article/details/120194085#:~:text=Windows%E4%B8%8B%E7%94%9F%E6%88%90ssh%E5%AF%86%E9%92%A5%EF%BC%8C%E5%B9%B6%E7%94%A8ssh%E5%85%8D%E5%AF%86%E8%AE%BF%E9%97%AELinux%E6%9C%8D%E5%8A%A1%E5%99%A8%201%201%20%E5%A6%82%E6%9E%9C%E9%9C%80%E8%A6%81%E7%94%A8ssh%E7%9A%84%E6%96%B9%E5%BC%8F%E5%8E%BB%E8%AE%BF%E9%97%AELinux%E6%9C%8D%E5%8A%A1%E5%99%A8%EF%BC%8C%E5%88%99%E9%9C%80%E8%A6%81%E5%9C%A8%E8%87%AA%E5%B7%B1%E7%94%B5%E8%84%91%E4%B8%8A%E7%94%9F%E6%88%90%E4%B8%80%E5%AF%B9%E5%85%AC%E9%92%A5%E5%92%8C%E7%A7%81%E9%92%A5%EF%BC%8C%E5%BA%94%E8%AF%A5%E6%98%AFrsa%E7%9A%84%E5%85%AC%E9%92%A5%E5%92%8C%E7%A7%81%E9%92%A5%E3%80%82,2%202%20%E7%94%9F%E6%88%90%E6%96%B9%E5%BC%8F%EF%BC%9A%E6%89%93%E5%BC%80Windows%E7%9A%84cmd%EF%BC%8C%E8%BE%93%E5%85%A5Windows%E5%91%BD%E4%BB%A4%E8%A1%8C%E5%91%BD%E4%BB%A4ssh-keygen%EF%BC%88%E8%B2%8C%E4%BC%BC%E4%B9%9F%E5%8F%AF%E4%BB%A5%E8%BE%93%E5%85%A5ssh-keygen%20-t%20rsa%EF%BC%89%EF%BC%9A

## navicate - 16 crack   mysql/redis

## windows 安装 mysql
https://blog.csdn.net/weixin_41842236/article/details/125864417
+ 下载 mysql for windows.zip
+ 配置环境变量 MYSQL_HOME 指向解压目录
+ 配置环境变量 PATH, 添加 %MYSQL_HOME%\bin
+ 在 Mysql 下新建 my.ini

```properties
[mysql]
# 设置mysql客户端默认字符集
default-character-set=utf8
[mysqld]
#设置3306端口
port = 3336
# 设置mysql的安装目录
basedir=C:\Program Files\mysql-5.7.40-winx64
# 设置mysql数据库的数据的存放目录
datadir=C:\Program Files\mysql-5.7.40-winx64\data
# 允许最大连接数
max_connections=200
# 服务端使用的字符集默认为8比特编码的latin1字符集
character-set-server=utf8
# 创建新表时将使用的默认存储引擎
default-storage-engine=INNODB 

sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
```

+ 管理员运行 cmd, `mysqld --install`
+ `mysqld --initialize-insecure --user=mysql;` 初始化数据文件
+ `net start mysql` 启动服务; 拒绝访问则使用 `net start MYSQL`
+ `mysql –u root –p` 进入mysql管理界面, 密码默认为空
+ `create user 'root'@'%' identified by 'newPwd';` 修改密码, 并允许用户远程访问
+ `GRANT privileges[SELECT,INSERT,ALL...] ON databasename.tablename[or *] TO 'username'@'%'` 为远程用户授权 



## Windows 安装 mongoldb

使用 .msi 安装

+ Service Configuration 选择 `Run service as Network Service User`
+ 取消勾选 `Install MongoDB Compass`
+ Add Database
+ Add User & Pwd
+ Add Collection
+ Add Init Data



## Windows 安装 Nginx







