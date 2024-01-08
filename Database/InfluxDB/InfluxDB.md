[TOC]

---

<h1 align="center">InfluxDB</h1>

> By：weimenghua  
> Date：2023.03.04  
> Descrition：InfluxDB 时序型数据库

**参考资料**  
[Docker 安装 InfluxDB](https://juejin.cn/post/7073447866219364388)




## 一、时序型数据库
时序数据库就是存放事件序列数据的数据库，需要支持时序数据的快速写入、持久化、多维度的聚合查询等基本功能。

### 时间序列数据
时间序列数据是基于时间的一系列数据。在有时间的坐标中将这些数据点连成线，往过去看可以做成多纬度报表，揭示其趋势性、规律性、异常性；往未来看可以做大数据分析，机器学习，实现预测和预警。

### 数据写入
写入平稳、持续、高并发和高吞吐：时序数据的写入是比较平稳的，这点与应用数据不同，应用数据通常与应用的访问量成正比，而应用的访问量通常存在波峰波谷。时序数据的产生通常是以一个固定的时间频率产生，不会受其他因素的制约，其数据生成的速度是相对比较平稳的。
写多读少：时序数据上95%-99%的操作都是写操作，是典型的写多读少的数据。这与其数据特性相关，例如监控数据，你的监控项可能很多，但是你真正去读的可能比较少，通常只会关心几个特定的关键指标或者在特定的场景下才会去读数据。
实时写入、无更新：时序数据的写入是实时的，且每次写入都是最近生成的数据，这与其数据生成的特点相关，因为其数据生成是随着时间推进的，而新生成的数据会实时的进行写入。数据写入无更新，在时间这个维度上，随着时间的推进，每次数据都是新数据，不会存在旧数据的更新，不过不排除人为的对数据做订正。



## 二、InfluxDB 简介
InfluxDB 是用 Go 语言编写的一个开源分布式时序、事件和指标数据库，无需外部依赖
InfluxDB 在 DB-Engines 的时序数据库类别里排名第一

### InfluxDB 相关概念
- Database：InfluxDB 可以创建数据库，一个数据库可以包含多个 user、保存策略、schemaless ，支持随时灵活创建 mersurement
- Measurement：相当于表的概念；
- Tags：是一些 kv 的结构，标签会被用来建立索引；
- Fields：是保存真实数据的结构，也是 kv 结构，但是不会被用来建立索引；
- Point： 代表了一条记录，可以理解为关系型数据库中的一条记录；
- Timestamp：既然 InfluxDB 被称之为时序数据库，少了时间是不可能的，每条记录必须要有一个时间戳；
- Series：是由 Measurement+Tags 组成的



## 三、查询语句
```
查看数据库
http://127.0.0.1:8086/query?q=SHOW+DATABASES

查看数据表
http://127.0.0.1:8086/query?q=SHOW+MEASUREMENTS&db=jmeter

查看表数据
http://127.0.0.1:8086/query?q=select+*+from+jmeter&db=jmeter
```