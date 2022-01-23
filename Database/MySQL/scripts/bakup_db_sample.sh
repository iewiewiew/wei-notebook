#! /bin/bash

##################################备份##################################
#注：如果账号密码有特殊字符,需用斜杠做转义,如：qwe\!
#1.1、备份单个数据库 dbname 到目录/tmp 下面,并指定名称为 dbname(dbname：数据库名称, 也可任意命名)
mysqldump -h127.0.0.1 -uroot -ppassword dbname > /tmp/dbname.sql;

#1.2、备份数据库为带删除表的格式,能够让该备份覆盖已有数据库而不需要手动删除原有数据库（没验证过）
mysqldump --add-drop-table -h127.0.0.1 -uroot -ppassword dbname > /tmp/dbname.sql;

#1.3、备份数据库中的某个表 t_a_table t_b_table,注：表名之间是空格
mysqldump -h127.0.0.1 -uroot -ppassword dbname t_a_table t_b_table > /tmp/dbname.sql;

#1.4、备份多个数据库 a_dbname b_dbname,注：加上--databases 参数,数据 dbname 之间是空格
mysqldump -h127.0.0.1 -uroot -ppassword --databases a_dbname b_dbname > /tmp/dbname.sql;

#1.5、备份系统中所有数据库
mysqldump -h127.0.0.1 -uroot -ppassword --all-databases > /tmp/databases.sql;

#1.6、备份数据库并压缩
mysqldump -h127.0.0.1 -uroot -ppassword dbname | gzip > /tmp/dbname.sql.gz;

#1.7、排除表进行备份
#--ignore-table=数据库名.表名,该参数的作用是,对某些表不进行导出。等号后面的参数即表的信息,必须通过数据库和表名来定义。如果要忽略多张表,那么就要多次使用--ignore-table 参数
mysqldump -h127.0.0.1 -uroot -ppassword dbname --ignore-table=dbname.tablename1 --ignore-table=dbname.tablename2 | gzip > /tmp/dbname.sql.gz;

#1.8、参数详解
#--set-gtid-purged=OFF, ---在会记录 binlog 日志,如果不加,不记录 binlog 日志,所以在我们做主从用了 gtid 时,用 mysqldump 备份时就要加--set-gtid-purged=OFF,否则你在主上导入恢复了数据,主没有了 binlog 日志,同步则不会被同步。
#--no-create-db,        ---取消创建数据库 sql(默认存在),只导出数据,而不添加 CREATE DATABASE 语句
#--no-create-info,      ---取消创建表 sql(默认存在)
#--no-data              ---不导出数据(默认导出)
#--add-drop-database    ---增加删除数据库 sql（默认不存在）
#--skip-add-drop-table  ---取消每个数据表创建之前添加 drop 数据表语句(默认每个表之前存在 drop 语句)
#--skip-add-locks       ---取消在每个表导出之前增加 LOCK TABLES（默认存在锁）
#--skip-comments        ---注释信息(默认存在)


##############################还原##############################
#2.1、将 dbname.sql 还原到 dbname 数据库,执行前需要先创建 dbname 数据库
mysql -h127.0.0.1 -uroot -ppassword dbname < /tmp/dbname.sql;

#2.2、解压数据库并还原
gunzip < /tmp/dbname.sql.gz | mysql -h127.0.0.1 -uroot -ppassword dbname;
gunzip < /tmp/dbname.sql.gz | mysql --max_allowed_packet=128M -h127.0.0.1 -uroot -ppassword dbname;

#2.3、source 还原数据库
mysql -h127.0.0.1 -uroot -ppassword
mysql>use dbname
mysql>source /tmp/dbname.sql  #使用 source 命令,后面参数为脚本文件（如这里用到的.sql）

#3、将数据库转移到新服务器（没验证过）
mysqldump -h127.0.0.1 -uroot -ppassword dbname | mysql –host=*.*.*.* -C dbname

#4、备份单个数据表结构 -d
mysqldump -h127.0.0.1 -uroot -ppassword -d dbname > /tmp/dbname.sql

#5、导入单个数据表结构
mysql -h127.0.0.1 -uroot -ppassword dbname < /tmp/dbname.sql

#6、根据表前缀导出数据
mysqldump -uroot -ppassword dbname $(mysql -uroot -ppassword dbname -Bse "show tables like 't_%'") > "导出位置.sql"