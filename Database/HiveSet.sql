-- Hive SQL 基本操作 ---------------------------------------------------------

-- 创建一个示例表
CREATE TABLE example_table (id INT, name STRING);

-- 插入数据
INSERT INTO example_table VALUES (1, 'Alice'), (2, 'Bob');

-- 查询数据
SELECT * FROM example_table;

-- 创建 插入 查询
create table pokes(foo INT, bar STRING);
load data local inpath '/opt/hive/examples/files/kv1.txt' overwrite into table pokes;
select * from pokes limit 10;



-- Hive SQL 数据库操作 ---------------------------------------------------------

-- 创建普通数据库
create database example_database;

-- 创建库的时候检查存在与否  说明：hive 的表存放位置模式是由 hive-site.xml 当中的一个属性指定的 :hive.metastore.warehouse.dir
create database if not exists example_database_tmp;

-- 创建库的时候带注释
create database if not exists example_database2 comment 'learning hive';

-- 创建数据库并指定 hdfs 存储位置
create database example_database3 location '/example_table3';

-- 创建带属性的库
create database if not exists example_database4 with dbproperties('creator'='hadoop','date'='2024-03-01');

-- 修改数据库信息  数据库的元数据信息是不可更改的，包括数据库的名称以及数据库所在的位置
alter database example_database4 set dbproperties('createtime'='20240302');

-- 查看数据库基本信息
desc database example_database;

-- 查看数据库更多详细信息
desc database extended example_database;

-- 查看数据库
show databases;

-- 查看正在使用哪个库
select current_database();

-- 切换库
use example_database;

-- 删除一个空数据库，如果数据库下面有数据表，那么就会报错
drop database example_database;

-- 强制删除数据库，包含数据库下面的表一起删除
drop database example_database cascade;



-- Hive SQL 数据表操作 ---------------------------------------------------------

-- 创建默认的内部表
create table example_table(id int, name string, sex string, age int, department string) row format delimited fields terminated by ",";

-- 创建外部表
create external table example_table_ext(id int, name string, sex string, age int, department string)
    row format delimited fields terminated by ","
    location "/hive/example_table_ext";

-- 创建分区表
create external table example_table_ptn(id int, name string, sex string, age int, department string)
    partitioned by (city string)
    row format delimited fields terminated by ","
    location "/hive/example_table_ptn";

-- 创建一个表带多个分区
create table example_table_ptn2 (s_id string, s_score int) partitioned by (year string,month string,day string);

-- 添加分区
alter table example_table_ptn add partition(city="beijing");
alter table example_table_ptn add partition(city="shenzhen");

-- 同时添加多个分区
alter table example_table_ptn add partition(city='shanghai') partition(city = 'guangzhou');

-- 分桶表
-- 将数据按照指定的字段进行分成多个桶中去，就是按照分桶字段进行哈希划分到多个文件当中去，分区就是分文件夹，分桶就是分文件；开启hive的捅表功能 set hive.enforce.bucketing=true;
create external table example_table_bck(id int, name string, sex string, age int,department string)
    clustered by (id) sorted by (id asc, name desc) into 4 buckets
    row format delimited fields terminated by ","
    location "/hive/example_table_bck";

-- 通过 insert overwrite 给桶表中加载数据 最后指定桶字段
insert overwrite table example_table_bck select * from example_table cluster by(id);

-- 通过文件创建表 使用 load data local 表示从本地文件系统加载，文件会拷贝到hdfs上；如果表是分区表，load 时不指定分区会报错
load data local inpath "/home/hadoop/example_table.txt" into table example_table;

-- 追加操作
load data local inpath '/home/hadoop/example_table.csv' into table example_table;

-- 覆盖操作
load data local inpath '/home/hadoop/example_table.csv' overwrite into table example_table;

-- 加载数据到指定分区
load data inpath '/home/hadoop/example_table.csv' into table example_table_ptn partition(city="shenzhen");

-- 通过查询其它表创建表
create table example_table_new as select * from example_table;

-- 根据已经存在的表结构创建表
create table example_table_new2 like example_table;

-- 查看当前数据库有哪些表
show tables;

-- 查看非当前数据库有哪些表
show tables in default;

-- 查看数据库中以 xxx 开头的表
show tables like 'example_table*';

-- 查看表信息
desc example_table;

-- 查看表详细信息（格式不友好）
desc extended example_table;

-- 查看表详细信息（格式友好）
desc formatted example_table;

-- 查看表分区信息
show partitions example_table_ptn;

-- 查看表的详细建表语句
show create table example_table;



-- Hive SQL 修改数据表操作 ---------------------------------------------------------

-- 修改表名
alter table example_table rename to example_table_new;

-- 增加字段
alter table example_table_new add columns (score int);

-- 修改一个字段的定义
alter table example_table_new change name new_name string;

-- 删除字段
-- hive 不支持删除字段

-- 替换所有字段
alter table example_table_new replace columns (id int, name string, address string);

-- 新增一个分区
alter table example_table_ptn add partition(city="chongqing");

-- 新增多个分区
alter table example_table_ptn add partition(city="chongqing2") partition(city="chongqing3") partition(city="chongqing4");

-- 添加动态分区
-- select 的最后一个字段会被作为动态分区字段
insert overwrite table example_table_new partition(age) select id, name, sex, department, age from example_table_ptn;

-- 修改分区
-- 一般来说，修改分区一般都是指修改分区的数据存储目录。
-- 在添加分区的时候，直接指定当前分区的数据存储目录
alter table example_table_ptn add if not exists partition(city='beijing') location '/example_table_ptn_beijing' partition(city='cc') location '/example_table_cc';

-- 修改已经指定好的分区的数据存储目录，此时原先的分区文件夹仍存在，但是在往分区添加数据时，只会添加到新的分区目录
alter table example_table_ptn partition (city='beijing') set location '/example_table_ptn_beijing';

-- 删除分区
alter table example_table_ptn drop partition (city='beijing');

-- 删除表
drop table example_table_new;

-- 清空表
truncate table example_table_new;

-- 将查询的结果导出到本地
insert overwrite local directory '/export/servers/exporthive' select * from example_table;

-- 将查询的结果格式化导出到本地
insert overwrite local directory '/export/servers/exporthive' row format delimited fields terminated by '\t' collection items terminated by '#' select * from example_table;

-- 将查询的结果导出到HDFS上(没有local)
insert overwrite directory '/export/servers/exporthive' row format delimited fields terminated by '\t' collection items terminated by '#' select * from example_table;

-- export导出到HDFS上
export table example_table to '/export/servers/exporthive';



-- 其它 ---------------------------------------------------------

-- 查看 hive 函数列表
show functions;
