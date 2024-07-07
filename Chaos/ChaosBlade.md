[TOC]

<h1 align="center">ChaosBlade</h1>

> By：weimenghua  
> Date：2022.11.20  
> Description：Chaosblade 混沌工程实验工具

**参考资料**  
[ChaosBlade 官网](https://chaosblade.io/)  
[ChaosBlade 文档](https://chaosblade-io.gitbook.io/chaosblade-help-zh-cn/)    
[ChaosBlade 源码](https://github.com/chaosblade-io)  
[awesome-chaosblade](https://github.com/chaosblade-io/awesome-chaosblade)  
[awesome-chaos-engineering](https://github.com/dastergon/awesome-chaos-engineering)  



## 1. ChaosBlade 入门

### 1.1 ChaosBlade 简介

ChaosBlade 是阿里巴巴 2019 年开源的混沌工程项目，包含混沌工程实验工具 chaosblade 和混沌工程平台 chaosblade-box，旨在通过混沌工程帮助企业解决云原生过程中高可用问题。

### 1.2 ChaosBlade 架构

ChaosBlade 支持多种环境部署与演练，包括 linux、docker、kubernetes 集群及各类云厂商环境。ChaosBlade 主要包括以下几个组件：

- ChaosBlade-Box Console：ChaosBlade 可视化组件，主要提供一套用户友好的 Web 界面，用户可以通过该界面进行混沌工程实验的编排与操作管理。
- ChaosBlade-Box Server：核心逻辑组件，主要负责混沌工程实验的管理与编排，探针与应用管理。包括组件，Chaos Engine：演练引擎，包括流程编排、安全管控、演练报告等功能；Chaos Runner：演练执行器，兼容多种执行工具；Chaos Experinece：演练经验库等。
- Agent：核心逻辑组件，部署在用户终端的主机或 Kubernetes 集群内，主要负责和 ChaosBlade-Box Server 建联上报心跳并作为命令下发通道。
- ChaosBlade：主要执行工具，能在主机和 Kubernetes 等不同环境上执行故障注入，能对系统网络设备、文件系统、内核及系统上运行的应用等进行故障干扰。

![chaosblade 架构](img/chaosblade-architect.png)



## 2. ChaosBlade 搭建

### 2.1 ChaosBlade 搭建

[ChaosBlade 下载地址](https://github.com/chaosblade-io/chaosblade/releases)

```
1、下载
方式一
wget https://github.com/chaosblade-io/chaosblade/releases/download/v1.7.1/chaosblade-1.7.1-linux-amd64.tar.gz
方式二
wget https://chaosblade.oss-cn-hangzhou.aliyuncs.com/agent/github/1.7.1/chaosblade-1.7.1-linux-amd64.tar.gz

2、解压
tar -zxvf chaosblade-1.7.1-linux-amd64.tar.gz && cd chaosblade-1.7.1/

3、设置
ln -s `pwd`/blade /usr/local/bin/blade

4、验证
blade v

5、帮助
blade help
blade create help
blade create cpu help

6、卸载
rm -rf chaosblade-*

7、设置 blade 别名 b
cat >> ~/.bashrc << EOF
alias b='blade'
EOF
source ~/.bashrc
cat ~/.bashrc
```

### 2.2 ChaosBlade Operator 搭建

[ChaosBlade Operator 下载地址](https://github.com/chaosblade-io/chaosblade-operator/releases)

```
1、下载
wget https://github.com/chaosblade-io/chaosblade-operator/releases/download/v1.7.1/chaosblade-operator-1.7.1.tgz

2、安装
helm install chaosblade-operator chaosblade-operator-1.7.1.tgz --namespace chaosblade --create-namespace

注：未实践
helm install chaosblade-operator chaosblade-operator-1.7.1.tgz --namespace chaosblade --set blade.repository=chaosbladeio/chaosblade-tool,operator.repository=chaosbladeio/chaosblade-operator 

3、验证（有几个 node 就有几个 tool）
kubectl get pod -n chaosblade

4、卸载
helm uninstall chaosblade-operator -n chaosblade

删除 crd 资源
kubectl delete crd chaosblades.chaosblade.io

如果 crd 资源删除长时间没有成功，可通过以下命令进行删除：
blades=$(kubectl get blade | grep -v NAME | awk '{print $1}' | tr '\n' ' ') && kubectl patch blade $blades --type merge -p '{"metadata":{"finalizers":[]}}'

停止全部实验，删除所有创建的资源
helm del --purge chaosblade-operator
```

### 2.3 ChaosBlade Box 搭建

[ChaosBlade Box 下载地址](https://github.com/chaosblade-io/chaosblade-box)

```
1、下载 chaosblade-box
wget https://github.com/chaosblade-io/chaosblade-box/releases/download/v1.0.3/chaosblade-box-1.0.3.tgz

2、安装 chaosblade-box
helm install chaosblade-box chaosblade-box-1.0.3.tgz --namespace chaosblade \
--set spring.datasource.password=DATASOURCE_PASSWORD

3、查看 pod
kubectl get pod -n chaosblade
查看 pod 详细信息
kubectl describe pod `kubectl get pod -n chaosblade |grep chaosblade-box |awk -F " " 'NR==1{print $1}'` -n chaosblade

4、查看 svc
kubectl get svc -n chaosblade

5、查看日志
kubectl logs -f `kubectl get pod -n chaosblade |grep chaosblade-box |awk -F " " 'NR==1{print $1}'` -n chaosblade

6、验证
执行 kubectl get svc -n chaosblade 拿到端口号
访问 http://127.0.0.1:32179/
注册一个账号，设置账号密码：root/root

7、卸载 chaosblade-box
helm uninstall chaosblade-box -n chaosblade
```

**ChaosBlade Box 页面**

![chaosblade](img/chaosblade.png)

**安装探针**

```
1、Helm chart 包下载
wget https://chaosblade.oss-cn-hangzhou.aliyuncs.com/platform/release/1.0.2/chaosblade-box-agent-1.0.2.tgz -O chaos.tgz

2、Helm v3 安装探针（查看 helm 版本：helm version）
命令：helm install agent chaos.tgz --namespace chaosblade --set env.name=default,license=aa0ec9b38ac0411593883bc643458d74,images.chaos.repository=chaosbladeio/chaosblade-agent,images.chaos.version=1.0.2,transport.endpoint={替换为 box 的 ip:port},controller.cluster_id={替换为集群 id，取值无特殊要求},controller.cluster_name={替换为集群名字，取值无特殊要求}

查看集群名称：kubectl get node
查看 box 的 ip:port：kubectl get svc -n chaosblade |grep chaosblade-box |grep 7001
查看 cluster_id：kubectl get configmap cluster-info -n kube-public -o json

举例：helm install agent chaos.tgz --namespace chaosblade --set env.name=default,license=aa0ec9b38ac0411593883bc643458d74,images.chaos.repository=chaosbladeio/chaosblade-agent,images.chaos.version=1.0.2,transport.endpoint=10.43.194.110:7001,controller.cluster_id=0a6910e9-4948-49a8-b896-026c84dd02f6,controller.cluster_name=k8s-master

3、卸载 agent
helm uninstall agent -n chaosblade
```



## 3. ChaosBlade 实验
### 3.1 ChaosBlade 场景
![](img/chaosblade-scene.png)
```
ck          Clickhouse experiment 
cplus       C++ chaos experiments
cpu         Cpu experiment
cri         CRI experiment
disk        Disk experiment
docker      Docker experiment
druid       Experiment with the Druid
dubbo       Experiment with the Dubbo
es          ElasticSearch experiment!
feign       feign experiment
file        File experiment
gateway     gateway experiment!
hbase       hbase experiment!
http        http experiment
jedis       jedis experiment
jvm         Experiment with the JVM
k8s         Kubernetes experiment
kafka       kafka experiment
lettuce     redis client lettuce experiment
log         log experiment
mem         Mem experiment
mongodb     MongoDB experiment
mysql       mysql experiment
network     Network experiment
process     Process experiment
psql        Postgrelsql experiment
rabbitmq    rabbitmq experiment
redisson    redisson experiment
rocketmq    Rocketmq experiment,can make message send or pull delay and exception
script      Script chaos experiment
servlet     java servlet experiment
strace      strace experiment
systemd     Systemd experiment
tars        tars experiment
time        Time experiment
zk          zk experiment
```



### 3.2 ChaosBlade 基础
**参考资料**  
[ChaosBlade 官网](https://chaosblade.io/)  
[ChaosBlade 文档](https://chaosblade-io.gitbook.io/chaosblade-help-zh-cn/)   

#### blade demo

```
1、下载镜像
docker pull chaosbladeio/chaosblade-demo

2、运行 demo 容器
官方命令：docker run -it --privileged chaosbladeio/chaosblade-demo
指定名称：docker run -it --privileged chaosbladeio/chaosblade-demo --name=chaosblade-demo

3、查看进程
docker ps |grep chaosblade-demo

4、进入容器
docker exec -it chaosblade-demo bash

5、进入镜像之后，可阅读 README.md 文件实施混沌实验，Enjoy it

6、删除容器
docker rm -f chaosblade-demo
```

#### blade base

```
1、blade check 
该命令主要用于 Linux 主机上演练实验时，对主机环境进行校验，判断其是否满足 chaosblade 实验环境
命令：blade check [command]
举例：blade check os / blade check java

2、blade create
创建实验
命令：blade create [command]
举例：blade create cpu load --cpu-percent 60

3、blade destroy
销毁实验
通过 UID 销毁 create 的实验
命令：blade destroy [command]
举例：blade destroy 64b361b56904546b

通过 command 销毁 create 的实验
命令：blade destroy <command>
举例：blade destroy cpu fullload --cpu-count 1

4、blade prepare
应用层场景在 create 注入之前，将应用层 agent 挂载到目标进程中，目前只有 Java 和C++应用层场景需要。
命令：blade prepare [command]
举例：prepare jvm --process tomcat

5、blade query
查看实验
命令：blade query [command]
举例：blade query 64b361b56904546b

命令：blade query k8s create <UID>
举例：blade query k8s create 64b361b56904546b

6、blade revoke
撤销实验
命令：blade revoke <UID>
举例：blade revoke 64b361b56904546b

7、blade status
查看实验信息
命令：blade status <UID>
举例：blade status 64b361b56904546b

查看某类型实验信息
blade status --type create
blade status --type destroy
blade status --type prepare

8、blade version
查看 blade 版本信息

其它
查看所有实验 id（带双引号）
blade status --type create |jq '.result[].Uid'
查看所有实验 id（不带双引号）
blade status --type create |jq -r '.result[].Uid'
```

#### blade server

```
介绍
在 server 模式下，blade 程序会对外暴露 web 服务，上层可通过 http 请求调用，请求格式是 chaosblade?cmd=具体命令，例如执行 CPU 满载，则请求是 chaosblade?cmd=create%20cpu%20fullload

启动 server 模式，服务端口是 8080
blade server start --port 8080

停止 blade server
blade server stop

触发实验场景
http://127.0.0.1:8080/chaosblade?cmd=create cpu load --cpu-percent 80 --timeout 60
curl "http://127.0.0.1:8080/chaosblade?cmd=create%20cpu%20load%20--cpu-percent%2080%20--timeout%2060"

销毁实验场景
http://127.0.0.1:8080/chaosblade?cmd=destroy e866e0cd3706ca72
curl "http://127.0.0.1:8080/chaosblade?cmd=destroy%20e866e0cd3706ca72"
```

### 3.2 ChaosBlade 实验

#### blade create cpu load

```
介绍
CPU 相关的混沌实验包含 CPU 满载，可以指定核数、具体核满载或者总 CPU 负载百分比。
旨在 CPU 在特定负载下，验证服务质量、监控告警、流量调度、弹性伸缩等能力。
load、fullload、fl 命令都可以，即 blade create cpu load、blade create cpu fullload 或 blade create cpu fl

执行命令：
blade create cpu load [flags]

参数
--timeout string       设定运行时长，单位是秒，通用参数
--cpu-count string     指定 CPU 满载的个数
--cpu-list string      指定 CPU 满载的具体核，核索引从 0 开始 (0-3 or 1,3)
--cpu-percent string   指定 CPU 负载百分比，取值在 0-100

案例
# 创建 CPU 满载实验
blade create cpu load

# 指定随机两个核满载
blade create cpu load --cpu-count 2

# 指定索引是 0，3 的核满载，核的索引从 0 开始
blade create cpu load --cpu-list 0,3

# 指定索引 1 到 3 的核满载
blade create cpu load --cpu-list 1-3

# 指定百分比负载
blade create cpu load --cpu-percent 60

实践
blade create cpu load --cpu-percent 60 --timeout 30 

检查
top
```

#### blade create disk burn
```
介绍
提升磁盘读写 io 负载，可以指定受影响的目录，也可以通过调整读写的块大小提升 io 负载，默认值是 10，单位是 M，块的数量固定为 100，即在默认情况下，写会占用 1000M 的磁盘空间，读会固定占用 600M 的空间，因为读操作会先创建一个 600M 的固定大小文件，预计 3s 之内，在创建时写 io 会升高。
验证磁盘 io 高负载下对系统服务的影响，比如监控告警、服务稳定性等。

参数
--path string      指定提升磁盘 io 的目录，会作用于其所在的磁盘上，默认值是 /
--read             触发提升磁盘读 IO 负载，会创建 600M 的文件用于读，销毁实验会自动删除
--size string      块大小, 单位是 M, 默认值是 10，一般不需要修改，除非想更大的提高 io 负载
--timeout string   设定运行时长，单位是秒，通用参数
--write            触发提升磁盘写 IO 负载，会根据块大小的值来写入一个文件，比如块大小是 10，则固定的块的数量是 100，则会创建 1000M 的文件，销毁实验会自动删除

案例
# 主要观察 rkB/s、wkB/s、%util 数据。执行磁盘读 IO 负载高场景
blade create disk burn --read --path /home

# 销毁上述实验后，执行磁盘写 IO 负载高场景
blade create disk burn --write --path /home

# 可同时执行读写 IO 负载场景，不指定 path，默认值是 /
blade create disk burn --read --write

实践
blade create disk burn --read --write --path /home --timeout 60

检查
iostat -x -t 5
```

#### blade create disk fill

```
介绍
模拟磁盘填充，可以指定填充的目录和填充大小。
验证磁盘满下对系统服务的影响，比如监控告警、服务稳定性等。

参数
--path string      需要填充的目录，默认值是 /
--size string      需要填充的文件大小，单位是 M，取值是整数，例如 --size 1024
--reserve string   保留磁盘大小，单位是 MB。取值是不包含单位的正整数，例如 --reserve 1024。如果 size、percent、reserve 参数都存在，优先级是 percent > reserve > size
--percent string   指定磁盘使用率，取值是不带%号的正整数，例如 --percent 80
--retain-handle    是否保留填充
--timeout string   设定运行时长，单位是秒，通用参数

案例
# 执行磁盘填充，填充 40G，即达到磁盘满的效果（可用34G）
blade create disk fill --path /home --size 40000

# 执行按百分比填充磁盘，并且保留填充磁盘的文件句柄
blade c disk fill --path /home --percent 80 --retain-handle

# 查看文件句柄
lsof /home/chaos_filldisk.log.dat

# 执行保留固定大小实验场景
blade c disk fill --path /home --reserve 1024

实践
blade create disk fill --path /home --size 40000 --timeout 60
blade create disk fill --path /home --percent 80 --timeout 60

检查
df -h /home
du -sh * | sort -n
```

#### blade create mem load

```
介绍
指定内存占用，注意，此场景触发内存占用满，即使指定了 --timeout 参数，也可能出现通过 blade 工具无法恢复的情况，可通过重启机器解决！！！推荐指定内存百分比！
由于目前内存大小计算通过 memory.stat 等文件计算，所以和 free 命令计算不一致，同 top 命令一致，验证时请使用 top 命令查看内存使用。后续会针对内存占用场景进行优化。

参数
--mem-percent string    内存使用率，取值是 0 到 100 的整数
--mode string   内存占用模式，有 ram 和 cache 两种，例如 --mode ram。ram 采用代码实现，可控制占用速率，优先推荐此模式；cache 是通过挂载 tmpfs 实现；默认值是 --mode cache
--reserve string    保留内存的大小，单位是 MB，如果 mem-percent 参数存在，则优先使用 mem-percent 参数
--rate string 内存占用速率，单位是 MB/S，仅在 --mode ram 时生效
--timeout string   设定运行时长，单位是秒，通用参数

案例
# 执行内存占用 50%
blade c mem load --mode ram --mem-percent 50

# 保留 200M 内存，总内存大小 1G
blade c mem load --mode ram --reserve 200 --rate 100

实践
blade create mem load --mode ram --mem-percent 80 --timeout 60

检查
free -m / top
```

#### blade create network delay

```
介绍
可以指定网卡、本地端口、远程端口、目标 IP 延迟。需要特别注意，如果不指定端口、ip 参数，而是整个网卡延迟，切记要添加 --timeout 参数或者 --exclude-port 参数，前者是指定运行时间，自动停止销毁实验，后者是指定排除掉的延迟端口，两者都是防止因延迟时间设置太长，造成机器无法连接的情况，如果真实发生此问题，重启机器即可恢复。
本地端口和远程端口之间是或的关系，即这两个端口都会发生延迟，只要指定了本地端口或者远程端口，无需指定需要排除的端口。端口与 IP 之间是与的关系，即指定的 IP:PORT 发生延迟。
网络延迟场景主要验证网络异常的情况下，系统的自我容错能力。

参数
--destination-ip string   目标 IP. 支持通过子网掩码来指定一个网段的 IP 地址, 例如 192.168.1.0/24. 则 192.168.1.0~192.168.1.255 都生效。你也可以指定固定的 IP，如 192.168.1.1 或者 192.168.1.1/32，也可以通过都号分隔多个参数，例如 192.168.1.1,192.168.2.1。
--exclude-port string     排除掉的端口，默认会忽略掉通信的对端端口，目的是保留通信可用。可以指定多个，使用逗号分隔或者连接符表示范围，例如 22,8000 或者 8000-8010。 这个参数不能与 --local-port 或者 --remote-port 参数一起使用
--exclude-ip string       排除受影响的 IP，支持通过子网掩码来指定一个网段的 IP 地址, 例如 192.168.1.0/24. 则 192.168.1.0~192.168.1.255 都生效。你也可以指定固定的 IP，如 192.168.1.1 或者 192.168.1.1/32，也可以通过都号分隔多个参数，例如 192.168.1.1,192.168.2.1。
--interface string        网卡设备，例如 eth0 (必要参数)
--local-port string       本地端口，一般是本机暴露服务的端口。可以指定多个，使用逗号分隔或者连接符表示范围，例如 80,8000-8080
--offset string           延迟时间上下浮动的值, 单位是毫秒
--remote-port string      远程端口，一般是要访问的外部暴露服务的端口。可以指定多个，使用逗号分隔或者连接符表示范围，例如 80,8000-8080
--time string             延迟时间，单位是毫秒 (必要参数)
--force                   强制覆盖已有的 tc 规则，请务必在明确之前的规则可覆盖的情况下使用
--ignore-peer-port        针对添加 --exclude-port 参数，报 ss 命令找不到的情况下使用，忽略排除端口
--timeout string          设定运行时长，单位是秒，通用参数

案例
# 访问本机 8080 和 8081 端口延迟 3 秒，延迟时间上下浮动 1 秒
blade create network delay --time 3000 --offset 1000 --interface eth0 --local-port 8080,8081

# 可以在另一台相同网络内的机器通过 telnet 命令验证，即 telnet xxx.xxx.xxx.xxx 8080
# 销毁实验
blade destroy 9b4aa9fabe073624

# 本机访问外部 14.215.177.39 机器（ping www.baidu.com 获取到的 IP）80 端口延迟 3 秒
blade create network delay --time 3000 --interface eth0 --remote-port 80 --destination-ip 14.215.177.39

# 可在本机通过 telnet 14.215.177.39 80 命令验证
# 对整个网卡 eth0 做 5 秒延迟，排除 22 和 8000到8080 端口
blade create network delay --time 5000 --interface eth0 --exclude-port 22,8000-8080

# 会发现 22 端口和 8000 到 8080 端口不受影响，可在另一台相同网络内的机器通过分别 telnet xxx.xxx.xxx.xxx 8080 和 telnet xxx.xxx.xxx.xxx 8081 进行测试

实践
blade create network delay --time 3000 --offset 1000 --interface eth0 --local-port 3000 --timeout 10

检查
telnet 127.0.0.1 3000
```

#### blade create network dns

```
篡改 dns 域名解析实验场景

介绍
此实验会修改本地的 hosts，篡改域名地址映射。
网络丢包场景主要验证域名解析异常的情况下，系统的自我容错能力。

参数
--domain string    域名 (必要参数)
--ip string        映射的 ip (必要参数)
--timeout string   设定运行时长，单位是秒，通用参数

案例
# www.baidu.com 域名不可访问
blade create network dns --domain www.baidu.com --ip 10.0.0.0

# 使用 ping www.baidu.com 来验证，会发现访问不通。

实践
blade create network dns --domain www.baidu.com --ip 10.0.0.0
```

#### blade create network loss

```
网络丢包实验场景
介绍
可以指定网卡、本地端口、远程端口、目标 IP 丢包。需要特别注意，如果不指定端口、ip 参数，而是整个网卡丢包，切记要添加 --timeout 参数或者 --exclude-port 参数，前者是指定运行时间，自动停止销毁实验，后者是指定排除掉的丢包端口，两者都是防止因丢包率设置太高，造成机器无法连接的情况，如果真实发生此问题，重启机器即可恢复。
本地端口和远程端口之间是或的关系，即这两个端口都会发生丢包，只要指定了本地端口或者远程端口，无需指定需要排除的端口。端口与 IP 之间是与的关系，即指定的 IP:PORT 发生丢包。
网络丢包场景主要验证网络异常的情况下，系统的自我容错能力。

参数
--destination-ip string   目标 IP. 支持通过子网掩码来指定一个网段的 IP 地址, 例如 192.168.1.0/24. 则 192.168.1.0~192.168.1.255 都生效。你也可以指定固定的 IP，如 192.168.1.1 或者 192.168.1.1/32，也可以通过都号分隔多个参数，例如 192.168.1.1,192.168.2.1。
--exclude-port string     排除掉的端口，默认会忽略掉通信的对端端口，目的是保留通信可用。可以指定多个，使用逗号分隔或者连接符表示范围，例如 22,8000 或者 8000-8010。 这个参数不能与 --local-port 或者 --remote-port 参数一起使用
--exclude-ip string       排除受影响的 IP，支持通过子网掩码来指定一个网段的 IP 地址, 例如 192.168.1.0/24. 则 192.168.1.0~192.168.1.255 都生效。你也可以指定固定的 IP，如 192.168.1.1 或者 192.168.1.1/32，也可以通过都号分隔多个参数，例如 192.168.1.1,192.168.2.1。
--interface string        网卡设备，例如 eth0 (必要参数)
--local-port string       本地端口，一般是本机暴露服务的端口。可以指定多个，使用逗号分隔或者连接符表示范围，例如 80,8000-8080
--percent string          丢包百分比，取值在[0, 100]的正整数 (必要参数)
--remote-port string      远程端口，一般是要访问的外部暴露服务的端口。可以指定多个，使用逗号分隔或者连接符表示范围，例如 80,8000-8080
--force                   强制覆盖已有的 tc 规则，请务必在明确之前的规则可覆盖的情况下使用
--ignore-peer-port        针对添加 --exclude-port 参数，报 ss 命令找不到的情况下使用，忽略排除端口
--timeout string          设定运行时长，单位是秒，通用参数

案例
# 访问本机 8080 和 8081 端口丢包率 70%
blade create network loss --percent 70 --interface eth0 --local-port 8080,8081

# 本机访问外部 14.215.177.39 机器（ping www.baidu.com 获取到的 IP）80 端口丢包率 100%
blade create network loss --percent 100 --interface eth0 --remote-port 80 --destination-ip 14.215.177.39

# 可在本机通过 curl 14.215.177.39 命令验证，会发现访问不通。执行 curl 14.215.177.38 是通的。
# 对整个网卡 eth0 做 60% 的丢包，排除 22 和 8000到8080 端口
blade create network loss --percent 60 --interface eth0 --exclude-port 22,8000-8080

# 会发现 22 端口和 8000 到 8080 端口不受影响，可在另一台相同网络内的机器通过分别执行多次 curl xxx.xxx.xxx.xxx:8080 和 telnet xxx.xxx.xxx.xxx:8081 进行测试

# 实现整个网卡不可访问，不可访问时间 20 秒。执行完成下面命令后，当前的网络会中断掉，20 秒后恢复。切记！！勿忘 --timeout 参数
blade create network loss --percent 100 --interface eth0 --timeout 20

实践
blade create network loss --percent 70 --interface eth0 --local-port 3000 --timeout 60

检查
curl 127.0.0.1:3000
ping 127.0.0.1:3000
```

#### blade create docker

```
docker run --name nginx-test -p 80:80 -d nginx:latest

查看容器 id
docker ps |grep nginx

查看容器 cpu men 情况
docker ps -q | xargs  docker stats --no-stream
```
##### blade create docker cpu

```
介绍
容器内 CPU 负载实验场景，同基础资源的 CPU 场景

命令
支持 CPU 场景命令如下：
blade create docker cpu load 容器内 CPU 负载场景，同 [blade create cpu load](blade create cpu load.md)

参数
除了上述基础场景各自所需的参数外，在 docker 环境下，还支持的参数如下：
--blade-override           是否覆盖容器内已有的 chaosblade 工具，默认是 false，表示不覆盖，chaosblade 在容器内的部署路径为 /opt/chaosblade
--blade-tar-file string    指定本地 chaosblade-VERSION.tar.gz 工具包全路径，用于拷贝到容器内执行
--container-id string      目标容器 ID
--docker-endpoint string   Docker server 地址，默认为本地的 /var/run/docker.sock

案例
对 container id 是 5239e26f6329 的做 CPU 使用率 80% 的实验场景，执行命令如下：
blade create docker cpu fullload --cpu-percent 80 --blade-tar-file /root/chaosblade-0.4.0.tar.gz --container-id 5239e26f6329 

实践（未实践成功）
blade create docker cpu fullload --cpu-percent 80 --blade-tar-file /root/chaosblade/chaosblade-1.7.1-linux-amd64.tar.gz container-id 50811970d1f4
```

##### blade create docker network

```
介绍
容器内网络实验场景，同基础资源的网络场景

命令
支持的网络场景命令如下：
blade create docker network delay 容器网络延迟，同 [blade create network delay](blade create network delay.md)
blade create docker network loss 容器网络丢包，同 [blade create network loss](blade create network loss.md)
blade create docker network dns 容器内域名访问异常，同 [blade create network dns](blade create network dns.md)

参数
除了上述基础场景各自所需的参数外，在 docker 环境下，还支持的参数如下：
--container-id string      目标容器 ID
--docker-endpoint string   Docker server 地址，默认为本地的 /var/run/docker.sock
--image-repo string        chaosblade-tool 镜像仓库地址，默认是从 `registry.cn-hangzhou.aliyuncs.com/chaosblade`

案例
对 nginx 容器 80 端口做访问延迟 3 秒，执行命令如下：
blade create docker network delay --time 3000 --interface eth0 --local-port 80 --container-id 5239e26f6329

实践（未实践成功）
blade create docker network delay --time 3000 --interface eth0 --local-port 80 --container-id 50811970d1f4
```

#### blade create k8s

**k8s 实验场景**

[chaosblade-operator yml 示例](https://github.com/chaosblade-io/chaosblade-operator/tree/master/examples)

- blade create k8s node-cpu Node 节点 CPU 负载场景

- blade create k8s node-network Node 节点网络场景

- blade create k8s node-process Node 节点进程场景

- blade create k8s node-disk Node 节点磁盘场景

- blade create k8s pod-pod Pod 资源场景，比如杀 Pod

- blade create k8s pod-network Pod 网络资源场景，比如网络延迟

- blade create k8s pod-IO Pod IO 文件系统异常场景

- blade create k8s pod-fail Pod 不可用异常场景

- blade create k8s container-container Container 资源场景，比如杀容器

- blade create k8s container-cpu 容器内 CPU 负载场景

- blade create k8s container-network 容器内网络场景

- blade create k8s container-process 容器内进程场景

**k8s 相关操作**

```
查看 node 占有资源
kubectl top node

查看 pod 的容器名称
kubectl get pod mysql -n my-space -o jsonpath={.spec.containers[*].name}

查看 pod 占用资源
kubectl top pod -n kube-system

查看 pod 标签
kubectl get pod -A --show-labels

查看 pod cpu
kubectl top pods -A | sort --reverse --key 3 --numeric

查看 pod memory
kubectl top pods -A | sort --reverse --key 4 --numeric

踩坑：
1、node-cpu 时候使用--names 提示参数非法（bug，待官方人员修复），可用--labels 替代
举例：
blade create k8s node-cpu load --names k8s-master --cpu-percent 80 --timeout 60 --kubeconfig ~/.kube/config
blade create k8s node-cpu load --labels kubernetes.io/hostname=k8s-master --cpu-percent 80 --timeout 60 --kubeconfig ~/.kube/config
2、~/.kube/config 的ip 地址得改成内网的，不然使用 k8s 故障的时候会报错地址无效；注意填写正确的内网地址
```

##### blade create k8s node-cpu

```
Node 节点 CPU 负载场景

命令：
blade create k8s node-cpu load --names <nodeName> --cpu-percent 80 --timeout 60 --kubeconfig ~/.kube/config
举例：
blade create k8s node-cpu load --names k8s-master --cpu-percent 80 --timeout 60 --kubeconfig ~/.kube/config
检查：
kubectl top node / top
```

##### blade create k8s node-disk

```
Node 节点磁盘场景

命令：
blade create k8s node-disk fill --names <nodeName> --path /home --percent 80 --timeout 60 --kubeconfig ~/.kube/config
举例：
blade create k8s node-disk fill --names k8s-master --path /home --percent 80 --timeout 60 --kubeconfig ~/.kube/config
检查：
df -h /home
```

##### blade create k8s node-mem

```
Node 节点内存场景

命令：
blade create k8s node-mem load --names <nodeName> --mem-percent 80 --mode=ram --timeout 60 --kubeconfig ~/.kube/config
举例：
blade create k8s node-mem load --names k8s-master --mem-percent 80 --mode=ram --timeout 60 --kubeconfig ~/.kube/config
检查：
kubectl top node / top
```

##### blade create k8s node-network

```
blade create k8s node-network Node 节点网络场景
blade create k8s node-network delay 节点网络延迟场景
blade create k8s node-network loss 节点网络丢包场景
blade create k8s node-network dns 节点域名访问异常场景

命令：
blade create k8s node-network delay --names <nodeName> --interface eth0 --time 3000 --timeout 60 --kubeconfig ~/.kube/config
举例：
blade create k8s node-network delay --names k8s-master --interface eth0 --time 3000 --timeout 60 --kubeconfig ~/.kube/config
检查：？
```

**pod 故障演练**

```
blade create k8s pod-network Pod 网络资源场景，比如网络延迟
blade create k8s pod-network delay Pod 网络延迟场景
blade create k8s pod-network loss Pod 网络丢包场景
blade create k8s pod-network dns Pod 域名访问异常场景
命令：

举例：
blade create k8s pod-network delay --time 3000 --offset 1000 --interface eth0 --local-port 6379 --names redis-slave-674d68586-jnf7f --namespace default --kubeconfig config
```

**container 故障演练**

```
blade create k8s container-cpu 容器内 CPU 负载场景
命令：
blade create k8s container-cpu fullload --names <pod 名称> --namespace <ns 名称> --container-names <容器名称> \
--cpu-percent 80 --timeout 60 --kubeconfig ~/.kube/config
举例1：
blade create k8s container-cpu fullload --names redis --namespace my-space --container-names redis \
--cpu-percent 80 --timeout 60 --kubeconfig ~/.kube/config
举例2（未实践成功）：
kubectl get pod mysql-mysql-master-0 -n my-space -o jsonpath={.spec.containers[*].name}
blade create k8s container-cpu fullload --names mysql-mysql-master-0 --namespace my-space --container-names mysql \
--cpu-percent 80 --timeout 60 --kubeconfig ~/.kube/config
检查：
kubectl top pod -A
根据消耗的 cpu 排序
kubectl top pod -A | sort --reverse --key 3 --numeric
根据消耗的 men 排序
kubectl top pod -A | sort --reverse --key 4 --numeric
```



## 4. ChaosBlade 原理

### 4.1 磁盘 IO

`dd`是一个用于数据转换和复制的命令行工具，它在Linux和其他类Unix系统中广泛使用。它的名称"dd"代表"数据复制"（data duplicator）

dd 命令的基本用法和一些常见的选项：

```
dd if=input_file of=output_file bs=block_size count=num_blocks [options]
```

- `if`（input file）：指定输入文件或数据源。
- `of`（output file）：指定输出文件或数据目标。
- `bs`（block size）：指定每次复制的数据块大小。默认单位是字节。
- `count`：指定要复制的数据块数量。

常见的选项包括：

- `iflag`：用于指定输入选项

- - `direct`：执行直接 IO，绕过文件系统缓存。
  - `dsync`：在每次读取后进行 `fsync`，确保数据写入磁盘。
  - `fullblock`：读取操作将始终读取完整的块，而不会读取部分块。
  - `nonblock`：使用非阻塞 IO。
  - `noatime`：不更新文件的访问时间。

- `oflag`：用于指定输出选项

- - `direct`：执行直接 IO，绕过文件系统缓存。
  - `dsync`：在每次写入后进行 `fsync`，确保数据写入磁盘。
  - `fullblock`：写入操作将始终写入完整的块，而不会写入部分块。
  - `nonblock`：使用非阻塞 IO。
  - `nocreat`：如果输出文件不存在，则不创建该文件。
  - `excl`：当创建输出文件时，如果文件已存在，则返回错误。

- `status`：控制进度信息的显示频率。

- `seek`：指定输出文件的起始偏移量。

- `skip`：跳过输入文件的起始偏移量。

以下是一些 `dd` 命令的示例：

从一个文件复制到另一个文件：

```
dd if=input.txt of=output.txt bs=1024
```

创建一个固定大小的空文件：

```
dd if=/dev/zero of=emptyfile bs=1M count=100
```

将一个硬盘分区备份到一个文件：

```
dd if=/dev/sdb1 of=backup.img bs=4M
```

从一个设备读取数据并写入另一个设备：

```
dd if=/dev/sda of=/dev/sdb bs=4096
```

生成随机数据并写入文件：

```
dd if=/dev/urandom of=randomdata.bin bs=1M count=10
```



## 5. 知识碎片

[高可用测试用例](https://wi9wku2j1p.feishu.cn/sheets/H5HEsuWGohJZsKtLTQscMVY4n8c)

**踩坑**

```
执行：blade create k8s node-network delay --labels kubernetes.io/hostname=k8s-master --interface eth0 --time 3000 --timeout 60 --kubeconfig ~/.kube/config

报错：{"code":54000,"success":false,"error":"`/bin/sh -c tc qdisc add dev eth0 root netem delay 3000ms 0ms`: cmd exec failed, err: RTNETLINK answers: No such file or directory\n exit status 2","result":{"uid":"71abedb31cae2694","success":false,"error":"`/bin/sh -c tc qdisc add dev eth0 root netem delay 3000ms 0ms`: cmd exec failed, err: RTNETLINK answers: No such file or directory\n exit status 2","statuses":[{"state":"Error","error":"`/bin/sh -c tc qdisc add dev eth0 root netem delay 3000ms 0ms`: cmd exec failed, err: RTNETLINK answers: No such file or directory\n exit status 2","success":false,"kind":"node","identifier":"/k8s-master/"}]}}

解决：
yum -y install iproute-tc
yum install kernel-modules-extra
```
