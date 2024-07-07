[TOC]

<h1 align="center">ClickHouse</h1>

> By：weimenghua  
> Date：2023.01.19  
> Descrition：ClickHouse 列式数据库管理系统

**参考资料**  
[ClickHouse 官方文档](https://clickhouse.com/docs/zh/)  
[ClickHouse 源码](https://github.com/ClickHouse/ClickHouse)  
[ClickHouse 下载](https://packages.clickhouse.com/)



## 1. ClickHouse 简介

ClickHouse 是一个用于联机分析(OLAP)的列式数据库管理系统(DBMS)。



## 2. ClickHouse 安装

[安装文档](https://clickhouse.com/docs/zh/getting-started/install)

```
sudo apt-get install -y apt-transport-https ca-certificates dirmngr
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD2B48D754

echo "deb https://packages.clickhouse.com/deb stable main" | sudo tee \
    /etc/apt/sources.list.d/clickhouse.list
sudo apt-get update

sudo apt-get install -y clickhouse-server clickhouse-client

sudo service clickhouse-server start
clickhouse-client # or "clickhouse-client --password" if you've set up a password.

密码设置 123456

服务器配置文件位于 /etc/clickhouse-server/。在继续之前，请注意 config.xml 中的 <path> 元素。它决定了数据存储的位置，因此它应该位于磁盘容量的卷上，默认值是 /var/lib/clickhouse/。

用户配置文件：/etc/clickhouse-server/users.xml，/etc/clickhouse-server/users.d/default-password.xml
```

检查服务
```
检查服务
netstat -antpl | grep clickhouse

客户端连接
clickhouse-client --password 123456

查看日志
tail -500f /var/log/clickhouse-server/clickhouse-server.log
```



## 3. Clickhouse 教程

### ClickHouse SQL

```
查看数据库
SHOW DATABASES

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
SHOW TABLES
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



### Clickhouse 基础

[Clickhouse 教程](https://clickhouse.com/docs/zh/getting-started/tutorial)  

进入客户端方式一： 
clickhouse-client --password 123456
clickhouse-client --host=... --port=... --user=... --password=...

进入客户端方式二： 
clickhouse-client，输入密码，进入客户端后查看数据库：show databases，注意命令后无分号，输入之后按 Enter

下载并提取表数据
curl https://datasets.clickhouse.com/hits/tsv/hits_v1.tsv.xz | unxz --threads=`nproc` > hits_v1.tsv
curl https://datasets.clickhouse.com/visits/tsv/visits_v1.tsv.xz | unxz --threads=`nproc` > visits_v1.tsv

创建数据库
```
clickhouse-client --password 123456 --query "CREATE DATABASE IF NOT EXISTS tutorial"
```

创建数据表
进入客户端后 clickhouse-client --password 123456 执行创建数据表命令
[ClickHouse.sql](ClickHouse.sql)

导入数据
```
clickhouse-client --password 123456 --query "INSERT INTO tutorial.hits_v1 FORMAT TSV" --max_insert_block_size=100000 < hits_v1.tsv
clickhouse-client --password 123456 --query "INSERT INTO tutorial.visits_v1 FORMAT TSV" --max_insert_block_size=100000 < visits_v1.tsv
```

查询数据表
```
clickhouse-client --password 123456 --query "SELECT COUNT(*) FROM tutorial.hits_v1"
clickhouse-client --password 123456 --query "SELECT COUNT(*) FROM tutorial.visits_v1"
clickhouse-client --password 123456 --query "SELECT * FROM tutorial.hits_v1 limit 10"
```

从另一个表查询数据仔插入数据表
```
INSERT INTO tutorial.hits_all SELECT * FROM tutorial.hits_v1;
```

查询系统设置
```
SELECT name, value, changed, description FROM system.settings
SELECT name, value, changed, description FROM system.settings WHERE name LIKE '%max_insert_b%' FORMAT TSV
SELECT
    name,
    value,
    changed,
    description
FROM system.settings
WHERE name LIKE '%max_insert_b%'
```

默认情况下，clickhouse-server 会在 8123 端口上监控 HTTP 请求（这可以在配置中修改）。
```
curl 'http://localhost:8123/'
curl 'http://localhost:8123/ping'
curl 'http://localhost:8123/replicas_status'

创建数据库（无密码）
echo 'CREATE TABLE t (a UInt8) ENGINE = Memory' | curl 'http://localhost:8123/' --data-binary @-
创建数据库（有密码）
echo 'CREATE TABLE t (a UInt8) ENGINE = Memory' | curl -u default:123456 'http://localhost:8123/' --data-binary @-

创建表（无密码）
echo 'INSERT INTO t VALUES (1),(2),(3)' | curl 'http://localhost:8123/' --data-binary @-
创建表（有密码）
echo 'INSERT INTO t VALUES (1),(2),(3)' | curl -u default:123456 'http://localhost:8123/' --data-binary @-

查询表
clickhouse-client --password 123456 --query "SELECT * FROM default.t"
```

clickhouse 本地表和分布式表的区别

分布式表：数据会根据预定义的分布策略在多个物理节点上进行分片和复制，每个节点存储部分数据。这种方式可以在集群中实现数据的分布和冗余，提高数据处理和查询的并行性和可扩展性。 
本地表：数据存储在单个节点上，不进行分片和复制。本地表适用于小规模数据集和单节点环境，仅使用单个服务器进行数据存储和查询。

1个或多个副本（Replica）、1个或多个分片（Shard）

| **类型**                      | **说明**                                                     | **区别**                                                     |
| ----------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 本地表（Local Table）         | 数据只会存储在当前写入的节点上，不会被分散到多台服务器上。   | 本地表的写入和查询，受限于单台服务器的存储、计算资源，不具备横向拓展能力。分布式表的写入和查询，可以利用多台服务器的存储、计算资源，具有较好的横向拓展能力。 |
| 分布式表（Distributed Table） | 本地表的集合，它将多个本地表抽象为一张统一的表，对外提供写入、查询功能。当写入分布式表时，数据会被自动分发到集合中的各个本地表中；当查询分布式表时，集合中的各个本地表都会被分别查询，并且把最终结果汇总后返回。 |                                                              |

```
-- 创建分布式表
CREATE TABLE example_table ON CLUSTER your_cluster_name
(
    id UInt32,
    name String
) ENGINE = MergeTree()
ORDER BY id;

-- 创建本地表
CREATE TABLE example_table_local
(
    id UInt32,
    name String
) ENGINE = MergeTree()
ORDER BY id;

-- 插入数据
INSERT INTO example_table VALUES (1, 'Alice'), (2, 'Bob');
```

[表引擎](https://clickhouse.com/docs/zh/engines/table-engines)

-- 查看数据库引擎
clickhouse-client --password="123456" --query "SELECT name, engine FROM system.tables WHERE database = 'tutorial';"


### Clickhouse  监控

[内置高级可观测性仪表板](https://clickhouse.ac.cn/docs/en/operations/monitoring)  

监控信息：http://114.67.240.27:8123/dashboard  默认 default/123456 (初始化设置的密码)

修改内置监控仪表盘时区
```
查看数据库时区
clickhouse-client --password 123456 --query "SELECT timezone();"

cat /etc/clickhouse-server/config.xml
修改 <timezone>UTC</timezone> 为 <timezone>Asia/Shanghai</timezone>

重启服务
service clickhouse-server restart
service clickhouse-server status
```

[Grafana+Prometheus 监控](../../SoftwareTest/监控体系/Prometheus+Grafana)

curl http://localhost:9363/metrics|less


https://clickhouse.com/docs/zh/operations/server-configuration-parameters/settings#server_configuration_parameters-prometheus

模板ID：14192（推荐）

搜索 Clickhouse 模板
https://grafana.com/grafana/dashboards/?search=clickhouse

在 Grafana 导入 Clickhouse 模板

踩坑：Grafana 面板无法展示 Clickhouse 数据
原因：数据源是写的固定的，如果当前要显示的监控数据的数据源名称跟这个不同，就会报错。
解决：将 json 文件中所有的 uid更换为当前监控数据的数据源名称，然后再将其导入，例如：prometheus



### [ClickHouse 和 MySQL 映射](https://clickhouse.com/docs/zh/engines/database-engines/mysql)

```
在 MySQL 创建数据库 existing_database
CREATE DATABASE existing_database;

在 MySQL 数据库 existing_database 创建数据表 mysql_table
CREATE TABLE existing_database.`mysql_table` (
`int_id` INT NOT NULL AUTO_INCREMENT,
`float` FLOAT NOT NULL,
PRIMARY KEY (`int_id`));

在 MySQL 数据库 existing_database 数据表 mysql_table 插入数据
insert into existing_database.mysql_table (`int_id`, `float`) VALUES (1,2);

ClickHouse 和 MySQL 映射
CREATE DATABASE [IF NOT EXISTS] db_name [ON CLUSTER cluster] ENGINE = MySQL('host:port', ['database' | database], 'user', 'password')
CREATE DATABASE IF NOT EXISTS db_name ENGINE = MySQL('114.67.240.27:3306', 'existing_database', 'root', '123456')
- host:port — MySQL服务地址
- database — MySQL数据库名称
- user — MySQL用户名
- password — MySQL用户密码

在 ClickHouse 查询数据表
clickhouse-client --password 123456 --query "SELECT * FROM db_name.mysql_table"

在 ClickHouse 插入数据表
clickhouse-client --password 123456 --query "INSERT db_name.mysql_table (`int_id`, `float`) VALUES (3,4)"
```



### Clickhouse 配置

[分布式引擎](https://clickhouse.com/docs/zh/engines/table-engines/special/distributed)

在 /etc/clickhouse-server/config.xml 设置分区 replica

```
<macros>
    <shard>01</shard>
    <replica>02</replica>
</macros>

- <shard>： 表示当前分片的标识符。分片是 ClickHouse 中的一个基本单元，分片将数据分布到不同的服务器以实现负载均衡和高可用性。例如，<shard>01</shard> 代表这是第一个（或编号为 01 的）分片。
- <replica>： 表示当前副本的标识符。副本是分片的一个拷贝，确保了数据的冗余和高可用性。例如，<replica>02</replica> 代表这是第二个（或编号为 02 的）副本。

<shard>
    <!-- 可选的。写数据时分片权重。 默认: 1. -->
    <weight>1</weight>
    <!-- 可选的。是否只将数据写入其中一个副本。默认值:false(将数据写入所有副本)。 -->
    <internal_replication>false</internal_replication>
    <replica>
        <!-- 可选的。负载均衡副本的优先级，请参见（load_balancing 设置)。默认值:1(值越小优先级越高)。 -->
        <priority>1</priority>
        <host>example01-01-1</host>
        <port>9000</port>
    </replica>
    <replica>
        <host>example01-01-2</host>
        <port>9000</port>
    </replica>
</shard>
<shard>
    <weight>2</weight>
    <internal_replication>false</internal_replication>
    <replica>
        <host>example01-02-1</host>
        <port>9000</port>
    </replica>
    <replica>
        <host>example01-02-2</host>
        <secure>1</secure>
        <port>9440</port>
    </replica>
</shard>
```

<interserver_http_host> 参数用于配置集群中服务器之间的 HTTP 通信。

允许外网访问需修改如下配置：

```
vim /etc/clickhouse-server/config.xml 去掉下方配置的注释

<listen_host>0.0.0.0</listen_host>

重启服务
service clickhouse-server restart
```

vim /etc/clickhouse-server/config.xml, 将 prometheus 这一项原先的注释放开，使其生效。

```
<prometheus>
    <endpoint>/metrics</endpoint>
    <port>9363</port>

    <metrics>true</metrics>
    <events>true</events>
    <asynchronous_metrics>true</asynchronous_metrics>
</iprometheus>
```



## 4. 知识碎片

```
-- 查询日志
select query_id,
ProfileEvents['QueryCacheHits']   AS query_cache,
query_duration_ms / 1000          AS query_duration,
formatReadableSize(memory_usage)  AS memory_usage,
formatReadableQuantity(read_rows) AS read_rows,
formatReadableSize(read_bytes)    AS read_data
from system.query_log

-- 查询时区
clickhouse-client --password 123456 --query "SELECT timezone();"

-- 此系统表包含可以即时计算或具有当前值的指标。例如，同时处理的查询数量或当前的复制延迟。这个表始终是最新的
clickhouse-client --password 123456 --query "SELECT * FROM system.metrics;"

-- 待定
clickhouse-client --password 123456 --query "SELECT * from system.tables;"

-- 查询副本
clickhouse-client --password 123456 --query "SELECT * from system.replicas"
clickhouse-client --password 123456 --query "SELECT database, table, engine, zookeeper_path, replica_path from system.replicas"
clickhouse-client --password 123456 --query "desc system.replicas"

-- 查询集群
clickhouse-client --password 123456 --query "select * from system.clusters;"
clickhouse-client --password 123456
SELECT
    cluster,
    shard_num,
    replica_num,
    host_name,
    is_local,
    user,
    database_shard_name,
    database_replica_name
FROM system.clusters
clickhouse-client --password 123456 --query "SHOW CLUSTERS"
```



clickhouse-client --password="123456" --query "SHOW databases"


clickhouse-client --password 123456