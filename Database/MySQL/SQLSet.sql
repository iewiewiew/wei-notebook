/**
数据准备

一、ddl（data define language）数据定义语言
	1、库管理
		1、库的创建（create）
		2、库的修改（alter）
		3、库的删除（drop）
	2、表管理
		1、表的创建（create）
		2、表的修改（alter）
		3、表的删除（drop）
		4、表的查询（desc）
		5、复制表数据
		6、重命名表
		7、清空表
		
二、dml（data manipulation language）数据操作语言
	1、增（insert）
	2、删（delete）
	3、改（update）
		
三、dql（data query language）数据查询语言
	1、基础查询（select）
	2、条件查询（where）
	3、分页查询（limit）
	4、连接查询（join）
	5、子查询(in)
	6、排序查询（order by）
	7、分组查询（group by）
	8、时间查询
	9、其它查询

四、dcl（data control language）数据控制语言
	1、创建用户（create）
	2、用户授权（grant）
	3、撤销权限（revoke）
	4、查看权限（show）
	5、删除用户（drop）
	6、修改用户（update）

五、索引操作
	1、索引创建（create）
	2、索引删除（drop）
	3、索引查询（show）
	
六、存储过程
	1、简单查询
	2、批量插入数据

七、相关函数
	1、时间函数
	2、随机数
	3、其它函数
		
八、其它内容
	1、查看数据库大小
	2、设置变量
	3、系统变量
	4、explain
	5、批量删除表
**/

mysql -h127.0.0.1 -uroot -p123456
mysql --host=127.0.0.1 --user=root --password=123456 dbname


-- ===============================================================================================
-- 数据准备（前提：先执行下方创库创表 sql）
INSERT INTO `dbname`.`t_table_info`(`id`, `name`, `age`, `sex`, `job`, `json_set`, `text`, `blob`, `create_time`, `update_time`) VALUES (1, '张三', 1, '男', '律师', '{\"uuid\":\"123\"}', '文本1', NULL, now(), now());
INSERT INTO `dbname`.`t_table_info`(`id`, `name`, `age`, `sex`, `job`, `json_set`, `text`, `blob`, `create_time`, `update_time`) VALUES (2, '李四', 2, '男', '律师', '{\"uuid\":\"123\"}', '文本2', NULL, now(), now());
INSERT INTO `dbname`.`t_table_info`(`id`, `name`, `age`, `sex`, `job`, `json_set`, `text`, `blob`, `create_time`, `update_time`) VALUES (3, '王五', 3, '男', '医生', '{\"uuid\":\"123\"}', '文本3', NULL, now(), now());
INSERT INTO `dbname`.`t_table_info`(`id`, `name`, `age`, `sex`, `job`, `json_set`, `text`, `blob`, `create_time`, `update_time`) VALUES (4, '赵六', 4, '女', '医生', '{\"uuid\":\"456\"}', '文本4', NULL, now(), now());
INSERT INTO `dbname`.`t_table_info`(`id`, `name`, `age`, `sex`, `job`, `json_set`, `text`, `blob`, `create_time`, `update_time`) VALUES (5, '嘎嘎大王', 5, '女', '教师', '{\"uuid\":\"456\"}', '文本5', NULL, now(), now());
INSERT INTO `dbname`.`t_table_info`(`id`, `name`, `age`, `sex`, `job`, `json_set`, `text`, `blob`, `create_time`, `update_time`) VALUES (6, '呱呱大王', 6, '女', '教师', '{\"uuid\":\"456\"}', '文本6', NULL, now(), now());





-- ===============================================================================================
-- 一、ddl（data define language）数据定义语言
-- 1、库管理
-- 1、库的创建（create）
create database if not exists dbname;

-- 2、库的修改（alter）
alter database dbname character set utf8;

-- 3、库的删除（drop）
drop database if exists dbname;


