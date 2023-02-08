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

## rename table
ALTER TABLE old_table_name RENAME TO new_table_name;

## rename column
ALTER  TABLE 表名 CHANGE [column] 旧字段名 新字段名 新数据类型;	

## change column default
ALTER TABLE table2
    ALTER COLUMN column2 SET DEFAULT 0;

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

## delete column
ALTER TABLE <表名> DROP <字段名>；

## mysql json json_agg
https://dev.mysql.com/doc/refman/5.7/en/aggregate-functions.html#function_json-objectagg


## 不识别mapper.xml文件中的sql的表名和字段，无法点击表名链接到数据源_VictoryVivan的博客-程序员宅基地
https://www.cxyzjd.com/article/qq_24057133/105679794