[TOC]

<h1 align="center">Dubbo</h1>

> By：weimenghua  
> Date：2022.03.28  
> Description：Dubbo 高性能、轻量级的开源 Java RPC 框架

**参考资料**  
[Dubbo 官网](http://dubbo.apache.org/zh-cn/index.html)   
[Dubbo 中文文档](http://dubbo.apache.org/zh-cn/index.html)



## 1. Dubbo 简介

### 1.1 Dubbo 简介

Dubbo 是一款高性能、轻量级的开源 Java RPC 框架，它提供了三大核心能力：  
1、面向接口的远程方法调用  
2、智能容错和负载均衡  
3、以及服务自动注册和发现

### 1.2 RPC 远程过程调用

Dubbo 原理：A 系统调用 B 系统接口服务， 实现动态化(zookeeper 通知)、权限化、配置化、低耦合化、自动化。
RPC 的英文全称是 Remote Procedure Call，翻译为中文叫“远程过程调用”。其中稍显晦涩的其实就是“过程”，过程其实就是方法。所以，可以把 RPC 理解为“远程方法调用”。

### 1.3 Dubbo 节点角色说明

Provider: 暴露服务的服务提供方  
Consumer: 调用远程服务的服务消费方  
Registry: 服务注册与发现的注册中心  
Monitor: 统计服务的调用次调和调用时间的监控中心  
Container: 服务运行容器

注册中心（Registry）：服务目录框架，用于服务的注册和服务时间发布和订阅。Dubbo 中缺省采用 appache 的 zookeeper 作为注册中心。  
提供方（Provider）：暴露服务方称之为“服务提供方”  
消费方（Consumer）：调用远程服务方称之为“服务消费者”  
监控中心（Monitor）：统计服务的调用次数和调用时间的日志服务称之为“服务监控中心”  
服务分组：服务分组是 dubbo 用来区分相同接口名,但是方法具体实现不同的一种模式

调用关系说明：  
1、服务容器负责启动，加载，运行服务提供者。  
2、服务提供者在启动时，向注册中心注册自己提供的服务。  
3、服务消费者在启动时，向注册中心订阅自己所需的服务并提供自己的地址。  
4、注册中心返回服务提供者地址列表给消费者，如果有变更，注册中心将给予长连接推送变更数据给消费者。  
5、服务消费者从提供者列表中，基于软负载均衡算法，选一台提供者进行调用，如果调用失败，再选另一台调用。  
6、服务提供者和消费者，在内存中累计调用次数和调用时间，定时每分钟发送一次统计数据到监控中心。

Container 容器，就是 spring 的子容器，依赖 spring，启动后将服务注册到注册中心。  
Provider，服务提供者，暴露服务的服务提供方。  
Consumer，服务消费者，调用远程服务的服务消费方。  
Registry， 注册中心，我们公司现在用的注册中心是 zookper，服务发布的时候将服务地址和有些方法告诉注册中心，注册中心保存这些地址，服务者去消费的时候从注册中心去获取服务，注册中心返回给消费者的时候与消费者建立长连接，消费者建立一个临时文件保存注册中心返回的地址等信息，临时文件可以减少对注册中心的访问，减少服务压力提高效率等，只有当服务者发送异常注册中心通知消费者的时候临时文件才会改变。  
Monitor，服务监控中心，记录服务调用的次数和调用时间，负载均衡。统计现在内存汇总后每分钟一次发送到监控中心服务器，并以报表展示。另外，Monitor 可以不安装，即使挂掉了也不会影响到 consumer 和 Provider 之间的调用，只是丢失部分采样数据。  
Container 不用安装，spring 容器 spring 封装好的；Provider、Consumer 相对于两个系统，通过编程写代码实现；注册中心和 Monitor 需要安装。

### 1.4 Dubbo 的配置

```
1、暴露服务，定义服务信息  
服务配置，用于暴露一个服务，定义服务的元信息，一个服务可以用多个协议暴露，一个服务也可以注册到多个注册中心。  
<!-- 服务端：dubbo:service -->                
<dubbo:service ref="lonApplicationService" interface="com.demo.service.LonApplicationService" group="${dubbo.protocol.group}" version="${dubbo.protocol.version}"timeout="${dubbo.protocol.timeout}"  protocol="dubbo" retries="0"/>

2、引用服务配置  
用于创建一个远程服务代理。  
<!-- 消费端：dubbo:reference -->
<dubbo:reference id="lonApplicationService" interface="com.demo.service.LonApplicationService" group="${dubbo.protocol.group}" version="${dubbo.protocol.version}" timeout="${dubbo.protocol.timeout}" registry="registry" check="false"/> 
```

流程：服务端提供接口供客户端调用。理论上是服务端提供的接口外人是不知道的，也不知道项目的真实架构流程。  
注意：服务端客户端的区分

### 1.5 什么是分布式

分布式或者说 SOA 分布式重要的就是面向服务，说简单的分布式就是我们把整个系统拆分成不同的服务然后将这些服务放在不同的服务器上减轻单体服务的压力提高并发量和性能。比如电商系统可以简单地拆分成订单系统、商品系统、登录系统等等，拆分之后的每个服务可以部署在不同的机器上，如果某一个服务的访问量比较大的话也可以将这个服务同时部署在多台机器上。



## 2. dubbo\-telnet

### 2.1 连接 dubbo 服务

telnet \[ip] [端口]
举例：telnet 127.0.0.1 66666  
回车后如果显示 ：Escape character is '^]'.  
代表连接成功，正在监听 dubbo 服务。

### 2.2 查看 dubbo 服务

使用 ls 命令，查看查看该 ip 端口下的所有服务名称  
查看该 ip 端口下所有接口：ls  
查看该 ip 端口下所有接口的详细信息：ls -l  
查看某个接口下的方法：ls [接口名]  
查看某个接口下的方法的详细信息：ls -l [接口名]  
举例：ls -l com.dubbo.demo.UserService

### 2.3 invoke 调用接口方法

invoke [完整包名].[接口名].方法名  
举例：invoke com.dubbo.demo.UserService.findUserById(1L)  
如果对象里面还有对象，可能会报转换对象出错，dubbo 默认会序列化为 JSONObject 对象，里面也指定 class 即可，如：invoke ls -l com.dubbo.demo.UserService.queryMethodDemo({"class":"com.demo.demoRequest","custNo":"123456","type":1})

### 2.4 count 统计服务调用情况

统计1次服务任意方法的调用情况：count XxxService  
统计10次服务任意方法的调用情况：count XxxService 10  
统计1次服务方法的调用情况：count XxxService xxxMethod  
统计10次服务方法的调用情况：count XxxService xxxMethod 10

### 2.5 trace 跟踪方法

跟踪 1 次服务任意方法的调用情况：trace XxxService    
跟踪 10 次服务任意方法的调用情况：trace XxxService 10  
跟踪 1 次服务方法的调用情况：trace XxxService xxxMethod     
跟踪 10 次服务方法的调用情况：trace XxxService xxxMethod 10

### 2.6 status 显示汇总状态

该状态将汇总所有资源的状态，当全部 OK 时则显示 OK，只要有一个 ERROR 则显示 ERROR，只要有一个 WARN 则显示 WARN：status -l