-- 2、表管理
-- 1、表的创建（create）
drop table if exists dbname.`t_table_info`;
create table dbname.`t_table_info`  (
  `id` int(0) not null,
  `name` varchar(255) character set utf8mb4 collate utf8mb4_0900_ai_ci null default null comment '姓名（varchar(m) 存放长度不固定的字符）',
  `age` int(0) null default null comment '年龄',
  `sex` varchar(255) character set utf8mb4 collate utf8mb4_0900_ai_ci null default null comment '性别',
  `job` varchar(255) character set utf8mb4 collate utf8mb4_0900_ai_ci null default null comment '职业',
  `json_set` varchar(100) character set utf8mb4 collate utf8mb4_0900_ai_ci null default null comment 'json 集合',
  `text` text character set utf8mb4 collate utf8mb4_0900_ai_ci null comment '文本（text 存放长文本）',
  `blob` blob null comment '不录歌（blob 存放较大的二进制，如图片等）',
  `create_time` datetime(0) null default null comment '创建时间',
  `update_time` datetime(0) null default null on update current_timestamp(0) comment '更新时间',
  primary key (`id`) using btree,
  unique index `index_id`(`id`) using btree,
  index `index_name`(`name`) using btree,
  index `index_age_sex`(`age`, `sex`) using btree
) engine = innodb character set = utf8mb4 collate = utf8mb4_0900_ai_ci row_format = dynamic;

-- 复制表（create）
create table dbname.`t_table_info_v2` like dbname.`t_table_info`;

-- 2、表的修改（alter）
-- 添加列
alter table dbname.`t_table_info` add new_col varchar(255) null comment '新增列'; 
-- 修改列
alter table dbname.`t_table_info` change new_col new_col_v2 varchar(50);
-- 删除列
alter table dbname.`t_table_info` drop column new_col_v2;

-- 3、表的删除（drop）
drop table dbname.`t_table_info_v2`;

-- 4、表的查询（desc）
desc dbname.`t_table_info`;
show columns from dbname.`t_table_info`;

-- 5、复制表数据
insert into dbname.`t_table_info_v2` select * from dbname.`t_table_info`;

-- 6、重命名表
rename table dbname.`t_table_info_v2` to dbname.`t_table_info_v3`;

-- 7、清空表
truncate table dbname.`t_table_info_v3`;




-- ===============================================================================================
-- 二、dml（data manipulation language）数据操作语言
-- 1、增（insert）
insert into `dbname`.`t_table_info`(`id`, `name`, `age`, `sex`, `job`, `json_set`, `text`, `blob`, `create_time`, `update_time`, `new_col_v2`) 
values (23, '呱呱大王', 7, '女', '教师', '{\"uuid\":\"456\"}', null, null, now(), now(), null);

-- 2、删（delete）
delete from dbname.`t_table_info` where id = '1';

-- 3、改（update）
update `dbname`.`t_table_info` set `name` = '呱呱大王', `age` = 7, `sex` = '女', `job` = '教师', `json_set` = '{\"uuid\":\"456\"}', `text` = null, `blob` = null, `create_time` = now(), `update_time` = now(), `new_col_v2` = null where `id` = 1;




-- ===============================================================================================
-- 三、dql（data query language）数据查询语言
-- 1、基础查询（select）
select * from dbname.`t_table_info`;

-- 2、条件查询（where）
select * from dbname.`t_table_info` where id = '1';
-- and 和 or 查询
select * from dbname.`t_table_info` where job in ('律师') and (id in ('1') or age in ('5'));
-- between 筛选某个范围内的值
select * from dbname.`t_table_info` where age between '1' and '5';
-- 模糊查询
select * from dbname.`t_table_info` where name like '%大王%';
-- 多条件模糊查询 
select * from dbname.`t_table_info` where name like '%大王' or job like '%律师%';
-- 选取指定的条数数据
select * from dbname.`t_table_info` limit 5;
-- 升降序排序
select * from dbname.`t_table_info` order by update_time desc, id desc;

-- 3、分页查询（limit）
-- 查询5条数据
select * from dbname.`t_table_info` limit 5;
-- 查询最新一条数据
select * from dbname.`t_table_info` order by update_time desc limit 1;

-- 4、连接查询（join）
-- 内连接-1：内连接查询操作列出与连接条件匹配的数据行
select * from t_table_info a, t_table_info_v2 b where a.id = b.id;
-- 内连接-2：内连接查询操作列出与连接条件匹配的数据行
select * from t_table_info a inner join t_table_info_v2 b on a.id = b.id;
-- 外连接-左连接：以左表为基准，右表的列为 null
select * from t_table_info a left join t_table_info_v2 b on a.id = b.id;
-- 外连接-右连接：以右表为基准，左表的列为 null
select * from t_table_info a right join t_table_info_v2 b on a.id = b.id;
-- 交叉连接：交叉联接返回左表中的所有行，左表中的每一行与右表中的所有行组合。交叉联接也称作笛卡尔积。
select * from t_table_info a cross join t_table_info_v2 as b on a.id = b.id;

-- 5、子查询(in)
select * from dbname.`t_table_info` where id in ('1','5');

