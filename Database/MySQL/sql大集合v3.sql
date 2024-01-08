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

-- show profiles\G;


-- ---------------------------------------------------


-- 查看 binlog 文件列表
SHOW BINARY LOGS;

-- 查看 binlog 文件内容
SHOW BINLOG EVENTS;


-- ---------------------------------------------------


-- 查看安全文件位置
SHOW VARIABLES LIKE 'secure_file_priv';

set secure_file_priv = '/Users/menghuawei/IdeaProjects/my-project/wei-notebook/.tmp/';
select * INTO OUTFILE '/Users/menghuawei/IdeaProjects/my-project/wei-notebook/.tmp/file.sql' from dbname.t_table_info;

SHOW VARIABLES LIKE 'config_file';

show variables like '%datadir%';


-- ---------------------------------------------------


-- 数据库允许的最大连接数
show variables like 'max_connections';

-- 数据库当前的连接数
show global status like 'Threads_connected';

-- 列出MySQL服务器运行各种状态值
show global status;

-- 并发请求数量
show global status like 'Threads_running';

-- 查看session的连接号
select connection_id();

-- show master status \G;
-- show slave status;
-- show slave status \G;


-- ---------------------------------------------------


-- 索引缓冲区命中率（InnoDB Buffer Pool Hit Rate）= Innodb_buffer_pool_reads/Innodb_buffer_pool_read_requests
SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_reads';
SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_read_requests';

-- 线程缓存命中率（Thread Cache Hit Rate）= (1 - Threads_created / Connections) * 100
SHOW GLOBAL STATUS LIKE 'Threads_created';
SHOW GLOBAL STATUS LIKE 'Connections';

-- 表缓存命中率（Table Cache Hit Rate）= (1 - Opened_tables / Open_tables) * 100
SHOW GLOBAL STATUS LIKE 'Opened_tables';
SHOW GLOBAL STATUS LIKE 'Open_tables';

-- 查询缓存命中率（Query Cache Hit Rate）= Qcache_hits / Com_select * 100
SHOW GLOBAL STATUS LIKE 'Qcache_hits';
SHOW GLOBAL STATUS LIKE 'Com_select';


-- ---------------------------------------------------


-- 统计表中的缺失值数量
SELECT COUNT(*) AS missing_count
FROM t_table_info
WHERE your_column IS NULL;

-- 删除具有缺失值的行
DELETE FROM t_table_info
WHERE your_column IS NULL;

-- 用平均值填充缺失值
UPDATE t_table_info
SET your_column = (SELECT AVG(your_column) FROM t_table_info WHERE your_column IS NOT NULL)
WHERE your_column IS NULL;

-- 统计重复行
SELECT your_column, COUNT(*)
FROM t_table_info
GROUP BY your_column
HAVING COUNT(*) > 1;

-- 删除重复行
WITH DuplicateCTE AS (
    SELECT your_column, ROW_NUMBER() OVER (PARTITION BY your_column ORDER BY your_column) AS row_num
    FROM t_table_info
)
DELETE FROM DuplicateCTE
WHERE row_num > 1;

-- 将列值转换为大写
UPDATE t_table_info
SET your_column = UPPER(your_column);

-- 去除前导和尾随空格
UPDATE t_table_info
SET your_column = TRIM(your_column);

-- 将字符串列转换为整数
ALTER TABLE t_table_info
ALTER COLUMN your_column TYPE INTEGER
USING your_column::INTEGER;

-- 将字符串日期列转换为日期类型
ALTER TABLE t_table_info
ALTER COLUMN your_date_column TYPE DATE
USING TO_DATE(your_date_column, 'YYYY-MM-DD');


-- ---------------------------------------------------


-- 1 窗口函数 窗口函数是指在SQL查询中对一组相关行进行聚合或运算操作的函数。窗口函数可以在不改变基本表的情况下，为查询结果添加额外的计算列。举个例子，使用SUM()函数与OVER()子句计算销售额的运行总和。
SELECT date, sales,
       SUM(sales) OVER (ORDER BY date) AS running_total
FROM sales_data;

-- 2 公共表表达式（CTEs）CTE（Common Table Expressions，公共表表达式）是一种在SQL查询中创建临时结果集的方法，可以被多次引用，提高查询的可读性和可维护性。以下是如何使用CTE计算每个产品类别的总收入的示例。
WITH category_revenue AS (
    SELECT category, SUM(revenue) AS total_revenue
    FROM sales
    GROUP BY category
)
SELECT * FROM category_revenue;

