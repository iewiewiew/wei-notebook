
mysql -h127.0.0.1 -uroot -p123456
mysql --host=127.0.0.1 --user=root --password=123456 dbname


-- ---------------------------------------------------


-- trim([remstr from] str)函数用于返回删除字符串 str 两侧所有 remstr 字符串之后的子串，remstr 默认为空格
select trim( ' 左右有空格 '), trim( '-'from'--左右有空格--' );

-- lpad(str,len,padstr)函数表示字符串 str 的左侧使用 padstr 进行填充，直到长度为 len
-- rpad(str,len,padstr)函数表示在字符串 str 的右侧使用 padstr 进行填充，直到长度为 len
select lpad( 123, 6, '0'), lpad( 123, 2, '0'), rpad( 123, 6, '0'), rpad( 123, 2, '0');

-- repeat(str,count)函数用于将字符串 str 复制 count 次并返回结果
select repeat( '', 5);

select
    t.TABLE_NAME as 表名,
    t.COLUMN_NAME as 字段名,
    t.COLUMN_TYPE as 数据类型,
    case ifnull(t.COLUMN_DEFAULT,'Null')
        when '' then '空字符串'
        when 'Null' then 'NULL'
        else t.COLUMN_DEFAULT end as 默认值,
    case t.IS_NULLABLE when 'YES' then '是' else '否' end as 是否允许为空,
    t.COLUMN_COMMENT as 字段说明
from information_schema.COLUMNS t
where t.TABLE_SCHEMA='dbname';

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
select uuid();

-- 生成去掉 - 的 uuid
select replace(uuid(),"-","") as uuid;

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
select * into outfile '/Users/menghuawei/IdeaProjects/my-project/wei-notebook/.tmp/file.sql' from dbname.t_table_info;

SHOW VARIABLES LIKE 'config_file';

show variables like '%datadir%';


-- ---------------------------------------------------

-- 查看所有变量
show variables;
show variables like 'innodb_buffer_pool_size';

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
select count(*) as missing_count
from t_table_info
where your_column is null;

-- 删除具有缺失值的行
delete from t_table_info
where your_column is null;

-- 用平均值填充缺失值
update t_table_info
set your_column = (SELECT AVG(your_column) FROM t_table_info WHERE your_column IS NOT NULL)
WHERE your_column IS NULL;

-- 统计重复行
select your_column, count(*)
from t_table_info
group by your_column
having count(*) > 1;

-- 删除重复行
WITH DuplicateCTE AS (
    select your_column, ROW_NUMBER() OVER (PARTITION BY your_column ORDER BY your_column) AS row_num
    FROM t_table_info
)
delete from DuplicateCTE
where row_num > 1;

-- 将列值转换为大写
update t_table_info
set your_column = upper(your_column);

-- 去除前导和尾随空格
update t_table_info
set your_column = trim(your_column);

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
select date, sales,
       sum(sales) OVER (ORDER BY date) AS running_total
FROM sales_data;

-- 2 公共表表达式（CTEs）CTE（Common Table Expressions，公共表表达式）是一种在SQL查询中创建临时结果集的方法，可以被多次引用，提高查询的可读性和可维护性。以下是如何使用CTE计算每个产品类别的总收入的示例。
WITH category_revenue AS (
    select category, sum(revenue) as total_revenue
    from sales
    group by category
)
select * from category_revenue;

-- 3 递归查询 递归查询能够帮助分析师遍历层次化数据结构，如组织图或物料清单。假设这里有一个表示员工关系的表，想查找某个经理的所有下属：
WITH RECURSIVE subordinates AS (
    select employee_id, name, manager_id
    from employees
    where manager_id = 'manager_id_of_interest'
    UNION ALL
    select e.employee_id, e.name, e.manager_id
    from employees e
    join subordinates s on e.manager_id = s.employee_id
)
select * from subordinates;

