
/*  目录

数据准备
user 表相关
选择数据库
设计表结构
索引相关
增删改查
条件查询
时间查询
连接查询
存储过程
查询数据库大小
设置变量
系统变量
时间函数
其它函数
随机数

**/

-- 数据准备----------------------------------------

CREATE TABLE `t_table_info` (
                                `id` int(11) NOT null,
                                `name` varchar(255) DEFAULT null COMMENT '姓名',
                                `age` int(11) DEFAULT null COMMENT '年龄',
                                `sex` varchar(255) DEFAULT null COMMENT '性别',
                                `job` varchar(255) DEFAULT null COMMENT '职业',
                                `json_set` varchar(100) DEFAULT null COMMENT 'json 集合',
                                `create_time` datetime DEFAULT null COMMENT '创建时间',
                                `update_time` datetime DEFAULT null ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                PRIMARY KEY (`id`) USING BTREE,
                                UNIQUE KEY `index_id` (`id`),
                                KEY `index_name` (`name`),
                                KEY `index_age_sex` (`age`,`sex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC


INSERT INTO dbname.t_table_info (id, name, age, sex, job, json_set, create_time, update_time) VALUES(1, '张三', 1, '男', '律师', '{"uuid":"123"}', '2021-10-27 23:28:35', now());
INSERT INTO dbname.t_table_info (id, name, age, sex, job, json_set, create_time, update_time) VALUES(2, '李四', 2, '男', '律师', '{"uuid":"123"}', '2021-10-13 23:28:38', now());
INSERT INTO dbname.t_table_info (id, name, age, sex, job, json_set, create_time, update_time) VALUES(3, '王五', 3, '男', '医生', '{"uuid":"123"}', '2021-10-20 23:30:56', now());
INSERT INTO dbname.t_table_info (id, name, age, sex, job, json_set, create_time, update_time) VALUES(4, '赵六', 4, '女', '医生', '{"uuid":"456"}', '2021-10-27 23:31:28', now());
INSERT INTO dbname.t_table_info (id, name, age, sex, job, json_set, create_time, update_time) VALUES(5, '嘎嘎大王', 5, '女', '教师', '{"uuid":"456"}', '2021-11-21 21:58:17', now());
INSERT INTO dbname.t_table_info (id, name, age, sex, job, json_set, create_time, update_time) VALUES(6, '呱呱大王', 6, '女', '教师', '{"uuid":"456"}', '2021-11-21 21:59:32', now());


-- user 表相关----------------------------------------

-- 查看用户表
select * from mysql.`user`;

-- 创建用户
create user student identified by 'student';

-- 修改用户名称
update mysql.`user` set user = 'student_v2' where user ='student' and Host = 'localhost';

-- 查看用户权限
show grants for 'student'@'%';


-- 选择数据库----------------------------------------

-- 选择数据库
use dbname;

-- 查看表
show tables;

-- 刷新权限变更
flush privileges


-- 设计表结构----------------------------------------

select * from dbname.`t_table_info`;

-- 查看表结构
desc dbname.`t_table_info`;

-- 添加列
alter table dbname.`t_table_info` add new_col varchar(255) null comment '新增列';

-- 修改列
alter table dbname.`t_table_info` change new_col new_col_v2 varchar(50);

-- 删除列
alter table dbname.`t_table_info` drop column new_col_v2;

-- 复制表结构
create table dbname.`t_table_info_v2` like dbname.`t_table_info`;

-- 复制表数据
insert into dbname.`t_table_info_v2` select * from dbname.`t_table_info`;

-- 重命名表
rename table dbname.`t_table_info_v2` to dbname.`t_table_info_v3`;

-- 删除表
-- drop table dbname.`t_table_info_v3`;

-- 清空表
-- truncate table dbname.`t_table_info_v3`;



-- 索引相关----------------------------------------

-- 查看索引
show index from dbname.`t_table_info`;

-- 创建唯一索引
create unique index index_id on dbname.`t_table_info` (id);

-- 创建普通索引,允许重复值,1个索引
create index index_name on dbname.`t_table_info` (name);

-- 创建普通索引,允许重复值,2个索引
create index index_age_sex on dbname.`t_table_info` (age, sex);

-- 删除索引
drop index index_name on dbname.`t_table_info`;



-- 增删改查----------------------------------------

-- 插入数据
insert into dbname.`t_table_info` (id, name, age, sex, job, json_set, create_time, update_time, new_col) values(floor(1 + (rand() * 100)), '呱呱大王', 6, '女', '教师', '{"uuid":"456"}', now(), now(), null);

-- 删除数据
delete from dbname.`t_table_info` where id in ('6');

-- 修改数据
update dbname.`t_table_info` set name='呱呱大王', age=6, sex='女', job='教师', json_set='{"uuid":"456"}', create_time='2021-11-21 21:59:32', update_time=now() where id in ('6');

-- 查询数据
select * from dbname.`t_table_info`;

-- 查询 json：json_unquote() 去除双银行; json_extract() 提取 json 的 key
select json_unquote(json_extract(json_set,'$.uuid')) from dbname.`t_table_info`;

-- 批量删除表：将结果复制出来并执行
select concat('drop table if exists ', table_name, ';') from information_schema.tables where table_schema = 'dbname';


-- 条件查询----------------------------------------

select * from dbname.`t_table_info`;

-- 选取指定的条数数据
select * from dbname.`t_table_info` limit 5;

-- 查询最新一条数据
select * from dbname.`t_table_info` order by update_time desc limit 1;

-- 升降序排序
select * from dbname.`t_table_info` order by update_time desc, id desc;

-- in 查询
select * from dbname.`t_table_info` where id in ('1','5');

-- and 和 or 查询
select * from dbname.`t_table_info` where job in ('律师') and (id in ('1') or age in ('5'));

-- between 筛选某个范围内的值
select * from dbname.`t_table_info` where age between '1' and '5';

-- 模糊查询
select * from dbname.`t_table_info` where name like '%大王%';

-- 多条件模糊查询
select * from dbname.`t_table_info` where name like '%大王' or job like '%律师%';

-- 分组查询数据
select job, count(0) as '重复次数' from dbname.`t_table_info` group by job;

-- 查询重复数据并统计个数
select job, count(job) as '重复次数' from dbname.`t_table_info` group by job having count(job)>1;


-- 时间查询----------------------------------------

select * from dbname.`t_table_info`;

-- 查询今天的数据
select * from dbname.`t_table_info` where to_days(create_time) = to_days(now());

-- 查询昨天的数据
select * from dbname.`t_table_info` where datediff(create_time, now())=-1;

-- 查询最近7天的数据
select * from dbname.`t_table_info` where date_sub(curdate(), interval 7 day) <= date(create_time);

-- 查询本月的数据
select * from dbname.`t_table_info` where date_format(create_time, '%Y%m') = date_format(curdate(), '%Y%m');

-- 查询上月数据
select * from dbname.`t_table_info` where period_diff(date_format(now(),'%Y%m'), date_format(create_time, '%Y%m'))=1;


-- 连接查询----------------------------------------

select * from dbname.`t_table_info`;

-- 内连接-1：内连接查询操作列出与连接条件匹配的数据行
select * from t_table_info a, t_table_info_v2 b where a.id = b.id;

-- 内连接-2：内连接查询操作列出与连接条件匹配的数据行
select * from t_table_info a inner join t_table_info_v2 b on a.id = b.id;

-- 外连接-左连接：以左表为基准，右表的列为 NULL
select * from t_table_info a left join t_table_info_v2 b on a.id = b.id;

-- 外连接-右连接：以右表为基准，左表的列为 NULL
select * from t_table_info a right join t_table_info_v2 b on a.id = b.id;

-- 交叉连接：交叉联接返回左表中的所有行，左表中的每一行与右表中的所有行组合。交叉联接也称作笛卡尔积。
select * from t_table_info a cross join t_table_info_v2 as b on a.id = b.id;


-- 存储过程----------------------------------------

-- 简单查询 --

select * from dbname.`t_table_info`;

drop procedure if exists get_info;
create procedure get_info()
begin
select * from dbname.`t_table_info`;
end;

call get_info();


-- 批量插入数据----------------------------------------

select * from dbname.`t_table_info`;

drop procedure if exists batch_data;
create procedure batch_data()
begin
declare i int;
  set i=7;
  while(i<=8) do
           insert into dbname.`t_table_info` (id, name, age, sex, job, json_set, create_time, update_time) values(i, CONCAT('name',id), 1, '男', '律师', '{"uuid":"123"}', now(), now());
    set i=i+1;
end while;
end;

call batch_data();


-- 查询数据库表大小----------------------------------------

select * from dbname.`t_table_info`;

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


-- 设置变量----------------------------------------

select * from dbname.`t_table_info`;

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


-- 系统变量----------------------------------------

-- 查看所有的会话变量
show session variables;

-- 查看所有的全局变量
show global variables;

-- 查看数据库隔离级别
show variables like '%isolation';
select @@global.tx_isolation;

-- 查看 MySQL 版本
show variables like 'version%';

-- 查看端口、目录、数据存放目录、服务器 id
select @@port, @@basedir, @@datadir, @@server_id;



-- 时间函数----------------------------------------

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


-- 其它函数----------------------------------------

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


-- 随机数----------------------------------------

-- 生成3位随机数
select ceiling(rand()*900+100);

-- 生成4位随机数
select ceiling(rand()*9000+100);

-- 生成100以内的随机数
select floor(1 + (rand() * 100));