[[TOC]

<h1 align="center">SkyWalking</h1>

> By：weimenghua  
> Date：2023.05.31  
> Description：SkyWalking 链路追踪

**参考资料**  
[skywalking 官网](https://skywalking.apache.org/)  
[skywalking-oap-server](https://hub.docker.com/r/apache/skywalking-oap-server)   
[skywalking-ui](https://hub.docker.com/r/apache/skywalking-ui)  
[skywalking-quick-start](https://skywalking.apache.org/zh/2020-04-19-skywalking-quick-start/)

## 1. SkyWalking 简介

SkyWalking: 一个开源的可观测平台, 用于从服务和云原生基础设施收集, 分析, 聚合及可视化数据。SkyWalking 提供了一种简便的方式来清晰地观测分布式系统, 甚至横跨多个云平台。SkyWalking 更是一个现代化的应用程序性能监控(Application Performance Monitoring)系统, 尤其专为云原生、基于容器的分布式系统设计.

![](../img/SkyWalking架构.png)

## 2. SkyWalking 搭建

[SkyWalking 下载](https://archive.apache.org/dist/skywalking/)

安装 Elasticsearch

```bash
docker run -d --name elasticsearch \
-p 9200:9200 \
-e "discovery.type=single-node" \
elasticsearch:7.6.2
```

安装 skywalking-oap-server

```bash
docker run -d --name oap \
--restart always \
-p 12800:12800 \
-p 11800:11800 \
--link elasticsearch:elasticsearch \
-e SW_STORAGE=elasticsearch \
-e SW_STORAGE_ES_CLUSTER_NODES=elasticsearch:9200 \
apache/skywalking-oap-server:6.6.0-es7

8.7.0-es7
6.6.0-es7
```

安装 skywalking-ui

```bash
docker run -d --name oap-ui \
--restart=always \
-e TZ=Asia/Shanghai \
-p 8088:8080 \
--link oap:oap \
-e SW_OAP_ADDRESS=oap:12800 \
apache/skywalking-ui:6.6.0

8.3.0
6.6.0
```

访问地址：http://127.0.0.1:8088

## 3. SkyWalking 使用

![](../img/SkyWalking-UI.png)

启动应用

```text
# 下载 skywalking-agent
https://archive.apache.org/dist/skywalking/6.6.0/apache-skywalking-apm-es7-6.6.0.tar.gz

# Mac 未实践成功
java -javaagent:/Users/menghuawei/Downloads/apache-skywalking-apm-bin-es7/agent/skywalking-agent.jar \
-Dskywalking.agent.service_name=demo-application \
-Dskywalking.collector.backend_service=127.0.0.1:11800 \
-jar lab-39-demo-2.2.2.RELEASE.jar

# Linux 未实践成功
java -javaagent:/root/apache-skywalking-apm-bin/agent/skywalking-agent.jar \
-Dskywalking.agent.service_name=demo-application \
-Dskywalking.collector.backend_service=127.0.0.1:11800 \
-jar lab-39-demo-2.2.2.RELEASE.jar

java -javaagent:/root/apache-skywalking-apm-bin/agent/skywalking-agent.jar \
    -Dskywalking.agent.service_name=demo-application \
    -Dskywalking.collector.backend_service=127.0.0.1:11800 \
    -jar spring-transaction-2.2.6.RELEASE.jar

    
lab-39-demo-2.2.2.RELEASE.jar    
spring-transaction-2.2.6.RELEASE.jar
    
访问服务
http://127.0.0.1:8079/demo/echo
```
