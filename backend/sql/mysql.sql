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