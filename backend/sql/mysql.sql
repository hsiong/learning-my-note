# mysql 数据类型
https://www.runoob.com/mysql/mysql-data-types.html

## utf8 vs utf8mb4
https://juejin.cn/post/6844903733034221576

## create DATABASE
CREATE DATABASE `mydb` CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE  `wordpress` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

## CREATE TABLE
DROP TABLE if exists table_name;
CREATE TABLE table_name
(
    id          varchar(32) NOT NULL,
    create_by   varchar(32) NOT NULL DEFAULT '',
    create_at timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_by   varchar(32),
    update_at timestamp            DEFAULT CURRENT_TIMESTAMP,
    time        varchar(32) NOT NULL comment 'column_comment',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='table_comment';

## rename database 
dump data, then drop database, create new database

## rename table
ALTER TABLE old_table_name RENAME TO new_table_name;

## rename column
ALTER  TABLE 表名 CHANGE [column] 旧字段名 新字段名 新数据类型;	
alter  table table1 change column1 column1 varchar(100) DEFAULT 1.2 COMMENT '注释'; -- 正常，此时字段名称没有改变，能修改字段类型、类型长度、默认值、注释


## change column default
ALTER TABLE table2 ALTER COLUMN column2 SET DEFAULT 0;

## change column type
ALTER TABLE table2 ALTER COLUMN column2 column2_type;

## delete column
ALTER TABLE tableName DROP columnName；

## add column
ALTER TABLE tablename ADD columnName columnType constraints;


## change column constraints
### unique
ALTER TABLE t_user MODIFY user_id INT(10) UNIQUE;
ALTER TABLE t_user CHANGE user_id user_id INT(10) UNIQUE;
ALTER TABLE t_user ADD UNIQUE(user_id);
ALTER TABLE t_user ADD UNIQUE KEY(user_id);
ALTER TABLE t_user ADD CONSTRAINT UN_ID UNIQUE(user_id);
ALTER TABLE t_user ADD CONSTRAINT UN_ID UNIQUE KEY(user_id);
ALTER TABLE t_user DROP INDEX user_id;
### not null
ALTER TABLE table2 MODIFY column2 column column_type NOT NULL;
ALTER TABLE t_user CHANGE user_id user_id INT(10) NOT NULL;
1)ALTER TABLE t_user MODIFY user_id INT(10);
2)ALTER TABLE t_user CHANGE user_id user_id INT(10);
### PRIMARY KEY 
ALTER TABLE t_user MODIFY user_id INT(10) PRIMARY KEY;
ALTER TABLE t_user CHANGE user_id user_id INT(10) PRIMARY KEY;
ALTER TABLE t_user ADD PRIMARY KEY(user_id);
ALTER TABLE t_user ADD CONSTRAINT PK_ID PRIMARY KEY(user_id);
ALTER TABLE t_user DROP PRIMARY KEY;

## mysql json json_agg
## https://dev.mysql.com/doc/refman/5.7/en/aggregate-functions.html#function_json-objectagg
SELECT a.*,
        (
            SELECT JSON_ARRAYAGG(JSON_OBJECT(
                    'create_time', i.create_time,
                    'update_time', i.update_time,
                    'id', i.id))
            FROM plan_operate_item i
            WHERE i.operate_id = a.id
        ) AS itemList
FROM plan_operate a
    ${sql}
ORDER BY a.create_time
DESC

## 不识别mapper.xml文件中的sql的表名和字段，无法点击表名链接到数据源_VictoryVivan的博客-程序员宅基地
https://www.cxyzjd.com/article/qq_24057133/105679794

## mybatis donot support json_agg
## https://blog.csdn.net/qq_44075194/article/details/126194672
adding the annotation @InterceptorIgnore(tenantLine = "true") to the mapper may solve this problem .


## case when 
SELECT OrderID, Quantity,
CASE
    WHEN Quantity > 30 THEN "The quantity is greater than 30"
    WHEN Quantity = 30 THEN "The quantity is 30"
    ELSE "The quantity is under 30"
END
FROM OrderDetails;

# index
ALTER table plan_task_worker ADD INDEX plan_task_worker_index(worker_id, plan_id);
DROP INDEX plan_task_worker_index ON plan_task_worker;

# show mysql version 
show variables like '%version%' 

# character set & COLLATE
## "Incorrect string value" when trying to insert UTF-8 
-- Change a database
ALTER DATABASE [database_name] 
  CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci; 
-- Change a table
ALTER TABLE [table_name] 
  CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 
-- Change a column
ALTER TABLE [table_name] 
  CHANGE [column_name] [column_name] VARCHAR(255) 
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

## batch modify table collate
### utf8mb4_unicode_ci or utf8mb4_general_ci
### exec the code then paste & exec the result 
SELECT
	CONCAT(
		'ALTER TABLE ',
		TABLE_NAME,
		' CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;'
	)
FROM
	information_schema.`TABLES`
WHERE
	TABLE_SCHEMA = 'DATABASE_NAME';


## this is incompatible with DISTINCT
## https://stackoverflow.com/questions/36829911/how-to-resolve-order-by-clause-is-not-in-select-list-caused-mysql-5-7-with-sel
## http://xstarcd.github.io/wiki/MySQL/MySQL-sql-mode.html
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

# Mysql Thread
# https://www.cnblogs.com/caoshousong/p/10845396.html
## show thread
show status like  'Threads%';

