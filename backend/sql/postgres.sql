
-- create db demo 
CREATE DATABASE db1 WITH ENCODING 'UTF8';
-- create table demo 
DROP TABLE if exists "public"."table1";
CREATE TABLE "public"."table1"
(
    "id"          varchar(32)                                NOT NULL,
    "create_by"   varchar(32) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
    "create_at" timestamp(6)                               NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "update_by"   varchar(32) COLLATE "pg_catalog"."default",
    "update_at" timestamp(6)                                        DEFAULT CURRENT_TIMESTAMP,
    "column1"     numeric(19, 2),
    "column2"      varchar(32)                                NOT NULL,
    "column3"        varchar(16) COLLATE "pg_catalog"."default" NOT NULL,
    CONSTRAINT "table1_id_pkey" PRIMARY KEY ("id")
);

-- left join后，会默认按照关联主键来排序，但使用了order by就不再使用默认主键排序了，当order by字段的值相同时，Mysql会乱序返回。
SELECT s.total, c.config_value
FROM (SELECT t.animal_id, SUM(total) as total
      FROM t_animal_resources t
      where extract(year from patrol_time) >= 2022
      GROUP BY animal_id
      ORDER BY total desc
      limit 5) s
         LEFT JOIN t_cms_config c ON s.animal_id = c.id
ORDER BY s.total DESC

-- https://www.runoob.com/postgresql/postgresql-with.html
-- with demo
WITH
   name_for_summary_data AS (
      SELECT Statement)
   SELECT columns
   FROM name_for_summary_data
   WHERE conditions <=> (
      SELECT column
      FROM name_for_summary_data)
   [ORDER BY columns];

SELECT t.*,
       (
           WITH itg AS
                    ( SELECT i.*,  
                             (SELECT json_agg(b1.*) FROM table1 b1 WHERE b1.itg_id = i.id)  AS "boxVOList"
                      FROM table2 i WHERE i.bir_discern_id = t.id AND i.is_del = 0  )
           SELECT json_agg(itg.*)
           FROM itg
        ) AS "itgList",
       (SELECT json_agg(b1.*) FROM table1 b1 WHERE b1.bir_id = t.id) AS "boxVOList"
       FROM table3 t
;

-- comment demo
COMMENT ON COLUMN table_name.config_id IS '字典表id';

-- json_agg demo
SELECT r.*,
       (SELECT json_object_agg(d.key, d.value)
        FROM (SELECT d.*
              FROM table1 d
              WHERE d.record_id = r.id
              ORDER BY d.create_time ASC) d)  AS "detail",
       (SELECT json_agg(t.*)
        FROM (SELECT ld.id, ld.key, ld.list_id, value
              FROM table2 ld
              WHERE ld.list_id IN (SELECT l.id FROM table4 l WHERE l.record_id = r.id)
              ORDER BY ld.create_time ASC) t) AS "list"
FROM table3 r
WHERE r.id = :id;

-- partition by demo
SELECT total.*,
       (SELECT to_char(t2.create_time, 'yyyy-mm-dd') FROM table1 t2 WHERE t2.name = total.name AND t2.value = total.min limit 1) AS "minTime",
       (SELECT to_char(t3.create_time, 'yyyy-mm-dd') FROM table1 t3 WHERE t3.name = total.name AND t3.value = total.max limit 1) AS "maxTime"
FROM (
         SELECT DISTINCT s.name,
                         coalesce(min(s.value) OVER (PARTITION BY s.name), 0) AS min,
                         coalesce(max(s.value) OVER (PARTITION BY s.name), 0) AS max,
                         round(coalesce(avg(s.value) OVER (PARTITION BY s.name), 0), 2) AS avg
         FROM (
                  SELECT t.value, t.name, to_char(t.create_time, 'yyyy-mm-dd') AS time
                  FROM table1 t WHERE t.device_id IN (
                      SELECT d.id FROM table2 d WHERE d.type = 'JCQX'
                  )
                 AND t.create_time > to_timestamp(':startTime', ':dateFormat')
                 AND t.create_time <= to_timestamp(':endTime', ':dateFormat')
              ) s
     ) total;

-- add column demo
alter table table1
    add column column1 varchar(64) not null default '';
ALTER TABLE table1
    add COLUMN column1_time timestamp(6) DEFAULT CURRENT_TIMESTAMP;

-- alter column type demo
ALTER TABLE table1
    alter column1 TYPE varchar(64);

-- drop column demo
ALTER TABLE table1 drop column1;

-- alter column default demo
ALTER TABLE table2
    alter column2 SET DEFAULT 0;

-- alter column set null demo
ALTER TABLE table2
    alter column2 SET NOT NULL ;

-- add unique key demo 
alter table table1
    add unique ("column1", "column2");

-- reset seq demo
select setval('seq_name', (select max(seq_key) from table1));

-- 
GROUP BY date(t.captime)

-- string contains
-- https://blog.csdn.net/luojinbai/article/details/45461837
select position('aa' in 'abcd');

-- check null
SELECT coalesce(column1, 0) FROM table1
