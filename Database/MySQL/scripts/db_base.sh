#!/usr/bin/env bash

#注：本地执行则可不加-h
mysql -h127.0.0.1 -uroot -ppassword

#注意加分号;和 s
show databases;

#进入数据库
use 数据库名称;

#查看数据库有哪些表
show tables;

#退出
ctrl+d


#1、修改密码 set password for 用户名 = password("密码");
set password for user_name = password("dbname#new_password");
flush privileges;

#2、给用户分配权限
grant all on dbname.* to user_name@'%' identified by 'user_name#password';
flush privileges;

#3、*.*：把所有数据库权限给 dbname_new 用户
grant all on *.* to dbname_new@'127.0.0.%' identified by 'dbname#passwd_new';

#4、回收数据库权限
revoke all on *.* from dbname;
revoke delete,drop on xxx_$dbname.* from xxx_$dbname;

#5、查看数据库用户和 HOST
select User,HOST FROM mysql.user;

#单个创建数据库，用户，分配权限
create database ${dbname} DEFAULT CHARACTER SET utf8mb4
grant all on dbname.* to dbname@'%' identified by 'dbname#password'
grant select, update, insert, delete on dbname.* to 'dbname'@'%'
revoke delete, drop on xxx_$dbname.* from xxx_$dbname;
flush privileges