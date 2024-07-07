[TOC]

<h1 align="center">MQTT</h1>

> By：weimenghua  
> Date：2023.07.18  
> Description：MQTT 协议



**参考资料**  
[EMQX 官网](https://www.emqx.io/zh/)  



### 1. MQTT 协议

MQTT 是一种基于发布/ 订阅模式的轻量级消息传输协议（Message Queuing Telemetry Transport，消息队列遥测传输协议），专门针对低带宽和不稳定网络环境的物联网应用而设计，可以用极少的代码为联网设备提供实时可靠的消息服务。 MQTT 协议广泛应用于物联网、移动互联网、智能硬件、车联网、智慧城市、远程医疗、电力、石油与能源等领域。



### 2. MQTT 消息服务器

#### 2.1 EMQX 简介

EMQX 是一款开源 (opens new window)的大规模分布式 MQTT 消息服务器，功能丰富，专为物联网和实时通信应用而设计。EMQX 5.0 单集群支持 MQTT 并发连接数高达 1 亿条，单服务器的传输与处理吞吐量可达每秒百万级 MQTT 消息，并保证延迟在亚毫秒级。

EMQX 支持多种协议，包括 MQTT (3.1、3.1.1 和 5.0)、HTTP、QUIC 和 WebSocket 等，保证各种网络环境和硬件设备的可访问性。EMQX 还提供了全面的 SSL/TLS 功能支持，比如双向认证以及多种身份验证机制，为物联网设备和应用程序提供可靠和高效的通信基础设施。


#### 2.2 EMQX 搭建

[Docker 搭建 emqx](https://www.emqx.io/zh/downloads)

- 1883：MQTT 协议端口
- 8084：MQTT/SSL 端口
- 8083：MQTT/WebSocket 端口
- 8080：HTTP API 端口
- 18083：Dashboard 管理控制台端口

运行容器
```
docker run -d --name emqx -p 1883:1883 -p 8083:8083 -p 8084:8084 -p 8883:8883 -p 18083:18083 emqx/emqx:5.1.1
```

访问 Dashboard，默认账号密码：admin/public，修改后的密码：admin@123  
`http://127.0.0.1:18083`



### 3. JMeter 测试 MQTT

下载 [JMeter MQTT 插件](https://github.com/emqx/mqtt-jmeter/releases) 放到 `$JMETER_HOME/lib/ext` 目录下并重启 JMeter。

新建 MQTT Connect（MQTT 连接采样器）、MQTT Pub Sampler（MQTT 消息发布采样器）、MQTT Sub Sampler 请求，配置线程数 10 个，运行线程。


查看 EMQX 集群概览

![](./img/EMQX%20集群概览.png)


在 MQTT 连接采样器后添加 MQTT Pub Sampler，用于发布消息
- QoS Level 为消息级别，支持0、1、2，分别代表 MQTT 协议规范里的至多一次（AT_MOST_ONCE），至少一次（AT_LEAST_ONCE），精确一次（EXACTLY_ONCE）
- Retained Mesages 为是否保留消息，支持 true、false
- Topic name 为主题名称
- Add timestamp in payload 在报文中加入时间戳
- Message type : String 可填写自定义字符串报文
- Message type : Hex string 可填写自定义十六进制报文
- Message type : Randmom string with fixed length 为固定长度随机字符，后面 Length 为指定长度


在 MQTT Connect 后添加 MQTT Sub Sampler，模拟订阅消息
- Qos Level 消息级别，支持0、1、2
- Topic name(s) 订阅主题名称，支持+/#通配符共享订阅
- Payload includes timestamp 报文是否包含时间戳
- Sample on : specified elapsed time(ms) 按毫秒时间统计订阅到消息
- Sample on : number of received messages 按次数统计订阅到消息
- Debug response 调试返回信息，即在察看结果树中显示详细订阅报文