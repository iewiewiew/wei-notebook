----------------------------------------------


-- 创建数据库用户 test，并设置密码
CREATE USER test WITH PASSWORD 'test';

-- 修改用户密码
ALTER USER postgres WITH PASSWORD 'postgres';


----------------------------------------------


-- 创建数据库 dbdemo，并指定所有者 postgres
CREATE DATABASE dbdemo OWNER postgres;

-- 赋权
GRANT ALL PRIVILEGES ON DATABASE dbdemo to postgres;

-- 删除数据库 dbdemo
-- DROP DATABASE dbdemo;

-- IF EXISTS 如果数据库不存在则发出提示信息，而不是错误信息
-- DROP DATABASE IF EXISTS dbdemo;


----------------------------------------------


-- 创建表 public 是一个数据库模式（schema）的名称在，PostgreSQL 中，数据库模式是用于组织和管理数据库对象（如表、视图、函数等）的命名空间。public 模式是默认的模式，并且在创建表时如果未指定模式，则会将表创建在 public 模式下。
-- dbdemo.public.tabledemo 表示在 dbdemo 数据库的 public 模式下创建的 tabledemo 表
CREATE TABLE dbdemo.public.tabledemo (
    id SERIAL PRIMARY key,
    name text NOT NULL,
    age text NOT NULL,
    remark text NOT NULL
);

CREATE TABLE tabledemo (
    id SERIAL PRIMARY key,
    name text NOT NULL,
    age text NOT NULL,
    remark text NOT NULL
);

CREATE TABLE COMPANY (
    ID INT PRIMARY KEY     NOT NULL,
    NAME           TEXT    NOT NULL,
    AGE            INT     NOT NULL,
    ADDRESS        CHAR(50),
    SALARY         REAL
);

-- 删除表
-- DROP TABLE COMPANY;

-- 修改表名
-- alter table dbdemo.public.tabledemo rename to newtabledemo;

-- 新增列 field_type 可以为 serial
alter table dbdemo.public.tabledemo add column new_column_name serial;

-- 插入数据
INSERT INTO "dbdemo"."public"."tabledemo" ("id", "name", "age", "remark") VALUES (1, '张三', '18', '11');
INSERT INTO "dbdemo"."public"."tabledemo" ("id", "name", "age", "remark") VALUES (2, '李四', '18', '11');

-- 更新数据
UPDATE "dbdemo"."public"."tabledemo" SET "name" = '张三', "age" = '18', "remark" = '11' WHERE "id" = 1;
UPDATE "dbdemo"."public"."tabledemo" SET "name" = '李四', "age" = '18', "remark" = '11' WHERE "id" = 2;

-- 查询数据
select * from "dbdemo"."public"."tabledemo";

-- 条件查询
select * from "dbdemo"."public"."tabledemo" where id in (2);

-- 查询数据条数
select count(*) from "dbdemo"."public"."tabledemo";

-- 求和
select sum(id) from "dbdemo"."public"."tabledemo";

-- 删除数据
delete from "dbdemo"."public"."tabledemo" where id = 1;


----------------------------------------------


CREATE TYPE week AS ENUM ('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun');


----------------------------------------------


-- 创建模式
create schema myschema;

-- 创建表
create table myschema.company(
     ID   INT              NOT NULL,
     NAME VARCHAR (20)     NOT NULL,
     AGE  INT              NOT NULL,
     ADDRESS  CHAR (25),
     SALARY   DECIMAL (18, 2),
     PRIMARY KEY (ID)
);

-- 查询表
select * from myschema.company;

-- 删除模式 删除一个为空的模式（其中的所有对象已经被删除）
-- DROP SCHEMA myschema;

-- 删除模式 删除一个模式以及其中包含的所有对象
DROP SCHEMA myschema CASCADE;


----------------------------------------------


-- 创建索引
CREATE INDEX index_name ON tabledemo(id);

-- 删除索引
DROP INDEX index_name;


----------------------------------------------


-- 运算符
select 2+3;


----------------------------------------------


-- 查看 pgsql 版本
select version();

--查看 pgsql 配置的最大连接数
show max_connections;

-- 修改最大连接数
-- 方式一
alter system set max_connections=10;
-- 方式二
-- cat /root/postgresql/postgresql.conf |grep max_connections
-- sed -i 's/max_connections = 5/max_connections = 10/' /root/postgresql/postgresql.conf

-- 查看实时连接数
select count(1) from pg_stat_activity;

-- 查看客户端连接信息
select * from pg_stat_activity;

-- 查看系统保留的用户数
show superuser_reserved_connections;