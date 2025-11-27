
# oracle limit  该怎么写

## Oracle 11g 及之前版本无 LIMIT，需要用 ROWNUM： 取前 10 条
SELECT *
FROM (
    SELECT v.*, ROWNUM rn
    FROM V_KMBT1_REC_NOTDEALITEM v
    WHERE ROWNUM <= 10
)

## Oracle 通用分页写法（支持 offset/page）

比如：第 1 页，每页 10 条

SELECT *
FROM (
    SELECT t.*, ROWNUM rn
    FROM (
        SELECT v.*
        FROM V_KMBT1_REC_NOTDEALITEM v
        ORDER BY v.ID   -- 按需要排序
    ) t
    WHERE ROWNUM <= 10
)
WHERE rn > 0;

## Oracle 12c 及以上 直接使用：

SELECT v.*
FROM V_KMBT1_REC_NOTDEALITEM v
ORDER BY v.ID
FETCH FIRST 10 ROWS ONLY;

### 分页示例：

SELECT v.*
FROM V_KMBT1_REC_NOTDEALITEM v
ORDER BY v.ID
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;