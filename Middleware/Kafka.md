[TOC]

<h1 align="center">Kafka</h1>

> By：weimenghua  
> Date：2022.03.30  
> Description：Kafka 消息队列

**参考资料**  
[Kafka 官网](https://kafka.apache.org/)  
[Kafka 教程](https://dunwu.github.io/bigdata-tutorial/kafka/)



## 1. 环境搭建

1. 下载及解压 kafka  

[Kafka 下载地址](https://kafka.apache.org/downloads)

```
wget https://downloads.apache.org/kafka/3.8.1/kafka_2.13-3.8.1.tgz

tar -xzvf kafka_2.12-2.4.0.tgz  
```

2. 配置 kafka

kafka 的配置文件在 config/server.properties 文件中  
broker.id 是 kafka broker 的编号，集群里每个 broker 的 id 需不同：  
broker.id=0

listeners 是监听地址，需要提供外网服务的话，要设置本地的 IP 地址：
listeners=PLAINTEXT://localhost:9092

kafka 运行日志存放的路径：  
log.dirs=/tmp/kafka_2.10-0.8.2.2/logs

zookeeper 配置：  
zookeeper.connect=127.0.0.1:2181,127.0.0.2:2181,127.0.0.3:2181

注意修改 server.properties 文件：  
listeners=PLAINTEXT://localhost:9092  
advertised.listeners=PLAINTEXT://localhost:9092

3. 启动及停止 kafka

3.1 启动 kafka
``` 
启动 ZooKeeper
bin/zookeeper-server-start.sh config/zookeeper.properties

启动 Kafka Broker
bin/kafka-server-start.sh -daemon config/server.properties 
```  
-daemon 参数会将任务转入后台运行，输出日志信息将写入日志文件，日志文件在执行命令的目录下的 logs 目录中 kafkaServer.out，结尾输同 started 说明启动成功。
也可以用 jps 命令，看有没有 kafka 的进程

3.2 停止 kafka
``` 
bin/kafka-server-stop.sh config/server.properties 
```

查看 Kafka 进程
ps aux | grep kafka

测试端口是否通
telnet localhost 9092

## 2. Kafka Topic

注意  
在2.5.0版本之前只支持 --broker-list；在2.5.0版本之后支持 --bootstrap-server，如果版本老于2.2，应该用--zookeeper；可使用127.0.0.1  

```
创建 topic  
bin/kafka-topics.sh --create --topic test-topic --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
bin/kafka-topics.sh --create --zookeeper 127.0.0.1:2181 --replication-factor 3 --partitions 3 --topic test-topic 

查看 topic 列表  
bin/kafka-topics.sh --list --bootstrap-server localhost:9092
bin/kafka-topics.sh --list --zookeeper 127.0.0.1:2181  

查看特定主题的详细信息  
bin/kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic test-topic 
bin/kafka-topics.sh --zookeeper 127.0.0.1:2181 --describe --topic test-topic  

发送消息  
bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic test-topic

接收消息  
bin/kafka-console-consumer.sh --broker-list localhost:9092 --topic test-topic --from-beginning  
bin/kafka-console-consumer.sh --zookeeper 127.0.0.1:2181 --topic test-topic --from-beginning

删除 topic  
bin/kafka-topics.sh --broker-list localhost:9092 --delete --topic test-topic
bin/kafka-topics.sh --zookeeper 127.0.0.1:2181 --delete --topic test-topic
```

K8s Kafka

```
进入 pod
kubectl --insecure-skip-tls-verify exec -it -n <namespace> kafka-0 -- /bin/bash

获取 ClusterIP
kubectl --insecure-skip-tls-verify get services -n <namespace> |grep kafka

查看配置
find / -name server.properties
cat /opt/kafka/config/server.properties

Kafka 的命令行工具，查看 topics
/opt/kafka/bin/kafka-topics.sh --bootstrap-server <ClusterIP>:9092 --list
kubectl --insecure-skip-tls-verify exec -it kafka-0 -n <namespace> -- /opt/kafka/bin/kafka-topics.sh --bootstrap-server <ClusterIP>:9092 --list

查看某个 topic 信息
/opt/kafka/bin/kafka-topics.sh --bootstrap-server <ClusterIP>:9092 --describe --topic <topic_name>

查看某个 topic 内容
/opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server <ClusterIP>:9092 --topic <topic_name> --from-beginning

创建 topic
kubectl --insecure-skip-tls-verify exec -it kafka-0 -- /opt/kafka/bin/kafka-topics.sh --bootstrap-server <ClusterIP>:9092 --topic my-topic --create --partitions 3 --replication-factor 3

发送消息，在终端中逐行输入要发送的消息，每条消息按 Enter 键发送
kubectl --insecure-skip-tls-verify exec -it kafka-0 -n <namespace> -- /opt/kafka/bin/kafka-console-producer.sh --broker-list <ClusterIP>:9092 --topic my-topic
```
