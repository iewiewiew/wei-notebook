[TOC]

<h1 align="center">Docker_Install</h1>

> By：weimenghua  
> Date：2022.07.24  
> Description：Docker 安装软件

**参考资料**  
[乔克叔叔 DevOps](https://www.yuque.com/coolops)



**公共命令**

注意：端口映射和目录映射左边是服务器

```
搜索镜像
docker search <镜像名称>
docker search jenkins

拉取镜像
docker pull <所属组织？>/<镜像名称>
docker pull jenkins/jenkins

进入容器
docker exec -it <容器名称> /bin/bash
docker exec -it mysql /bin/bash

在容器执行命令
docker exec -it <容器名称> <执行命令>
docker exec -it mysql cat /etc/my.cnf

查看日志
docker logs -f <容器名称>
docker logs -f jenkins

删除容器
docker rm -f <容器名称>
docker rm -f jenkins

将容器中的目录复制到宿主机中
docker cp <容器名称>:<文件目录> <文件目录>
docker cp mysql:/var/lib/mysql /var/lib/mysql

将容器中的文件复制到宿主机中
docker cp <容器名称>:<文件名称> <文件名称>
docker cp mysql:/etc/my.cnf /etc/my.cnf
```

镜像地址
- dockerpull.com



## 1. 数据库

### Docker 安装 MySQL

[MySQL 安装文档](https://github.com/bitnami/bitnami-docker-mysql)

```
运行容器
docker run -d \
--name mysql \
--restart always \
-p 3306:3306 \
-v /var/lib/mysql:/var/lib/mysql \
-v /etc/my.conf:/etc/my.conf \
-e MYSQL_ROOT_PASSWORD=root \
dockerpull.com/mysql:8.0

目录挂载（待定）

进入容器
docker exec -it mysql bash

配置
第一次 mysql -u root -p 输入 root 密码：root
use mysql;
alter user 'root'@'%' identified with mysql_native_password by 'root';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION; -- MySQL8
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; -- MySQL5.7
flush privileges;
select host,user,plugin,authentication_string from mysql.user;

修改 root 用户的 root 密码为 123456
ALTER USER 'root'@'%' IDENTIFIED BY '123456';
flush privileges;

解决时差问题
docker cp /usr/share/zoneinfo/Asia/Shanghai mysql:/etc/localtime
docker restart mysql
```



### Docker 安装 Redis

```
运行容器
docker run -d \
--name redis \
-p 6379:6379 \
-v /root/redis/redis.conf:/etc/redis/redis.conf \
-v /root/redis/data:/data \
redis \
redis-server /etc/redis/redis.conf --appendonly yes --requirepass "root"

参数说明
redis-server --appendonly yes --requirepass "root": 在容器执行 redis-server 启动命令，并打开 redis 持久化配置, 以及设置密码

进入 redis 客户端
docker exec -it redis redis-cli
```



### Docker 安装 redisinsight

```
运行容器
docker run -d \
--name redisinsight \
-v /etc/localtime:/etc/localtime \
-v /root/docker/redisinsight:/db  \
-p 8001:8001 \
redislabs/redisinsight:latest

访问地址
http://127.0.0.1:8001/
```

![](./img/redisinsight.png)



### Docker 安装 Postgres

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



### Docker 安装 MongoDB

```
运行容器（无密码）
docker run -d \
--name mongodb \
--restart always \
--privileged \
-p 27017:27017 \
-v /root/docker/mongo:/data/db \
mongo

运行容器（有密码）
docker run -d \
--name=mongodb \
--restart=always \
--privileged \
-p 27017:27017 \
-v /root/docker/mongo:/data/db \
-e MONGO_INITDB_ROOT_USERNAME=admin \
-e MONGO_INITDB_ROOT_PASSWORD=admin \
mongo --auth

进入数据库（MongoDB 6.0 及以上版本使用以下命令）
docker exec -it mongodb mongosh admin

创建一个名为 root，密码为 root 的用户
db.createUser({ user:'root',pwd:'root',roles:[ { role:'userAdminAnyDatabase', db: 'admin'},"readWriteAnyDatabase"]});

尝试使用上面创建的用户信息进行连接
db.auth('root', 'root');
```



### Docker 安装 ClickHouse

```
运行容器
docker run -d \
--name ch-server \
--ulimit nofile=262144:262144 \
-p 9000:9000 \
-p 8123:8123 \
yandex/clickhouse-server

访问地址
http://127.0.0.1:8123/play

进入容器
docker exec -it ch-server /bin/bash

安装软件
apt-get update
apt-get install vim -y

进入 clickhouse-client
clickhouse-client

查看 clickhouse 数据库
show databases;

修改配置
vim /etc/clickhouse-server/users.xml 

采用 SHA256的方式加密，生成明码密文
PASSWORD=$(base64 < /dev/urandom | head -c8); echo "root"; echo -n "root" | sha256sum | tr -d '-'
root
4813494d137e1631bba301d5acab6e7bb7aa74ce1185d456565ef51d737677b2
密文写入
<password_sha256_hex>4813494d137e1631bba301d5acab6e7bb7aa74ce1185d456565ef51d737677b2</password_sha256_hex>
明文写入
<password>root</password>

客户端访问服务端
clickhouse-client -h 127.0.0.1 -d default -m -u default --password 'root'

查看日志
docker logs -f ch-server

删除容器
docker rm -f ch-server
```



### Docker 安装 Hive (未实践成功)

[下载 Hive 仓库](https://github.com/big-data-europe/docker-hive)

[在线体验 SQL](https://gethue.com/)

```
git clone https://github.com/big-data-europe/docker-hive.git

cd docker-hive

启动容器
docker-compose up -d

指定文件路径启动容器
docker-compose -f docker-compose-hive.yml up -d

连接到 Hive 容器
docker exec -it docker-hive-hive-server-1 bash

删除容器
docker-compose down

查找 Docker 主机的 IP 地址
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' docker-hive-hive-server-1

实际上用主机ip
jdbc:hive2://<docker-host-ip>:10000/default
```

在 Hive 容器中，运行 Hive 查询、创建表、加载数据等操作
```
进入 hive
hive

-- 创建一个示例表
CREATE TABLE example_table (id INT, name STRING);

-- 插入数据
INSERT INTO example_table VALUES (1, 'Alice'), (2, 'Bob');

-- 查询数据
SELECT * FROM example_table;

-- 测试
create table pokes(foo INT, bar STRING);
load data local inpath '/opt/hive/examples/files/kv1.txt' overwrite into table pokes;
select * from pokes limit 10;
```

http://127.0.0.1:50070/

![Hadoop Web](./img/hadoop_web.png)

http://127.0.0.1:8080/

![Hadoop Cluster](./img/hadoop_cluster.png)



## 2. 监控

### Docker 安装 Grafana

```
拉取镜像
docker pull dockerpull.com/grafana/grafana:latest

运行容器
docker run -d \
--name grafana \
-p 3000:3000 \
grafana/grafana

从容器复制文件到宿主机
cd /root/grafana && rm -rf *
docker cp grafana:/etc/grafana /root/grafana/conf
docker cp grafana:/var/lib/grafana /root/grafana/data
docker cp grafana:/var/log/grafana /root/grafana/log

踩坑：必须得先设置分配用户，否则会报权限错误问题
useradd grafana -g -472
groupadd grafana -g 472
chown -R grafana:grafana grafana

重新运行运行容器
docker run -d \
--name grafana \
-p 3000:3000 \
-v /root/grafana/conf:/etc/grafana \
-v /root/grafana/data:/var/lib/grafana \
-v /root/grafana/log:/var/log/grafana \
grafana/grafana

访问地址
http://127.0.0.1:3000/login admin/admin

仪表盘模板地址
https://grafana.com/grafana/dashboards/
```



### Docker 安装 Prometheus

```
官网：https://prometheus.io/

拉取镜像
docker pull dockerpull.com/prom/prometheus:latest

添加配置
mkdir -vp /root/prometheus && cd /root/prometheus
cat >> prometheus.yml <<EOF
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: "prometheus"
    static_configs:
    - targets: ["localhost:9090","127.0.0.1:9100"]
# 127.0.0.1:9100 是 xxx-exporter 的地址
EOF

运行容器
docker run -d \
--name prometheus \
-p 9090:9090 \
-v /root/prometheus:/etc/prometheus \
prom/prometheus

访问地址
http://127.0.0.1/9090
```



### Docker 安装 Influxdb

```
运行容器 8083是 influxdb 的 web 管理工具端口，8086是 influxdb 的 HTTP API 端口
docker run -d \
--name influxdb \
-p 8083:8083 \
-p 8086:8086 \
-v /root/influxdb:/var/lib/influxdb \
tutum/influxdb

docker run -d \
--name influxdb \
-p 8086:8086 \
-v /root/influxdb:/var/lib/influxdb \
influxdb:1.8

进入容器
docker exec -it influxdb /bin/bash
cd /usr/bin				 # bin 目录存在如下文件，可以在任意目录执行 influxd、influx
influxd            # influxdb 服务端
influx             # influxdb 命令行客户端
influx_inspect     # 查看工具
influx_stress      # 压力测试工具
influx_tsm         # 数据库转换工具（将数据库从 b1或 bz1格式转换为 tsm1格式）

influxd config > /etc/influxdb/influxdb.conf  	#可不执行
cat /etc/influxdb/influxdb.conf
cat /usr/lib/influxdb/scripts/influxdb.service

docker cp influxdb:/etc/influxdb/influxdb.conf /root/docker/influxdb
docker cp /root/influxdb/influxdb.conf influxdb:/etc/influxdb/influxdb.conf

创建数据
show users;
create user "root" with password 'root' with all privileges;
create database jmeter;
show databases;
use jmeter;
show measurements;
insert jmeter,key=age value="18";
select * from jmeter;

启动客户端执行 sql
influx -host localhost -port 8086 -database jmeter -username 'root' -password 'root' -execute 'select * from jmeter'
influx -host localhost -port 8086 -database jmeter -username 'root' -password 'root' -execute 'create database jmeter;'

访问地址
http://127.0.0.1:8083/


方式二
docker run --rm influxdb:2.1.1 influxd print-config > config.yml

docker run -d \
--name influxdb \
-p 8086:8086 \
-v /root/influxdb/config.yml:/etc/influxdb2/config.yml \
-v /root/influxdb:/var/lib/influxdb2 \
influxdb:2.1.1

docker exec -it influxdb /bin/bash

访问地址
http://127.0.0.1:8086/ admin/admin123456

influx config create -n default \
-u http://localhost:8086 \
-o my-org \
-t 0rTwpq3Nmh0XXGtH4yDo6uMj-m8TNaDC-U424Dwt8mLZCg6MM13Z7E-LewmS2T2z6YAbB4c-qLAlbTWNqZ-L7Q== \
-a

export INFLUX_TOKEN=0rTwpq3Nmh0XXGtH4yDo6uMj-m8TNaDC-U424Dwt8mLZCg6MM13Z7E-LewmS2T2z6YAbB4c-qLAlbTWNqZ-L7Q==
```



### Docker 安装 node-exporter

```
运行容器
docker run -d \
--name node-exporter \
-p 9100:9100 \
-v /root/node-exporter/proc:/host/proc:ro \
-v /root/node-exporter/sys:/host/sys:ro \
-v /root/node-exporter:/root/dockerfs:ro \
prom/node-exporter

访问地址
http://127.0.0.1:9100
```



### Docker 安装 mysqld-exporter

```
#DATA_SOURCE_NAME="用户名:密码@(mysqlip:port)"
docker run -d \
  --name mysqld-exporter
  -p 9104:9104 \
  --net="host" \
  --pid="host" \
  -e DATA_SOURCE_NAME="root:root@(127.0.0.1:3306)/" \
  prom/mysqld-exporter
  
在 prometheus.yml 添加：
  - job_name: "mysql"
    static_configs:
    - targets: ["127.0.0.1:9104"]
注：- job_name 上方留空行

访问
http://127.0.0.1:9104/metrics

添加数据源：http://127.0.0.1:9090，注：不是9104
MySQL 监控模板 ID：7362
```



## 3. 消息队列

### Docker 安装 RocketMQ

```
一、安装 RocketMQ
1、拉取镜像
docker pull rocketmqinc/rocketmq

2、创建文件夹
在 /root/docker/software 目录下新建文件夹 mq
mkdir mq
/root/docker/software/mq

3、启动容器
docker run -d --restart=always \
-p 9876:9876  \
-v /root/docker/software/mq/data/namesrv/logs:/root/docker/logs \
-v /root/docker/software/mq/data/namesrv/store:/root/docker/store \
--name rmqnamesrv -e "MAX_POSSIBLE_HEAP=100000000" \
rocketmqinc/rocketmq sh mqnamesrv

4、查看日志
docker logs -f rmqnamesrv

5、删除容器
docker rm -f rmqnamesrv



二、安装 broker
1、创建 broker.conf 文件
cd /root/docker/software/mq/conf

vim broker.conf
brokerClusterName = DefaultCluster
brokerName = broker-a
brokerId = 0
deleteWhen = 04
fileReservedTime = 48
brokerRole = ASYNC_MASTER
flushDiskType = ASYNC_FLUSH
brokerIP1 = 127.0.0.1

cat /root/docker/software/mq/conf/broker.conf

2、启动容器
docker run -d --restart=always --name rmqbroker \
-p 10911:10911 -p 10909:10909 \
-v /root/docker/software/mq/data/broker/logs:/root/docker/logs \
-v /root/docker/software/mq/rocketmq/data/broker/store:/root/docker/store \
-v /root/docker/software/mq/conf/broker.conf:/opt/rocketmq-4.4.0/conf/broker.conf \
--link rmqnamesrv:namesrv -e "NAMESRV_ADDR=namesrv:9876" \
-e "MAX_POSSIBLE_HEAP=200000000" rocketmqinc/rocketmq:4.4.0 sh mqbroker \
-c /opt/rocketmq-4.4.0/conf/broker.conf

3、查看日志
docker logs -f rmqbroker

4、删除容器
docker rm -f rmqbroker


三、安装 rocketmq 控制台
1、拉取镜像
docker pull styletang/rocketmq-console-ng

2、启动 rocketmq 控制台
docker run -d --restart=always --name rocketmq-console-ng \
-p 8080:8080 \
-e "JAVA_OPTS=-Drocketmq.namesrv.addr=127.0.0.1:9876  \
-Dcom.rocketmq.sendMessageWithVIPChannel=false" \
-t styletang/rocketmq-console-ng

3、查看日志
docker logs -f rocketmq-console-ng

4、访问控制台
http://127.0.0.1:8080/

5、删除容器
docker rm -f rocketmq-console-ng

注意：
1、IP 地址要公网的
2、开放端口8080、10909、10911、9876
```



### Docker 安装 Rabbitmq

```
拉取镜像
docker pull rabbitmq:management

启动容器
docker run -id --hostname my-rabbit \
--name rabbitmq \
-p 15672:15672 \
-p 5672:5672 \
-e RABBITMQ_DEFAULT_USER=admin \
-e RABBITMQ_DEFAULT_PASS=admin \
rabbitmq:management

访问地址
http://127.0.0.1:15672 admin/admin

查看日志
docker logs -f rabbitmq
```



### Docker 安装 Zookeeper

```
1、搜索惊喜
docker search zookeeper

2、拉取镜像
docker pull zookeeper

3、运行容器
mkdir data conf logs
docker run -d \
--name zookeeper \
--restart=always \
--privileged=true \
--net=kafka_zk_net \
--log-driver json-file --log-opt max-size=100m --log-opt max-file=2 \
-p 2181:2181 \
-v /root/docker/software/zookeeper/data:/data \
-v /root/docker/software/zookeeper/conf:/conf \
-v /root/docker/software/zookeeper/logs:/datalog \
-v /etc/localtime:/etc/localtime \
zookeeper

4、配置
在 conf 目录下创建文件 zoo.cfg
vim zoo.cfg
# The number of  milliseconds of each tick
tickTime=2000
# The number of ticks that the initial
# synchronization phase can take
initLimit=10
# The number of ticks that can pass between
# sending a request and getting an acknowledgement
syncLimit=5
# the directory where the snapshot is stored.
# do not use /tmp for storage, /tmp here is just
# example sakes.
dataDir=/data
# the port at which the clients will connect
clientPort=2181
# the maximum number of client connections.
# increase this if you need to handle more clients
#maxClientCnxns=60
#
# Be sure to read the maintenance section of the
# administrator guide before turning on autopurge.
#
# http://zookeeper.apache.org/doc/current/zookeeperAdmin.html#sc_maintenance
#
# The number of snapshots to retain in dataDir
#autopurge.snapRetainCount=3
# Purge task interval in hours
# Set to "0" to disable auto purge feature
#autopurge.purgeInterval=1
 
## Metrics Providers
#
# https://prometheus.io Metrics Exporter
#metricsProvider.className=org.apache.zookeeper.metrics.prometheus.PrometheusMetricsProvider
#metricsProvider.httpPort=7000
#metricsProvider.exportJvmInfo=true

5、查看日志
docker logs -f zookeeper

6、查看容器状态
docker exec -it zookeeper /bin/bash ./bin/zkServer.sh status

7、删除容器
docker rm -f zookeeper

8、运行客户端
docker exec -it zookeeper zkCli.sh
docker run -it --rm --link zookeeper:zookeeper zookeeper zkCli.sh -server zookeeper
```



### Docker 安装 Kafka

```
1、搜索镜像
docker search kafka

2、创建通信网络
zookeeper 和 kafka 之间的通信
docker network create kafka_zk_net

查看网络
docker network ls
docker network inspect kafka_zk_net

3、运行容器
docker run -d \
--name kafka \
--net=kafka_zk_net \
-p 9092:9092 \
-e ALLOW_PLAINTEXT_LISTENER=yes \
-e KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper:2181 \
-e KAFKA_ADVERTISED_HOST_NAME=127.0.0.1 \
-e KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://127.0.0.1:9092 \
bitnami/kafka:latest
注：如果没有设置网络链接，zookeeper 名称需替换为服务器 ip

4、查看日志
docker logs -f kafka

5、启动生产者和消费者
docker exec -it kafka bash
cd /opt/bitnami/kafka/bin
生产者
./kafka-console-producer.sh --bootstrap-server localhost:9092 --topic topic1
消费者
./kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic topic1 --from-beginning

6、删除容器
docker rm -f kafka


1、运行 kafka 可视化容器（不好用）
docker run -d --name kafka-map \
-p 9001:8080 \
-v /root/docker/software/kafka/data:/usr/local/kafka-map/data \
-e DEFAULT_USERNAME=admin \
-e DEFAULT_PASSWORD=admin \
--restart always dushixiang/kafka-map:latest

2、访问
http://127.0.0.1:9001/#/

3、运行 kafka 可视化容器
docker run -d --name kafdrop \
    -p 9000:9000 \
    --network kafka-network \
    -e KAFKA_BROKERCONNECT=your_kafka_broker_address:9092 \
    -e JVM_OPTS="-Xms32M -Xmx256M" \
    obsidiandynamics/kafdrop
```



## 4. 其它

### Docker 安装 Portainer

```
运行容器
docker run -d \
--name portainer \
--restart=always \
-p 9000:9000 \
-p 8000:8000 \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /root/docker/portainer/data:/data \
 portainer/portainer

访问地址：http://127.0.0.1:9000/
第一次登录的时候需要创建管理员账号
账号：admin
密码：admin12345678
```



### Docker 安装 Jenkins

```
启动容器
docker run -d \
--name=jenkins \
--restart=always \
-u root \
-p 5555:8080 \
-p 50000:50000 \
-v /var/jenkins_home:/var/jenkins_home \
-v /etc/localtime:/etc/localtime \
jenkins/jenkins
    
命令说明
-d：后台运行容器；
--name=jenkins：给容器起别名；
--restart=always：设置容器的重启策略为 Docker 重启时自动重启；
-p 8888:8080：将容器的 8080 端口映射到服务器的 8888 端口；
-p 50000:50000：将容器的 50000 端口映射到服务器的 50000 端口；
-v /var/jenkins_home:/var/jenkins_home：将容器中 Jenkins 的工作目录挂载到服务器的 /var/jenkins_home；
-v /etc/localtime:/etc/localtime：让容器使用和服务器同样的时间设置；

查看日志
docker logs jenkins

访问地址，账号密码：admin/admin
http://127.0.0.1:5555/

进入容器
docker exec -it jenkins bash

查看 Jenkins 默认密码
docker exec -it jenkins bash -c 'cat /var/jenkins_home/secrets/initialAdminPassword'
如做目录挂载，直接在宿主机执行
cat /var/jenkins_home/secrets/initialAdminPassword

进入容器把配置拷贝到宿主机
docker cp jenkins:/var/jenkins_home /var/jenkins_home

查看目录挂载
docker inspect jenkins | grep Mounts -A 20

删除容器
docker rm -f jenkins
```



### Docker 安装 Gitlab
[参考资料](https://docs.gitlab.cn/jh/install/docker.html)

```
搜索镜像
docker search gitlab

拉取镜像
docker pull gitlab/gitlab-ce

创建目录
mkdir config logs data

运行容器
docker run -d --restart always --name gitlab \
-p 443:443 \
-p 8082:80 \
-p 222:22  \
-v /root/docker/software/gitlab/config:/etc/gitlab \
-v /root/docker/software/gitlab/logs:/var/log/gitlab \
-v /root/docker/software/gitlab/data:/var/opt/gitlab \
gitlab/gitlab-ce

配置文件
vim /root/docker/software/gitlab/config/gitlab.rb
# 配置 http 协议所使用的访问地址,不加端口号默认为80
external_url 'http://1.12.237.48'
# 配置 ssh 协议所使用的访问地址和端口
gitlab_rails['gitlab_ssh_host'] = '1.12.237.48'
#配置超时设置
gitlab_rails['webhook_timeout'] = 90 
gitlab_rails['git_timeout']=90
docker restart gitlab

查看日志
docker logs -f gitlab

访问地址
http://1.12.237.48:8082

查看密码
docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password
root / 14u91F2B5/P4GoRxhjIWkslGoiL6xQ4SoBazO2gc520=
```



### Docker 安装 Gitlab Runner

```
运行容器
docker run -d \
--name gitlab-runner \
--restart always \
-v /var/run/docker.sock:/var/run/docker.sock \
-v `pwd`/config:/etc/gitlab-runner \
gitlab/gitlab-runner:latest
  
进入容器
docker exec -it gitlab-runner /bin/bash

注册 GitLab Runner
gitlab-runner register
gitlab-runner register  --url https://jihulab.com  --token <token>

查看配置文件
cat `pwd`/config/config.toml

重启容器
docker restart gitlab-runner
```



### Docker 安装 Minio

```
运行容器
docker run -d \
--restart=always \
--name minio \
-p 9090:9090 \
-p 9001:9001 \
-v /root/docker/minio/data:/data \
-e "MINIO_ROOT_USER=minioadmin" \
-e "MINIO_ROOT_PASSWORD=minioadmin" \
minio/minio server /data --console-address ":9090" -address ":9000"
  
访问地址
http://127.0.0.1:9090/login minioadmin/minioadmin 
```



### Docker 安装 xxl-job

```
官方文档
https://gitee.com/xuxueli0323/xxl-job/tree/master
https://www.xuxueli.com/xxl-job/

搜索镜像
docker search xxl-job

拉取镜像
docker pull xuxueli/xxl-job-admin:2.3.1

下载 sql 文件，导入 mysql 数据库，执行 tables_xxl_job.sql
wget https://raw.githubusercontent.com/xuxueli/xxl-job/2.3.1/doc/db/tables_xxl_job.sql
数据库说明
xxl_job_lock：任务调度锁表；
xxl_job_group：执行器信息表，维护任务执行器信息；
xxl_job_info：调度扩展信息表：用于保存 XXL-JOB 调度任务的扩展信息，如任务分组、任务名、机器地址、执行器、执行入参和报警邮件等等；
xxl_job_log：调度日志表：用于保存 XXL-JOB 任务调度的历史信息，如调度结果、执行结果、调度入参、调度机器和执行器等等；
xxl_job_log_report：调度日志报表：用户存储 XXL-JOB 任务调度日志的报表，调度中心报表功能页面会用到；
xxl_job_logglue：任务 GLUE 日志：用于保存 GLUE 更新历史，用于支持 GLUE 的版本回溯功能；
xxl_job_registry：执行器注册表，维护在线的执行器和调度中心机器地址信息；
xxl_job_user：系统用户表；

下载 application.properties 文件，修改数据库配置
wget https://raw.githubusercontent.com/xuxueli/xxl-job/2.3.1/xxl-job-admin/src/main/resources/application.properties

运行容器
docker run -d --name=xxl-job-admin \
--restart=always \
-p 18080:8080 \
-v /root/docker/xxl-job/application.properties:/application.properties \
-e PARAMS='--spring.config.location=/application.properties' xuxueli/xxl-job-admin:2.3.1

运行容器（指定数据库信息）
docker run --name xxl-job-admin \
-e PARAMS="--spring.datasource.url=jdbc:mysql://127.0.0.1:3306/xxl_job?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&serverTimezone=Asia/Shanghai" \
--spring.datasource.username=root \ 
--spring.datasource.password=root \
-p 18080:8080 \
-v /root/docker/xxl-job/data/applogs:/data/applogs \
-d xuxueli/xxl-job-admin:2.3.1

查看日志
docker logs -f xxl-job-admin

访问地址 admin/123456
http://127.0.0.1:18080/xxl-job-admin
```



### Docker 安装 zentao

```
官网地址
https://www.zentao.net/

运行容器
docker run -d \
--name zentao \
-p 8888:80 \
-v /root/docker/zentao/zentaopms:/www/zentaopms \
-v /root/docker/zentao/mysql:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 easysoft/zentao:latest

查看日志
docker logs -f zentao

删除容器
docker rm -f zentao

访问地址
http://127.0.0.1:8888
```



### Docker 安装 Tomcat

```
运行容器
docker run -d \
--name tomcat \
-p 8888:8080 \
tomcat:latest

进入容器
docker exec -it tomcat /bin/bash

访问地址
http://127.0.0.1:8888/

踩坑
访问问不到主页的原因是因为存放主页的文件夹 webapps 是空的, docker 的 tomcat 将这些文件放在了 webapps.dist 文件夹中,只需要将空的 webapps 文件夹删除,然后将 webapps.dist 重命名为 webapps 就可以了
```



### Docker 安装 Sonar

[sonarqube](https://hub.docker.com/_/sonarqube)

```
运行容器
docker run -d \
--name sonarqube \ 
-p 9100:9000 \
sonarqube:8.9.2-community

访问地址 默认账号密码：admin/admin，更新账号密码为 admin/root
http://127.0.0.1:9100/
```



### Docker 安装 JIRA

```
运行容器
docker run  --name=jira -d \
-v jiraVolume:/var/atlassian/application-data/jira \
-p 8084:8080 \
atlassian/jira-software

访问地址
http://127.0.0.1:8084
```

[获取许可证](https://my.atlassian.com/product)  



### Docker 安装 Nginx

```
docker run -d -p 9999:80 --name=nginx -v /root/nginx-logs:/var/log/nginx nginx:latest
```

踩坑：  
安装自带 Nginx 的容器，访问页面总是404，尝试做删除所有镜像和所有容器还是不成功，最后重装系统再重新运行容器才成功。
