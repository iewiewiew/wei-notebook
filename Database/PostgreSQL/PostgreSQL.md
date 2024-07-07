[TOC]

<h1 align="center">PostgreSQL</h1>

> By：weimenghua  
> Date：2022.11.24  
> Description：PostgreSQL 关系型数据库

**参考资料**  
[PostgreSQL 下载](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)  
[PostgreSQL 下载](https://www.postgresql.org/download/linux/redhat/)  
[PostgreSQL 教程](https://www.runoob.com/postgresql/postgresql-tutorial.html)



### 1. PostgreSQL 搭建

```
运行容器
docker run -d \
--name postgres \
--restart=always \
-p 5432:5432 \
-v /root/postgresql:/var/lib/postgresql/data \
-e POSTGRES_PASSWORD=postgres \
postgres

用户名：postgres
密码：postgres
数据库名：postgres
```



### 2. PostgreSQL 教程

**PostgreSQL 语法**

[详细查看](./PostgreSQL.sql)

**进入 postgres**
```
docker exec -it postgres /bin/bash

切换到 postgres 用户（注：可不切换）
su - postgres

使用 psql 命令登录 PostgreSQL 控制台
方式一：psql
方式二：psql -h 127.0.0.1 -p 5432 -U postgres，输入密码
方式三：psql -h postgresql.comm.svc.cluster.local -p 5432 -U postgres，输入密码

查看帮助
\help <command_name>

查看数据库
\l

进入数据库
\c <数据库名> 举例：\c dbname

查看当前数据库下的表
\d

退出当前事务
ABORT 
```

**备份和恢复**
```
进入 pod 进行操作备份和恢复 pg

备份
export DB=automation; PGPASSWORD="root" pg_dump -h postgres-master -p 5432 -U postgres -d $DB --clean --role "postgres" --format custom --blobs --encoding UTF8 --verbose --file "/bitnami/postgresql/data/pgsql.$DB.dump"

恢复
export DB=automation; PGPASSWORD="root" pg_restore -h postgres-master -p 5432 -U "postgres" -d "dbname" --role "postgres" --clean --verbose "/bitnami/postgresql/data/pgsql.$DB.dump"
```

**测试连接**
```
在 /bin/sh 中执行 pg_isready 命令，以检查本地主机上 PostgreSQL 数据库服务器是否准备好接受名为 "postgres" 的数据库的连接，使用用户名 "postgres"，连接端口为 5432
/bin/sh -c exec pg_isready -U "postgres" -d "dbname=postgres" -h 127.0.0.1 -p 5432
```

k8s
```
进入容器
kubectl --insecure-skip-tls-verify exec -it -n <namespace> <pod-name> --container <container-name> -- bash

获取 PostgreSQL 服务的集群 IP 地址和端口号
kubectl get svc <postgresql-service-name> -n <namespace>

使用 psql 命令连接到 PostgreSQL 数据库，执行命令后输入密码
psql -h <postgresql-service-ip> -p <postgresql-service-port> -d <database-name> -U <username> -W

\l            # 查看数据库
\c <数据库名>  # 进入数据库
\d            # 查看当前数据库下的表
ABORT         # 退出当前事务
```

**PostgreSQL 模式**

PostgreSQL 模式（SCHEMA）可以看着是一个表的集合。  
一个模式可以包含视图、索引、数据类型、函数和操作符等。  
相同的对象名称可以被用于不同的模式中而不会出现冲突，例如 schema1 和 myschema 都可以包含名为 mytable 的表。

使用模式的优势：
允许多个用户使用一个数据库并且不会互相干扰。  
将数据库对象组织成逻辑组以便更容易管理。  
第三方应用的对象可以放在独立的模式中，这样它们就不会与其他对象的名称发生冲突。  
模式类似于操作系统层的目录，但是模式不能嵌套。



### 3. 知识碎片

**JDBC 驱动**  
[JDBC PostgreSQL 驱动下载](https://jdbc.postgresql.org/download/)    
URL：jdbc:postgresql://127.0.0.1:5432/postgres  
驱动：org.postgresql.Driver

**修改连接数**

```
-- 查看 pgsql 配置的最大连接数
show max_connections;

-- 修改最大连接数
-- 方式一
alter system set max_connections=10;
-- 方式二
-- cat /root/postgresql/postgresql.conf |grep max_connections
-- sed -i 's/max_connections = 5/max_connections = 10/' /root/postgresql/postgresql.conf

超过连接数的报错
报错一
Cannot create PoolableConnectionFactory (FATAL: remaining connection slots are reserved for non-replication superuser connections)
报错二
Error preloading the connection pool
```

**踩坑**  
报错：Cannot create PoolableConnectionFactory (尝试连线已失败。)  
原因：URL 的 IP 写错了

注：不是很理解  
在PostgreSQL（pgsql）中，P模式、B模式、E模式和S模式是与通信协议相关的概念，用于描述在客户端和服务器之间交换的不同类型的报文。
1. P模式（Protocol Mode）：P模式是指客户端与服务器之间的初始通信模式。在P模式下，客户端发送一个连接请求报文给服务器，服务器接受连接并返回一个确认报文。在接受连接后，客户端和服务器可以进入其他模式，如B模式或E模式。
2. B模式（Binary Mode）：B模式是指在客户端和服务器之间传输二进制数据的通信模式。在B模式下，客户端和服务器可以通过直接的二进制格式进行数据交换。这种模式通常用于传输大量数据或二进制数据，可以提供更高的性能和效率。
3. E模式（Extended Query Mode）：E模式是指在客户端和服务器之间进行扩展查询的通信模式。在E模式下，客户端可以发送更复杂和高级的SQL查询语句给服务器，并接收查询结果。这种模式通常用于支持特定的扩展功能或高级查询需求。
4. S模式（Simple Query Mode）：S模式是指在客户端和服务器之间进行简单查询的通信模式。在S模式下，客户端可以发送简单的SQL查询语句给服务器，并接收查询结果。这种模式通常用于处理简单的查询操作，不涉及复杂的查询语句或特殊功能。