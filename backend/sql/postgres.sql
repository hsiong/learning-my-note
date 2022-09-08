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