-- 6、排序查询（order by）
select * from dbname.`t_table_info` order by update_time desc, id desc;

-- 7、分组查询（group by）
select job, count(0) as '重复次数' from dbname.`t_table_info` group by job;
select job, count(job) as '重复次数' from dbname.`t_table_info` group by job having count(job)>1;

-- 8、时间查询
select * from dbname.`t_table_info`;
-- 查询今天的数据
select * from dbname.`t_table_info` where to_days(create_time) = to_days(now());
-- 查询昨天的数据
select * from dbname.`t_table_info` where datediff(create_time, now())=-1;
-- 查询最近7天的数据
select * from dbname.`t_table_info` where date_sub(curdate(), interval 7 day) <= date(create_time);
-- 查询本月的数据
select * from dbname.`t_table_info` where date_format(create_time, '%y%m') = date_format(curdate(), '%y%m');
-- 查询上月数据
select * from dbname.`t_table_info` where period_diff(date_format(now(),'%y%m'), date_format(create_time, '%y%m'))=1;

-- 9、其它查询
-- 查询 json：json_unquote() 去除双引号; json_extract() 提取 json 的 key
select json_unquote(json_extract(json_set,'$.uuid')) from dbname.`t_table_info`;




-- ===============================================================================================
-- 四、dcl（data control language）数据控制语言
-- 查看用户表
select * from mysql.`user`;

-- 1、创建用户（create）
create user student identified by 'student';

-- 2、用户号授权（grant）
grant select, insert, update, delete on `dbname`.* to `student`@`%`; flush privileges;

-- 3、撤销权限（revoke）
revoke delete on `dbname`.* from `student`@`%`;

-- 4、查看权限（show）
show grants for 'student'@'%';

-- 5、删除用户（drop）
drop user 'student'@'%';

-- 6、修改用户（update）
update mysql.`user` set user = 'student_v2' where user ='student' and host = '%';



-- ===============================================================================================
-- 五、索引操作
-- 1、索引创建（create）
-- 创建唯一索引
create unique index index_id on dbname.`t_table_info` (id);
-- 创建普通索引,允许重复值,1个索引
create index index_name on dbname.`t_table_info` (name);
-- 创建普通索引,允许重复值,2个索引
create index index_age_sex on dbname.`t_table_info` (age, sex);

-- 2、索引删除（drop）
drop index index_name on dbname.`t_table_info`;

-- 3、索引查询（show）
show index from dbname.`t_table_info`;


-- ===============================================================================================
-- 六、存储过程
-- 简单查询
drop procedure if exists get_info;
create procedure get_info()
begin 
	select * from dbname.`t_table_info`;
end;
call get_info();


-- 批量插入数据
drop procedure if exists batch_data;
create procedure batch_data()
begin
declare i int;
  set i=7;
  while(i<=10) do
           insert into dbname.`t_table_info` (id, name, age, sex, job, json_set, create_time, update_time) values(i, concat('name',id), 1, '男', UUID(), '{"uuid":"123"}', now(), now());
    set i=i+1; 
  end while;
end;
call batch_data();


-- ===============================================================================================
-- 七、相关函数
-- 1、时间函数
-- 获取当前时间
select
now(),
curdate(),
curtime(3),
current_date(),
current_time(3),
current_timestamp(2),
current_date,
current_time,
current_timestamp,
unix_timestamp(now());

-- 获取当前日期
select date(curdate());

-- 获取当前月份
select month(curdate());

-- 获取本月第一天
select date_add(curdate(), interval-day(curdate())+1 day); 

-- 获取本月最后一天
select last_day(curdate()); 

-- 获取本月天数
select day(last_day(curdate()));

-- 获取当前年份
select year(curdate());

-- date_format(date, format)函数用于以不同的格式显示日期/时间数据，date 是日期列,format 是格式
select date_format(now(),'%y-%m-%d');

-- str_to_date(str,format) 将字符串转成日期
select str_to_date(now(),'%y-%m-%d') from dbname.`t_table_info`;

-- 查询当前日期是哪个季度的
select extract(quarter from str_to_date(now(),'%y-%m-%d'));

-- 时间区间
select datediff('2022-12-31',now());

-- 加减某个时间间隔函数 date_add()与 date_sub()
-- date_add('某个日期时间',interval 1 时间种类名); quarter:季，week:周，day:天，hour:小时，minute:分钟，second:秒，microsecond:毫秒
-- 加1天
select date_add('2022-01-01', interval 1 day); 
-- 加1月
select date_add(now(), interval 1 month); 