## show max thread 
show variables like '%max_connection%'; 

## set max thread
set global max_connections=1000;        重新设置最大连接数

## change password
set PASSWORD=PASSWORD('newPwd');
plush privileges;

## remote connect
use mysql;
select host,user from user;
create user 'root'@'%' identified by 'newPwd';

## grant remote user db
GRANT privileges[SELECT,INSERT,ALL...] ON databasename.tablename[or *] TO 'username'@'%'


## SHOW lower case
show global variables like '%lower_case%';

## MySQL 报Public Key Retrieval is not allowed 错误问题解决
https://blog.csdn.net/qq_48234103/article/details/120769173

docker exec -it mysql /bin/bash
mysql -u root -p
use mysql
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '密码';


## MySQL数据库中删除not null约束的方法
ALTER TABLE 表名 MODIFY COLUMN 字段名 column_type NULL

## delete foreign key
alter table tableName drop foreign key foreignKeyName;

## multi structure
SELECT *,
       (
           SELECT JSON_ARRAYAGG(JSON_OBJECT(
                   'create_time', i.create_time,
                   'create_by', i.create_by,
                   'update_time', i.update_time,
                   'update_by', i.update_by,
                   'del_flag', i.del_flag,
                   'tenant_id', i.tenant_id,
                   'name', i.name,
                   'sort', i.sort,
                   'level', i.level,
                   'id', i.id,
                   'childrenList', (SELECT JSON_ARRAYAGG(JSON_OBJECT(
                           'create_time', t.create_time,
                           'create_by', t.create_by,
                           'update_time', t.update_time,
                           'update_by', t.update_by,
                           'del_flag', t.del_flag,
                           'tenant_id', t.tenant_id,
                           'name', t.name,
                           'sort', t.sort,
                           'level', t.level,
                           'id', t.id
                       ))
                                    FROM maintenance_catalog t
                                    WHERE t.parent_id = i.id)
               ))
           FROM maintenance_catalog i
           WHERE i.parent_id = g.id
       ) AS childrenList
FROM maintenance_catalog g
WHERE g.level = 0;

# window function
SELECT DISTINCT 
       t.project_name, 
MAX(t.type) OVER (PARTITION BY t.id)
FROM tableName;

# distinguish varchar/char/text
https://joyohub.com/2020/07/04/mysql/mysql-string/

Considering system performance, we do not suggest using text TYPE in mysql

Query effiency: char > varchar > text

# procedure
SET @a := 'creator';
CALL calculate_max_identity(@a, 'tech');
SELECT @a AS num_out;

-- while has a select statement, call process in function would throw error
DROP PROCEDURE calculate_max_identity;
CREATE PROCEDURE calculate_max_identity(INOUT a VARCHAR(255), IN b VARCHAR(255))
BEGIN
    SELECT b AS 'num'; 
    IF b = 'project' THEN
        SET a := concat(1, b, a);
    ELSEIF b = 'tech' & a != 'project' THEN
        SET a := concat(2, b, a);
    ELSEIF b = 'creator' & a != 'project' & a != 'tech'  THEN
        SET a := concat(3, b, a);
    ELSE
        SET a := concat(4, b, a);
    END IF;
END;

## MySQL 存储过程传参之in, out, inout 参数用法
https://blog.csdn.net/guugle2010/article/details/40513347
INOUT, 理解为指针, 入参同时改变自身的值

# function
DROP FUNCTION max_identity;
CREATE FUNCTION max_identity(column_name VARCHAR(255))
    RETURNS VARCHAR(255)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE b varchar(255);
    DECLARE a varchar(255) DEFAULT '';
    DECLARE cur CURSOR FOR SELECT column_name FROM maintenance_project_person;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    SET @max_score := '';

    OPEN cur;
    read_loop:
    LOOP
        FETCH cur INTO b;
        IF done THEN
            LEAVE read_loop;
        END IF;

        CALL calculate_max_identity(a, b);

    END LOOP;
    CLOSE cur;

    SET a = @max_score;

    RETURN a;
END;

SELECT max_identity(p.type)
FROM maintenance_project_person p

> [01000][1265] Data truncated for column 'max_identity(p.type)' at row 1

# mysql if
https://blog.51cto.com/u_13236892/5751254

# mysql code comment
单行注释符"#"，#注释符后直接加注释内容 #这里是注释内容，查询database_name库table_name表里面的数据 ...
单行注释符"--"， -- 注释符后需要加一个空格，注释才能生效 ...
多行注释符"/* */",/*用于注释内容的开头，*/用于注释内容的结尾  
> 注意, 在mybatis mapper中, 只能使用多行注释

## query table info

SELECT TABLE_NAME, TABLE_COMMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dms_app_dev';

## MySQL 运算符
https://www.runoob.com/mysql/mysql-operator.html

+ - * / %

## Mysql Date
### date_add

select date_add(now(), interval 1 day); - 加1天
 
select date_add(now(), interval 1 hour); -加1小时
 
select date_add(now(), interval 1 minute); - 加1分钟
 
select date_add(now(), interval 1 second); -加1秒
 
select date_add(now(), interval 1 microsecond);-加1毫秒
 
select date_add(now(), interval 1 week);-加1周
 
select date_add(now(), interval 1 month);-加1月
 
select date_add(now(), interval 1 quarter);-加1季
 
### date_sub()
