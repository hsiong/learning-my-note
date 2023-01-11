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
    create_time timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_by   varchar(32),
    update_time timestamp            DEFAULT CURRENT_TIMESTAMP,
    time        varchar(32) NOT NULL comment 'column_comment',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT ='table_comment';

## change column default
ALTER TABLE table2
    ALTER COLUMN column2 SET DEFAULT 0;

## set column not null
ALTER TABLE table2 MODIFY column2 column column_type NOT NULL;