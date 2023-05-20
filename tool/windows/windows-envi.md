
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







