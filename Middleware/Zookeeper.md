[TOC]

<h1 align="center">Zookeeper</h1>

> By：weimenghua  
> Date：2022.11.20  
> Description：Zookeeper 注册中心 

 

## 1. 环境搭建

**1、下载并解压 zookeeper**  
1.1、下载 zookeeper

```
wget http://apache.fayea.com/zookeeper/zookeeper-3.5.6/apache-zookeeper-3.5.6.tar.gz  
wget http://mirror.bit.edu.cn/apache/zookeeper/zookeeper-3.5.6/apache-zookeeper-3.5.6.tar.gz
```

1.2、解压 tar 包到/usr/local/zookeeper/
tar -zxvf zookeeper-3.5.6.tar.gz  -C /usr/local/zookeeper/

**2、配置 zoo.cfg**
2.1、进入 conf 目录，复制 zoo_sample.cfg 并命名为 zoo.cfg
cd /usr/local/zookeeper/zookeeper-3.5.6/conf/ && cp zoo_sample.cfg zoo.cfg

2.2、创建 dataDir 和 logDir

```
mkdir /usr/local/zookeeper/dataDir   
mkdir /usr/local/zookeeper/logDir
```

2.3、添加 dataDir 和 logDir 配置
vim zoo.cfg，添加如下配置：  
内存数据快照的保存目录  
dataDir=/usr/local/zookeeper/dataDir  
日志目录  
dataLogDir=/usr/local/zookeeper/logDir

2.4、配置集群
vim zoo.cfg，添加如下配置：  

```
server.1=127.0.0.1:2888:3888  
server.2=127.0.0.2:2888:3888  
server.3=127.0.0.3:2888:3888  
```

在的 dataDir 路径下新增 myid 文件：  
cd /usr/local/zookeeper/dataDir && touch myid  
vim myid，在对应的 IP 的机器上输入对应的编号，如在127.0.0.1上，“myid”文件内容就是1，在127.0.0.2上，内容就是2

2.5、连接数设置
maxClientCnxns=60   #注意：设置最大连接数为1024,如果服务大于连接数则会导致部分服务连不上 zk        

**3、配置环境变量（可选）**
vim /etc/profile，添加如下配置： 
export ZOOKEEPER=/usr/local/zookeeper  
export PATH=$PATH:$ZOOKEEPER/bin  

使用 source 命令立即生效，刷新环境变量：  
source /etc/profile

**4、启动 zookeeper**
因为配置了环境变量，所以在任意目录下都可以运行以下启动命令启动 Zookeeper
zkServer.sh start  
zkServer.sh status  

也可以进入 bin 目录启动 zookeeper  
cd /usr/local/zookeeper/bin  
./zkServer.sh start    //启动  
./zkServer.sh stop     //停止  
./zkServer.sh restart  //重启  
./zkServer.sh status   //查看状态（查看是 leader，follower，standalone）  
如果是连接多个不同的主机节点，可以使用如下命令：  
./zkCli.sh -server 127.0.0.1:2888

**5、启动 zookeeper 客户端**
./zkCli.sh   //启动客户端  
ls /             //查看 zookeeper 节点



## 2. 常用命令

**2.1、连接 zookeeper 服务**
连接本机 zookeeper 服务：`./zkCli.sh`  
连接远程 zookeeper 服务：`./zkCli.sh -server ip:port （./zkCli.sh -server 127.0.0.1:2181）`

**2.2、zookeeper 常用命令**
列出 zookeeper 根节点：`ls /`  
列出 zookeeper dubbo 节点：`ls /dubbo`  
获取节点信息：`get /dubbo`  
查看某个接口服务：`ls /dubbo/com.demo.service.DemoService`  
查看节点状态：`stat /dubbo`  
创建节点：`create /tmp 123` （注：节点后面得有值，如：123，节点值就是123，可设置""）  
退出 zkCli：`quit`

**znode 的状态信息**
每个 znode 的状态信息包含以下内容：  

- czxid，创建（create）该 znode 的 zxid  
- mzxid，最后一次修改（modify）该 znode 的 zxid  
- pzxid，最后一次修改该 znode 子节点的 zxid  
- ctime，创建该 znode 的时间  
- mtime，最后一次修改该 znode 的时间  
- dataVersion，该节点内容的版本，每次修改内容，版本都会增加  
- cversion，该节点子节点的版本  
- aclVersion，该节点的 ACL 版本  
- ephemeralOwner，如果该节点是临时节点（ephemeral node），会列出该节点所在客户端的 session id；如果不是临时节点，该值为 0
- dataLength，该节点存储的数据长度  
- numChildren，该节点子节点的个数  



## 3. 调用过程

注册中心的调用过程
1. 服务提供者启动时，会将自己的服务信息(服务名称/IP 地址/端口号等)写入注册中心。
2. 当注册中心接收提供者数据时，会动态的维护服务列表数据。
3. 当消费者启动时，首先会链接注册中心，获取服务列表数据。
4. 当注册中心接收到消费者的请求之后，先将消费者的信息进行记录，将服务列表信息发给消费者。
5. 当消费者接收注册中心发来的数据之后，将数据保存到消费者本地，至此消费者启动完成，等待用户的调用。
6. 当消费者接收调用时，则根据服务列表数据找到可以提供服务的提供者，之后利用负载均衡算法，挑选其中一个进行访问。
7. 注册中都有心跳检测机制，当服务器发生宕机现象时，注册中心会动态的维护服务列表数据，同时全网广播，通知所有的消费者更新服务列表数据，保证服务数据的一致性。