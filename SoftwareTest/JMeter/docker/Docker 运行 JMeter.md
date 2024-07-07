[TOC]

<h1 align="center">Docker 运行 JMeter</h1>

> By：weimenghua  
> Date：2023.06.01  
> Description：  

**参考资料**  
[alpine/jmeter](https://hub.docker.com/r/alpine/jmeter/tags)



## 搭建 JMeter 集群

### Docker

```
1、为了让 JMeter 主节点和从节点之间可以互相通信，创建一个自定义的 Docker 网络
docker network create jmeter-network

2、启动 JMeter 从节点
for i in {1..3}; do
docker run --network jmeter-network --name jmeter-slave-$i -d justb4/jmeter -s -Jserver.rmi.ssl.disable=true
done

3、启动 JMeter 主节点
docker run \
--network jmeter-network \
--name jmeter-master \
-it --rm \
-v ~/jmeter_tests:/tests justb4/jmeter \
-n -t /tests/jmeter_demo.jmx \
-l /tests/results.jtl \
-e -o /tests/`date +%Y%m%d%H%M%S`/ \
-R jmeter-slave-1,jmeter-slave-2,jmeter-slave-3 \
-Jserver.rmi.ssl.disable=true

4、删除容器
docker rm -f jmeter-slave-1
docker rm -f jmeter-slave-2
docker rm -f jmeter-slave-3
```



### Dockerfile

#### Master 节点

```
制作镜像
docker build -t jmeter .

推送镜像到远程仓库
docker login -uwwweeeiii -proot docker.io
docker tag jmeter wwweeeiii/jmeter:latest
docker push wwweeeiii/jmeter:latest

使用本地镜像运行容器
docker run -d -it --name jmeter5.5 -v /root/jmeter:/root/jmeter jmeter

使用远程镜像运行容器
docker run -d -it --name jmeter5.5 -v /root/jmeter:/root/jmeter wwweeeiii/jmeter:latest

进入容器查看 JMeter 是否可用
docker exec -it jmeter5.5 sh
jmeter -v

进入容器执行脚本
jmeter -n -t /root/jmeter/jmeter_demo.jmx -l result.jtl
jmeter -n -t /root/jmeter/jmeter_demo.jmx -l result.jtl -e -o /root/jmeter/`date +%Y%m%d%H%M%S`/

在宿主机执行容器内脚本
docker exec -it jmeter5.5 sh -c 'jmeter -n -t /root/jmeter/jmeter_demo.jmx -l result.jtl'
docker exec -it jmeter5.5 sh -c 'jmeter -n -t /root/jmeter/jmeter_demo.jmx -l result.jtl -e -o /root/jmeter/`date +%Y%m%d%H%M%S`'
```

#### Slave 节点（未实践成功）

```
修改 jmeter.properties 的 server.rmi.ssl.disable 为 true
sed -i 's/\#server.rmi.ssl.disable=false/server.rmi.ssl.disable=true/' /root/jmeter/jmeter.properties

构建从节点镜像
docker build -t jmeterslave .

运行从节点
docker run -d --name jmeterslave1 jmeterslave

查看 jmeter 主机和执行机的 ip
docker inspect --format '{{ .Name }} => {{ .NetworkSettings.IPAddress }}' $( docker ps -a -q)
```


其它
```
RUN tar -zxvf apache-jmeter-5.5.tgz
RUN sed -i 's/output_format=csv/output_format=xml/' /root/jmeter/apache-jmeter-5.5/bin/jmeter.properties
RUN tar -zcvf apache-jmeter-5.5.tgz apache-jmeter-5.5

压缩测试报告
tar -zcvf tmp.tar.gz 20230609065304/
```
