[TOC]

<h1 align="center">如何定位慢 SQL</h1>

> By：weimenghua  
> Date：2023.06.01  
> Description：


## 一、
查看是否开启慢查询
`show variables like '%slow%';`

结果
```
Variable_name               Value
log_slow_admin_statements	OFF
log_slow_extra	            OFF
log_slow_replica_statements	OFF
log_slow_slave_statements	OFF
slow_launch_time	        2
slow_query_log	            OFF
slow_query_log_file	        /usr/local/mysql/data/menghuadeMacBook-Pro-slow.log
```

sudo cp /usr/local/mysql/data/menghuadeMacBook-Pro-slow.log /Users/menghuawei/IdeaProjects/my-project/wei-notebook/Database/MySQL

系统变量log_slow_admin_statements
表示是否将慢管理语句例如ANALYZE TABLE和ALTER TABLE等记入慢查询日志

启用log_slow_extra系统变量
（从MySQL 8.0.14开始提供）将导致服务器将几个额外字段写入日志

Log_slow_slave_statements
从库默认是不写入慢查询的，开启之后从库慢查询日志写入

slow_query_log
这个参数设置为ON，可以捕获执行时间超过一定数值的SQL语句

slow_query_log_file
记录日志的文件名

slow_launch_time=#
表示如果建立线程花费了比这个值更长的时间，slow_launch_threads 计数器将增加

开启慢查询
set global slow_query_log='ON';

修改慢查询时间为5
set long_query_time = 5;
show global status like '%slow%';



## 二、示例

### show full processlist

```
-- 显示哪些 SQL 线程正在运
show full processlist;
```

![](./img/show%20full%20processlist.png)

**字段说明**

- ID：作为一个标识 ID，如果你打算 kill 一个 SQL，可以根据 ID 来进行。
- User：当前正在执行 SQL 的用户，只显示你登录账号权限范围内能够看到的用户。
- Host：显示这个语句是从哪个 ID 和端口上发出的。
- db：当前线程使用的库名。
- Command：连接执行的命令状态，一般是 Sleep、Query、Connect 等。
- Time：状态持续的时间（单位是秒）。
- State：显示当前 SQL 语句的状态，这是一个非常重要的判断标识，比如多次刷新命令时，发现 SQL 常处于 Sending data，那么这条 SQL 大概率是存在问题的。
- Info：显示正在执行的 SQL 语句，这也是你能直接拿到慢 SQL 的方式。

###  实例对比：索引对性能的影响

创建表

```mysql
create database if not exists dbname;

drop table if exists `t_table_info`;
create table `t_table_info`  (
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
```

未加索引的前提下，使用 JMeter 根据 ID 进行查询

```
select * from `dbname`.t_table_info where id = '1';
```

测试结果



添加索引的前提下，使用 JMeter 根据 ID 进行查询

测试结果