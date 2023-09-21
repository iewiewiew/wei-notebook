[TOC]

<h1 align="center">Kibana</h1>

> By：weimenghua  
> Date：2023.10.11  
> Description：  

@todo 未安装成功

## Kibana 搭建
[kibana 下载地址](https://www.elastic.co/cn/downloads/kibana)

Linux
```
wget https://artifacts.elastic.co/downloads/kibana/kibana-8.10.2-linux-x86_64.tar.gz
tar -zxvf kibana-8.10.2-linux-x86_64.tar.gz
cd kibana-8.10.2 && ./bin/kibana

报错：Kibana should not be run as root.  Use --allow-root to continue.
解决：./bin/kibana --allow-root
```

Docker
```
docker network create my-network
docker run -d --name kibana -p 5601:5601 --network my-network docker.elastic.co/kibana/kibana:7.15.1
```

访问地址
http://127.0.0.1:5601

检查 Kibana 状态  
http://127.0.0.1:5601/status  
http://127.0.0.1:5601/api/status 返回 JSON 格式状态信息

默认情况下，Kibana连接允许在localhost上的Elasticsearch实例。为了连接到一个不同的Elasticsearch实例，修改kabana.yml中Elasticsearch的URL，然后重启Kibana。