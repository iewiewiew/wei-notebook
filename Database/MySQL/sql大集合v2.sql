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


-- ===============================================================================================
-- 数据准备（前提：先执行下方创库创表 sql）
INSERT INTO `dbname`.`t_table_info`(`id`, `name`, `age`, `sex`, `job`, `json_set`, `text`, `blob`, `create_time`, `update_time`) VALUES (1, '张三', 1, '男', '律师', '{\"uuid\":\"123\"}', '文本1', NULL, '2021-10-27 23:28:35', '2022-01-09 12:37:07');
INSERT INTO `dbname`.`t_table_info`(`id`, `name`, `age`, `sex`, `job`, `json_set`, `text`, `blob`, `create_time`, `update_time`) VALUES (2, '李四', 2, '男', '律师', '{\"uuid\":\"123\"}', '文本2', NULL, '2021-10-13 23:28:38', '2022-01-09 12:37:09');
INSERT INTO `dbname`.`t_table_info`(`id`, `name`, `age`, `sex`, `job`, `json_set`, `text`, `blob`, `create_time`, `update_time`) VALUES (3, '王五', 3, '男', '医生', '{\"uuid\":\"123\"}', '文本3', NULL, '2021-10-20 23:30:56', '2022-01-09 12:37:11');
INSERT INTO `dbname`.`t_table_info`(`id`, `name`, `age`, `sex`, `job`, `json_set`, `text`, `blob`, `create_time`, `update_time`) VALUES (4, '赵六', 4, '女', '医生', '{\"uuid\":\"456\"}', '文本4', NULL, '2021-10-27 23:31:28', '2022-01-09 12:37:12');
INSERT INTO `dbname`.`t_table_info`(`id`, `name`, `age`, `sex`, `job`, `json_set`, `text`, `blob`, `create_time`, `update_time`) VALUES (5, '嘎嘎大王', 5, '女', '教师', '{\"uuid\":\"456\"}', '文本5', NULL, '2021-11-21 21:58:17', '2022-01-09 12:37:14');
INSERT INTO `dbname`.`t_table_info`(`id`, `name`, `age`, `sex`, `job`, `json_set`, `text`, `blob`, `create_time`, `update_time`) VALUES (6, '呱呱大王', 6, '女', '教师', '{\"uuid\":\"456\"}', '文本6', NULL, '2021-11-21 21:59:32', '2022-01-09 12:37:16');





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

-- case 举例
select
  name,
  (case when name = '张三' then '张三呀'
        when name = '李四' then '李四呀'
        when name is null then '空值'
        else '其它情况' end) as 备注
from dbname.`t_table_info`;




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