-- 3 递归查询 递归查询能够帮助分析师遍历层次化数据结构，如组织图或物料清单。假设这里有一个表示员工关系的表，想查找某个经理的所有下属：
WITH RECURSIVE subordinates AS (
    SELECT employee_id, name, manager_id
    FROM employees
    WHERE manager_id = 'manager_id_of_interest'
    UNION ALL
    SELECT e.employee_id, e.name, e.manager_id
    FROM employees e
    JOIN subordinates s ON e.manager_id = s.employee_id
)
SELECT * FROM subordinates;

-- 4 透视表 透视表将行转换为列，以表格形式汇总数据。比如，有一个包含销售数据的表格，想通过数据透视来显示每个产品在不同月份的总销售额：
SELECT *
FROM (
         SELECT product, month, sales
         FROM sales_data
     ) AS source_table
    PIVOT (
              SUM(sales)
              FOR month IN ('Jan', 'Feb', 'Mar', 'Apr', 'May')
          ) AS pivot_table;

-- 5 分析函数 分析函数根据一组记录计算汇总值。例如，可以使用 ROW_NUMBER() 函数为数据集中的每条记录分配唯一的行号。
SELECT customer_id, order_id,
       ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS order_rank
FROM orders;


-- ---------------------------------------------------


CREATE TABLE employees (
     employee_id INT PRIMARY KEY,
     employee_name VARCHAR(100),
     salary DECIMAL(10, 2)
);

-- RANK() 函数为结果集的分区中的每一行分配一个排名，行的等级由一加上前面的等级数指定。
-- 首先，PARTITION BY 子句将结果集划分为分区。RANK()功能在分区内执行，并在跨越分区边界时重新初始化。
-- 其次，ORDER BY 子句按一个或多个列或表达式对分区内的行进行排序。
CREATE TABLE rankDemo (
    val INT
);

INSERT INTO rankDemo(val) VALUES(1),(2),(2),(3),(4),(4),(5);

-- 第二行和第三行具有相同的关系，因此它们获得相同的等级2。 第四行具有等级4，因为RANK()功能跳过等级3。
SELECT val, RANK() OVER (ORDER BY val) my_rank FROM rankDemo;

-- RANK()：这是排名函数本身，根据指定的条件为每一行分配一个排名。排名是根据结果集中行的顺序确定的。
-- OVER()：这个子句定义了排名的窗口或分区。它允许您指定行的顺序和数据的分区方式。在RANK()函数的上下文中，通常使用ORDER BY子句在OVER()子句中定义排序条件。
SELECT employee_id, employee_name, salary, RANK() OVER (ORDER BY salary DESC) AS my_rank FROM employees;

CREATE TABLE employees (
       employee_id INT PRIMARY KEY,
       employee_name VARCHAR(100),
       salary DECIMAL(10, 2)
);

INSERT INTO employees (employee_id, employee_name, salary)
VALUES
    (1, 'John Doe', 5000),
    (2, 'Jane Smith', 4500),
    (3, 'Mike Johnson', 4000),
    (4, 'Lisa Brown', 4000),
    (5, 'David Lee', 3500);


-- ---------------------------------------------------


-- 查看大小写是否敏感
-- lower_case_file_system，代表当前系统文件是否大小写敏感，只读参数，无法修改。ON 大小写不敏感，OFF 大小写敏感。
-- lower_case_table_names，代表表名是否大小写敏感，可以修改，参数有0、1、2三种。
-- 0 大小写敏感（Unix，Linux默认）
-- 1 大小写不敏感（Windows默认）
-- 2 大小写不敏感（OS X默认）
-- 修改大小写默认配置，在Linux系统中修改my.cnf文件，在Windows下修改my.ini文件，新增或修改以下内容。lower_case_table_names = 0 或 lower_case_table_names = 1。
show global variables like '%lower_case%';

-- 查看支持字符集
SHOW CHARACTER SET;
SHOW CHARACTER SET LIKE "utf8%";
SHOW VARIABLES LIKE 'character_set_%';

use information_schema;
select * from CHARACTER_SETS;

-- 查看支持的字符序
SHOW COLLATION;

USE information_schema;
SELECT * FROM COLLATIONS WHERE CHARACTER_SET_NAME="utf8";

-- 查看数据库编码
SHOW CREATE DATABASE dbname;

-- 查看表编码
SHOW CREATE TABLE dbname.t_table_info;

-- 查看字段编码
SHOW FULL COLUMNS FROM dbname.t_table_info;

-- 修改数据库字符集
ALTER DATABASE dbname DEFAULT CHARACTER SET utf8mb4;


-- ---------------------------------------------------


mysql 修改 root 用户密码
mysql -u root -p
ALTER USER 'root'@'localhost' IDENTIFIED BY '123456';
FLUSH PRIVILEGES;