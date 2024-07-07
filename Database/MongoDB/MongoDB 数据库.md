[TOC]

<h1 align="center">MongoDB 数据库</h1>

> By：weimenghua  
> Date：2022.09.18  
> Description：MongoDB  

**参考资料**  
[MongoDB 官网](https://www.mongodb.com/zh-cn)  
[MongoDB 教程](https://www.runoob.com/mongodb/mongodb-tutorial.html)  



## 1. MongoDB 搭建

### 1.1 Linux

```
查看 mongo 版本
mongo --version             

备份恢复 mongodb
//如果是在本地导入导出，端口也没有更改的情况下，-h 和--port 参数可选；如果没有设置密码情况下，-u 和-p 参数也可以不用加
备份格式：/data/mongodb/bin/mongodump -h IP --port 端口号 -u 用户 -p 密码 -d 数据库名 -o 存储路径
举例：/usr/local/mongodb4/bin/mongodump -d easy-mock -o /tmp/
恢复格式：/mnt/mongodb/bin/mongorestore -h IP --port 端口号 -u 用户名 -p 密码  -d 数据库名 备份的文件夹名

安装 mongodump  
重新安装 mongodb 4.4版本之后，发现 mongodb bin 路径下没有了 mongodump 等相关工具，需要自行下载，然后解压放到安装好的路径之下， 官网下载地址：https://www.mongodb.com/try/download/database-tools, 将 mongodump 放到原先 easy-mock 的 bin 目录下。  
注：查看 Linux 版本：cat /etc/os-release; 或者 cat /proc/version;
```

### 1.2 Docker

```
创建目录
mkdir -vp /root/software/mongo

运行容器（无密码）
docker run -d \
--name mongodb \
--restart always \
--privileged \
-p 27017:27017 \
-v /root/software/mongo:/data/db \
mongo

运行容器
docker run -d \
--name=mongodb \
--restart=always \
--privileged \
-p 27017:27017 \
-v /root/software/mongo:/data/db \
-e MONGO_INITDB_ROOT_USERNAME=admin \
-e MONGO_INITDB_ROOT_PASSWORD=admin \
mongo --auth

查看日志
docker logs -f mongodb

进入容器
docker exec -it mongodb /bin/bash

进入数据库（MongoDB 6.0 及以上版本使用以下命令）
docker exec -it mongodb mongosh admin

创建一个名为 root，密码为 root 的用户
db.createUser({ user:'root',pwd:'root',roles:[ { role:'userAdminAnyDatabase', db: 'admin'},"readWriteAnyDatabase"]});

尝试使用上面创建的用户信息进行连接
db.auth('root', 'root');
```

**权限说明**
```
read	允许用户读取指定数据库
readWrite	允许用户读写指定数据库
dbAdmin	允许用户在指定数据库中执行管理函数，如索引创建、删除，查看统计或访问 system.profile
userAdmin	允许用户向 system.users 集合写入，可以在指定数据库里创建、删除和管理用户
clusterAdmin	只在 admin 数据库中可用，赋予用户所有分片和复制集相关函数的管理权限
readAnyDatabase	只在 admin 数据库中可用，赋予用户所有数据库的读权限
readWriteAnyDatabase	只在 admin 数据库中可用，赋予用户所有数据库的读写权限
userAdminAnyDatabase	只在 admin 数据库中可用，赋予用户所有数据库的 userAdmin 权限
dbAdminAnyDatabase	只在 admin 数据库中可用，赋予用户所有数据库的 dbAdmin 权限
root	只在 admin 数据库中可用。超级账号，超级权限
```



## 2. MongoDB 教程

### 2.1 MongoDB 连接
```
格式
mongodb://[username:password@]host1[:port1][,host2[:port2],...[,hostN[:portN]]][/[database][?options]]

举例
mongodb://admin:123456@localhost/test
```

- mongodb:// 这是固定的格式，必须要指定。
- username:password@ 可选项，如果设置，在连接数据库服务器之后，驱动都会尝试登录这个数据库
- host1 必须的指定至少一个 host, host1 是这个 URI 唯一要填写的。它指定了要连接服务器的地址。如果要连接复制集，请指定多个主机地址。
- portX 可选的指定端口，如果不填，默认为27017
- /database 如果指定 username:password@，连接并验证登录指定数据库。若不指定，默认打开 test 数据库。
- ?options 是连接选项。如果不使用/database，则前面需要加上/。所有连接选项都是键值对 name=value，键值对之间通过&或;（分号）隔开



### 2.2 MongoDB 概念解析

| SQL 术语/概念 | MongoDB 术语/概念 | 解释/说明                           |
| ------------ | ---------------- | ----------------------------------- |
| database     | database         | 数据库                              |
| table        | collection       | 数据库表/集合                       |
| row          | document         | 数据记录行/文档                     |
| column       | field            | 数据字段/域                         |
| index        | index            | 索引                                |
| table joins  |                  | 表连接,MongoDB 不支持                |
| primary key  | primary key      | 主键,MongoDB 自动将_id 字段设置为主键 |



### 2.3 MongoDB 语法
**保留数据库**  
- admin：从权限的角度来看，这是"root"数据库。要是将一个用户添加到这个数据库，这个用户自动继承所有数据库的权限。一些特定的服务器端命令也只能从这个数据库运行，比如列出所有的数据库或者关闭服务器。
- local：这个数据永远不会被复制，可以用来存储限于本地单台服务器的任意集合。
- config：当 Mongo 用于分片设置时，config 数据库在内部使用，用于保存分片的相关信息。

MongoDB 中默认的数据库为 test，如果你没有创建新的数据库，集合将存放在 test 数据库中。
在 MongoDB 中，集合只有在内容插入后才会创建! 就是说，创建集合(数据表)后要再插入一个文档(记录)，集合才会真正创建。

MongoDB 中没有像 MySQL 中的 .sql 文件那样的特定文件格式。保存 MongoDB 查询和命令的文件通常使用 .js 扩展名。将 js 文件传递给 mongo shell 执行。  
`load("MongoDB 集合.js")`

[MongoDB 集合](./MongoDB%20集合.js)

```

-- 查看数据库
show dbs;

-- 进入某个数据库
use local;

-- 创建数据库, 如不存在则创建, 往数据库里面插入表才能查到数据库
use dbname;

-- 删除数据库
use dbname2;
db.dropDatabase();


-------------------------------------------------------------


-- 查看集合
show collections;

-- 创建集合
db.table_demo.insertOne({user_id: "abc123",age: 20,status: "A"});
db.table_demo2.insertOne({user_id: "abc1234",age: 20,status: "A"});
db.createCollection("table_demo3")

-- 删除集合
db.table_demo3.drop()


-------------------------------------


-- 插入数据
db.table_demo.create({'user_id':'zhangsan','age':18,'status':'A'});

-- 更新数据
db.table_demo.upadateMany({},{ $set:{ status:'D' }}); -- 更改全部 status: "D"
db.table_demo.upadateMany({ status: "C" },{ $set:{ status:'D' }}); -- 将 status: "C"的年龄更改为 20岁

-- 查询数据
db.getCollection('table_demo').find({});
db.getCollection('table_demo').find({"_id":1});

-- 查询所有
db.table_demo.find();
-- 返回指定字段
db.table_demo.find({},{ user_id: 1, status: 1 });
-- 不显示 id
db.table_demo.find({},{ _id: 0, user_id: 1, status: 1 });

-- 查询 status:"A"的所有
db.table_demo.find({ status: "A" });
-- 并返回指定的字段
db.table_demo.find({ status: "A" },{ _id: 0, user_id: 1, status: 1 });
-- 查询 status!= "A"的所有
db.table_demo.find({ status: { $ne: "A" } });

-- status="A" and age=50
db.table_demo.find({ status: "A" ,age: 55});
-- status="A" or age=50
db.table_demo.find({ $or:[{ status: "A" ,age: 55}] });

-- age>25
db.table_demo.find({ age: { $gt: 25 } });
-- age<25
db.table_demo.find({ age: { $lt: 25 } });
-- age>25 and age<=50
db.table_demo.find({ age: { $gt: 25, $lte: 50 } });

-- 模糊查询
db.table_demo.find({ user_id: /bc/ });
-- 模糊查询
db.table_demo.find({ user_id: { $regex: /bc/ } });
-- 模糊查询
db.table_demo.find({ user_id: /^bc/ });
-- 模糊查询
db.table_demo.find({ user_id: { $regex: /^bc/ } });


-- 1升序
db.table_demo.find( { status: "A" } ).sort( { user_id: 1 } );
-- -1降序
db.table_demo.find( { status: "A" } ).sort( { user_id: -1 } );


-- 统计
db.table_demo.count()
db.table_demo.find().count()

db.table_demo.count( { user_id: { $exists: true } } )-- 指定字段统计总数
db.table_demo.find( { user_id: { $exists: true } } ).count()


-- 去重
db.table_demo.aggregate( [ { $group : { _id : "$status" } } ] )
db.table_demo.distinct( "status" )


-- 获取指定条数
db.table_demo.findOne(); -- findOne 每次只能获取一条数据 
db.table_demo.find().limit(1); -- limit 可获取指定条数
db.table_demo.find().limit(5).skip(10); -- 从索引为5获取10条数据
```