-- 日期相减
select datediff('2022-12-31', '2022-01-01');

-- 时间相减
select timediff('2022-01-01 00:00:00', '2021-01-02 00:00:00');
select timediff('12:00:00','12:30:00');

-- 时间相减-转换为秒数
select time_to_sec(timediff('12:00:00', '12:02:00'));

-- 查询当年月份，前提：dbname.`t_table_info`大于等于12条数据
select 
case 
	when length(mon)=1 then concat(left(current_date,5),'0',mon) 
	else concat(left(current_date,5),mon) end months 
	from (select @m:=@m+1 mon from dbname.`t_table_info`,(select @m:=0) a ) aa limit 12;

-- 2、随机数
-- 生成小于1的随机数
select rand();

-- 生成100以内的随机数
select floor(1 + (rand() * 100));

-- 生成3位随机数
select ceiling(rand()*900+100);

-- 生成4位随机数
select ceiling(rand()*9000+100);

-- 3、其它函数
-- 统计
select count(*) from dbname.`t_table_info`;

-- 查询平均值
select avg(id) from dbname.`t_table_info`;

-- 查询最大值
select max(id) from dbname.`t_table_info`;

-- 查询最小值
select min(id) from dbname.`t_table_info`;

-- 求和
select sum(id) from dbname.`t_table_info`;

-- concat：在字段值前加上前缀 aaa-
update dbname.`t_table_info` set name = concat('aaa-',name) where name in ('张三','李四');

-- replace：去掉字段值的某一部分
update dbname.`t_table_info` set name=replace(name,'aaa-','') where name in ('aaa-张三','aaa-李四');

-- 其它函数----------------------------------------

-- case 举例
select
  name,
  (case when name = '张三' then '张三呀'
        when name = '李四' then '李四呀'
        when name is null then '空值'
        else '其它情况' end) as 备注
from dbname.`t_table_info`;

-- concat：在字段值前加上前缀 aaa-
update dbname.`t_table_info` set name = concat('aaa-',name) where name in ('张三','李四');


-- replace：去掉字段值的某一部分
update dbname.`t_table_info` set name=replace(name,'aaa-','') where name in ('aaa-张三','aaa-李四');

-- 随机数----------------------------------------

-- 生成3位随机数
select ceiling(rand()*900+100);

-- 生成4位随机数
select ceiling(rand()*9000+100);

-- 生成100以内的随机数
select floor(1 + (rand() * 100));


-- ===============================================================================================
-- 八、其它内容
-- 1、查看数据库大小
-- 查询所有数据库的表大小
select table_name, concat(truncate(data_length/1024/1024,2),' mb') as data_size,concat(truncate(index_length/1024/1024,2),' mb') as index_size
from information_schema.tables
group by table_name
order by data_length desc;

-- 查询某个数据库的表大小
select table_name, concat(truncate(data_length/1024/1024,2),' mb') as data_size,concat(truncate(index_length/1024/1024,2),' mb') as index_size
from information_schema.tables where table_schema = 'dbname'
group by table_name
order by data_length desc;

-- 2、设置变量
-- set 设置变量
set @job = '教师';
set @age = (select age from dbname.`t_table_info` where id in ('6'));
select * from dbname.`t_table_info` where job in (@job) and age in (@age);

-- select 设置变量
select @job := '教师';
select * from dbname.`t_table_info` where job in (@job);

-- 查询结果并赋值
select age, job into @age, @job from dbname.`t_table_info` where id in ('6');
select * from dbname.`t_table_info` where age in (@age) and job in (@job);

-- 3、系统变量
-- 查看所有的会话变量
show session variables;

-- 查看所有的全局变量
show global variables;

-- 查看数据库隔离级别
show variables like '%isolation';
select @@global.tx_isolation;

-- 查看 mysql 版本
show variables like 'version%';

-- 查看端口、目录、数据存放目录、服务器 id
select @@port, @@basedir, @@datadir, @@server_id;

-- 4、explain
-- 分析查询的 sql 语句
explain select * from dbname.`t_table_info`;

-- 5、批量删除表（将结果复制出来并执行）
select concat('drop table if exists ', table_name, ';') from information_schema.tables where table_schema = 'dbname';


-- ===============================================================================================



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

-- 计算字符串 '1390636016' 的 MD5 哈希值，并将前16个字符转换为十进制整数
SELECT CONV(LEFT(MD5('1390636016'), 16), 16, 10) AS HashValue;