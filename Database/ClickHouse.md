[TOC]

<h1 align="center">ClickHouse</h1>

> By：weimenghua  
> Date：2023.01.19  
> Descrition：ClickHouse 列式数据库管理系统

**参考资料**  
[clickhouse 官方文档](https://clickhouse.com/docs/zh/)



### 一、ClickHouse 简介
ClickHouse 是一个用于联机分析(OLAP)的列式数据库管理系统(DBMS)。



### 二、ClickHouse SQL 语句

```
创建数据库
CREATE DATABASE [IF NOT EXISTS] db_name [ON CLUSTER cluster] [ENGINE = engine(...)]
CREATE DATABASE db_name

删除数据库
drop database [数据库名称]
drop database db_name

创建数据表
CREATE TABLE db_name.table_name (
    customer_id String, 
    time_stamp Date, 
    click_event_type String,
    country_code FixedString(2), 	
    source_id UInt64
) 
ENGINE = MergeTree()
ORDER BY (time_stamp)

查看数据库中的表名
SHOW TABLES IN [数据库名称]
SHOW TABLES IN db_name

查看表结构 
DESCRIBE [数据库.表名]
DESCRIBE db_name.table_name

插入数据
INSERT INTO [数据库.表名] VALUES ()
INSERT INTO db_name.table_name VALUES ('customer1', '2023-01-08', 'add_to_cart', 'US', 568239)

指定列名插入 INSERT INTO [数据库.表名] (列名，列名，列名，，) VALUES (, , ,)
INSERT INTO db_name.table_name (customer_id, time_stamp, click_event_type)
VALUES ('customer2', '2023-01-08', 'remove_from_cart')

查看表中存储的数据
SELECT * FROM [数据库.表名]
SELECT * FROM [数据库.表名] WHERE [列名]= 
SELECT * FROM [数据库.表名] WHERE [列名]>=
SELECT [列名] FROM [数据库.表名] WHERE [列名]>=
SELECT * FROM db_name.table_name

ATOMIC 默认引擎
mysql 引擎,可以将 mysql 中的数据表直接复制过来。
CREATE DATABASE [IF NOT EXISTS] db_name [ON CLUSTER cluster]
ENGINE = MySQL('host:port', ['database' | database], 'user', 'password')
```