-- 4 透视表 透视表将行转换为列，以表格形式汇总数据。比如，有一个包含销售数据的表格，想通过数据透视来显示每个产品在不同月份的总销售额：
select *
from (
         select product, month, sales
         from sales_data
     ) as source_table
    PIVOT (
              SUM(sales)
              FOR month IN ('Jan', 'Feb', 'Mar', 'Apr', 'May')
          ) AS pivot_table;

-- 5 分析函数 分析函数根据一组记录计算汇总值。例如，可以使用 ROW_NUMBER() 函数为数据集中的每条记录分配唯一的行号。
select customer_id, order_id,
       ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS order_rank
FROM orders;


-- ---------------------------------------------------


create TABLE employees (
     employee_id INT PRIMARY KEY,
     employee_name VARCHAR(100),
     salary DECIMAL(10, 2)
);

-- RANK() 函数为结果集的分区中的每一行分配一个排名，行的等级由一加上前面的等级数指定。
-- 首先，PARTITION BY 子句将结果集划分为分区。RANK()功能在分区内执行，并在跨越分区边界时重新初始化。
-- 其次，ORDER BY 子句按一个或多个列或表达式对分区内的行进行排序。
create TABLE rankDemo (
    val INT
);

insert into rankDemo(val) values(1),(2),(2),(3),(4),(4),(5);

-- 第二行和第三行具有相同的关系，因此它们获得相同的等级2。 第四行具有等级4，因为RANK()功能跳过等级3。
select val, RANK() OVER (ORDER BY val) my_rank FROM rankDemo;

-- RANK()：这是排名函数本身，根据指定的条件为每一行分配一个排名。排名是根据结果集中行的顺序确定的。
-- OVER()：这个子句定义了排名的窗口或分区。它允许您指定行的顺序和数据的分区方式。在RANK()函数的上下文中，通常使用ORDER BY子句在OVER()子句中定义排序条件。
select employee_id, employee_name, salary, RANK() OVER (ORDER BY salary DESC) AS my_rank FROM employees;

create TABLE employees (
       employee_id INT PRIMARY KEY,
       employee_name VARCHAR(100),
       salary DECIMAL(10, 2)
);

insert into employees (employee_id, employee_name, salary)
values
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

use information_schema;
select * from COLLATIONS where CHARACTER_SET_NAME="utf8";

-- 查看数据库编码
SHOW create DATABASE dbname;

-- 查看表编码
SHOW create TABLE dbname.t_table_info;

-- 查看字段编码
SHOW FULL COLUMNS FROM dbname.t_table_info;

-- 修改数据库字符集
ALTER DATABASE dbname DEFAULT CHARACTER SET utf8mb4;


-- ---------------------------------------------------


mysql 修改 root 用户密码
mysql -u root -p
ALTER USER 'root'@'localhost' IDENTIFIED BY '123456';
FLUSH PRIVILEGES;


-- ---------------------------------------------------


-- SQL求解连续活跃天数问题
-- 数据定义
create TABLE OccurrenceDays (
    uid VARCHAR(100),
    dt DATE
 );

insert into OccurrenceDays (uid, dt) values
('1234567890', '2023-04-01'),
('1234567890', '2023-04-02'),
('1234567890', '2023-04-03'),
('1234567890', '2023-04-05'),
('1234567890', '2023-04-06'),
('1234567890', '2023-04-07'),
('1234567890', '2023-04-10'),
('1234567890', '2023-04-11'),
('9876543210', '2023-04-02'),
('9876543210', '2023-04-03'),
('9876543210', '2023-04-04');

