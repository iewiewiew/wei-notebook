[TOC]

<h1 align="center">Zipkin</h1>

> By：weimenghua  
> Date：2023.03.22  
> Description：Zipkin 监控工具

**参考资料**  
[Zpkin 官网](https://zipkin.io/)

## 1. Zipkin 简介

Zipkin 主要由4个部分组成，  
收集器：Collector  
存储器：Storage，默认是内存存储，我们可以改成数据库如 Mysql 等  
查询：提供 RESTful 的api 提供查询  
Web 界面：单独的 UI 组件

## 2. Zipkin 搭建

```text
方式一
docker run -d -p 9411:9411 openzipkin/zipkin

方式二
curl -sSL https://zipkin.io/quickstart.sh | bash -s
java -jar zipkin.jar

访问 http://localhost:9411/zipkin/
```
