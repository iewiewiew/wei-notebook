-- trim([remstr from] str)函数用于返回删除字符串 str 两侧所有 remstr 字符串之后的子串，remstr 默认为空格
select trim( ' 左右有空格 '), trim( '-'from'--左右有空格--' );

-- lpad(str,len,padstr)函数表示字符串 str 的左侧使用 padstr 进行填充，直到长度为 len
-- rpad(str,len,padstr)函数表示在字符串 str 的右侧使用 padstr 进行填充，直到长度为 len
select lpad( 123, 6, '0'), lpad( 123, 2, '0'), rpad( 123, 6, '0'), rpad( 123, 2, '0');

-- repeat(str,count)函数用于将字符串 str 复制 count 次并返回结果
select repeat( '', 5);

SELECT
    t.TABLE_NAME AS 表名,
    t.COLUMN_NAME AS 字段名,
    t.COLUMN_TYPE AS 数据类型,
    CASE IFNULL(t.COLUMN_DEFAULT,'Null')
        WHEN '' THEN '空字符串'
        WHEN 'Null' THEN 'NULL'
        ELSE t.COLUMN_DEFAULT END AS 默认值,
    CASE t.IS_NULLABLE WHEN 'YES' THEN '是' ELSE '否' END AS 是否允许为空,
    t.COLUMN_COMMENT AS 字段说明
FROM information_schema.COLUMNS t
WHERE t.TABLE_SCHEMA='dbname';

-- 把 username 相同的 password 拼接在一起
select username,group_concat(password) from dbname.demo group by username;

-- 查看指定数据库容量大小
select
    table_schema as '数据库',
    table_name as '表名',
    table_rows as '记录数',
    truncate(data_length/1024/1024, 2) as '数据容量(MB)',
    truncate(index_length/1024/1024, 2) as '索引容量(MB)'
from information_schema.tables
order by data_length desc, index_length desc;

-- 查看数据库是否支持分区
show variables like '%partition%';

-- 生成 uuid
select UUID();

-- 生成去掉 - 的 uuid
select REPLACE(UUID(),"-","") as uuid;

-- 显示哪些 SQL 线程正在运
show full processlist;
/**
ID：作为一个标识 ID，如果你打算 kill 一个 SQL，可以根据 ID 来进行。
User：当前正在执行 SQL 的用户，只显示你登录账号权限范围内能够看到的用户。
Host：显示这个语句是从哪个 ID 和端口上发出的。
db：当前线程使用的库名。
Command：连接执行的命令状态，一般是 Sleep、Query、Connect 等。
Time：状态持续的时间（单位是秒）。
State：显示当前 SQL 语句的状态，这是一个非常重要的判断标识，比如多次刷新命令时，发现 SQL 常处于 Sending data，那么这条 SQL 大概率是存在问题的。
Info：显示正在执行的 SQL 语句，这也是你能直接拿到慢 SQL 的方式。
 */


-- ---------------------------------------------------


-- 查看是否开启慢查询
show variables like '%slow%';

-- 开启慢查询
set global slow_query_log='ON';

-- 修改慢查询时间为5
set long_query_time = 5;
show global status like '%slow%';

-- 分析查询 sql 执行消耗系统资源情况
select @@profiling;

-- 打开功能
set profiling = 1;
select * from user ;

show profiles\G;