-- 查询SQL: (RankedDays,GroupedDays,ConsecutiveDetails可以看做是一个临时表)
-- ROW_NUMBER() OVER (PARTITION BY uid ORDER BY dt): 这部分是为每个用户的每个日期分配一个序号，序号是根据日期顺序递增的。
-- DATE_SUB(dt, INTERVAL ... DAY): 通过从每个日期减去其行号，我们创建了一个分组标识符grp。对于连续的日期，这将产生相同的grp值，因为日期之间的差异将等于行号之间的差异。
WITH RankedDays AS (
select
        uid,
        dt,
date_sub(dt, interval ROW_NUMBER() OVER (PARTITION BY uid order by dt) DAY) AS grp
FROM
        OccurrenceDays
),
GroupedDays AS (
select
        uid,
min(dt) as start_dt,
max(dt) as end_dt,
count(*) as consecutive_days
from
        RankedDays
group by
        uid, grp
having
count(*) > 1
),
ConsecutiveDetails AS (
select
        g.uid,
        g.consecutive_days,
        g.start_dt,
        g.end_dt,
group_concat(od.dt order by od.dt separator ',') as consecutive_details
from
        GroupedDays g
join
        OccurrenceDays od on g.uid = od.uid and od.dt between g.start_dt and g.end_dt
group by
        g.uid, g.consecutive_days, g.start_dt, g.end_dt
)
select
    uid,
    consecutive_days,
date_format(start_dt, '%Y%m%d') as first_discovery_date,
date_format(end_dt, '%Y%m%d') as last_discovery_date,
    consecutive_details
from
    ConsecutiveDetails
order by
    uid, start_dt;



-- ---------------------------------------------------


-- 使用 COALESCE 从多个字段中选取非 NULL 值
SELECT COALESCE(column1, column2, column3) AS result
FROM table_name;

-- 用 COALESCE 设置默认值。如果 price 列中有 NULL 值,COALESCE 会将其替换为 0。
SELECT name, COALESCE(price, 0) AS price
FROM products;

-- 在 UPDATE 语句中使用 COALESCE。如果 email 列中有 NULL 值,COALESCE 会将其更新为 'default@example.com'。
UPDATE users
SET email = COALESCE(email, 'default@example.com')
WHERE user_id = 123;

-- 在 CASE 语句中使用 COALESCE。如果 price 列中有 NULL 值,COALESCE 会用 discount_price 列的值替换它,否则使用原有的 price 值。
SELECT name,
       CASE
          WHEN price IS NULL THEN COALESCE(discount_price, 0)
          ELSE price
       END AS final_price
FROM products;


-- ---------------------------------------------------


-- 查找重复数据
SELECT username, email, COUNT(*) FROM users GROUP BY username, email HAVING COUNT(*) > 1;

-- 查找唯一数据
SELECT DISTINCT username, email FROM users;

-- 删除重复数据
DELETE FROM users
WHERE id NOT IN (
    SELECT MIN(id)
    FROM users
    GROUP BY username, email
);

WITH CTE AS (
    SELECT
        id,
        username,
        email,
        ROW_NUMBER() OVER(PARTITION BY username, email ORDER BY id) AS row_num
    FROM users
)
DELETE FROM users
WHERE id IN (
    SELECT id FROM CTE WHERE row_num > 1
);

-- 使用唯一约束
ALTER TABLE users ADD CONSTRAINT UC_UsernameEmail UNIQUE(username, email);

SELECT
    a.THREAD_OS_ID,
    b.id,
    b.USER,
    b.HOST,
    b.db,
    b.INFO
FROM
    PERFORMANCE_SCHEMA.THREADS a
JOIN
    information_schema.PROCESSLIST b ON b.id = a.processlist_id;

SELECT * FROM information_schema.PROCESSLIST LIMIT 1;

SELECT * FROM performance_schema.threads;


-- ---------------------------------------------------


CREATE database if NOT EXISTS `dbname` default character set utf8mb4 collate utf8mb4_unicode_ci;
use `dbname`;
CREATE TABLE person(
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY comment '主键',
    person_id tinyint not null comment '用户id',
    person_name VARCHAR(200) comment '用户名称',
    gmt_create datetime comment '创建时间',
    gmt_modified datetime comment '修改时间'
) comment '人员信息表';

insert into person values(1, 1,'user_1', NOW(), now());

select (@i:=@i+1) as rownum, person_name from person, (select @i:=100) as init;
set @i=1;

-- 运行下面的 sql，连续执行 20 次，就是 2 的 20 次方约等于 100w 的数据；执行 23 次就是 2 的 23 次方约等于 800w , 如此下去即可实现千万测试数据的插入。
insert into person(id, person_id, person_name, gmt_create, gmt_modified)
select @i:=@i+1,
left(rand()*10,10) as person_id,
concat('user_',@i%2048),
date_add(gmt_create,interval + @i*cast(rand()*100 as signed) SECOND),
date_add(date_add(gmt_modified,interval +@i*cast(rand()*100 as signed) SECOND), interval + cast(rand()*1000000 as signed) SECOND)
from person;

-- 或者
insert into person(id, person_id, person_name, gmt_create, gmt_modified)
select @i:=@i+1,
left(rand()*10,10) as person_id,
concat('user_',@i),
date_add(gmt_create,interval + @i*cast(rand()*100 as signed) SECOND),
date_add(date_add(gmt_modified,interval +@i*cast(rand()*100 as signed) SECOND), interval + cast(rand()*1000000 as signed) SECOND)
from person;

select * from person;
select count(*) from person;
-- 从第 21 条开始，获取 10 条数据
SELECT * FROM person ORDER BY id LIMIT 20, 10;
SELECT * FROM person ORDER BY id LIMIT 10000, 100;

truncate person;


-- ---------------------------------------------------


-- in 条件过多的解决方式
select * from dbname.t_table_info where id in (1, 2)
union all
select * from dbname.t_table_info where id in (3, 4);


-- ---------------------------------------------------


-- 行转列-多列一一对应

--建表语句
CREATE TABLE IF NOT EXISTS t_delivery_orders
(
    rider_id      VARCHAR(255),    -- 骑手ID
    order_id      VARCHAR(255),    -- 订单ID
    goods_type    VARCHAR(255),    -- 物品类型
    delivery_time VARCHAR(255),    -- 送达时间
    customer_id   VARCHAR(255),    -- 客户ID
    distance      DECIMAL(10, 2),  -- 配送距离，单位可以是公里或英里
    payment       DECIMAL(10, 2)   -- 支付金额，骑手的配送费用
) COMMENT '骑手配送订单表';

--插入数据
INSERT INTO t_delivery_orders VALUES
('r001', '0001', '食品', '2024-01-01 08:30:00','c001',8.05,7.50),
('r002', '0002', '酒水', '2024-01-01 08:43:00','c003',3.01,13.00),
('r003', '0003', '食品', '2024-01-01 09:15:00','c004',4.12,3.50),
('r002', '0004', '文件', '2024-01-01 09:21:00','c005',10.98,15.00),
('r001', '0005', '食品', '2024-01-01 09:30:00','c007',2.32,5.00),
('r002', '0006', '食品', '2024-01-01 09:47:00','c002',0.78,5.00),
('r003', '0007', '文件', '2024-01-01 10:21:00','c010',8.11,8.00),
('r001', '0008', '酒水', '2024-01-01 11:56:00','c023',4.35,15.00),
('r002', '0009', '电子产品', '2024-01-01 12:30:00','c031',5.05,9.50),
('r002', '0010', '文件', '2024-01-01 13:30:00','c001',6.05,7.00);

-- 合并列
select rider_id,
       delivery_time,
       order_id,
       concat_ws(',', delivery_time, order_id, distance, payment) as col_list
from t_delivery_orders;


-- ---------------------------------------------------


-- 正则表达式
SELECT email FROM users WHERE email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
SELECT phone FROM users WHERE phone REGEXP '^1[3-9][0-9]{9}$';
SELECT id_card FROM users WHERE id_card REGEXP '^[1-9][0-9]{5}(18|19|20)[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])[0-9]{3}[0-9Xx]$';


-- ---------------------------------------------------


-- 查看时区 返回 SYSTEM，这表明 MySQL 当前的时区设置为系统时区
SELECT @@global.time_zone, @@session.time_zone;

-- 更改全局时区
SET GLOBAL time_zone = '+08:00';
SET GLOBAL time_zone = 'Asia/Shanghai';

-- 更改会话时区
SET time_zone = '+08:00';
SET time_zone = 'Asia/Shanghai';

-- 验证
SELECT NOW(), UTC_TIMESTAMP();