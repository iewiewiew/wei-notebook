[TOC]

<h1 align="center">Grafana+Prometheus</h1>

> By：weimenghua  
> Date：2024.10.21  
> Description：Grafana+Prometheus

## 1. Prometheus

[Prometheus 下载地址](https://prometheus.io/download/)

下载安装包
wget https://github.com/prometheus/prometheus/releases/download/v3.0.0-beta.1/prometheus-3.0.0-beta.1.linux-amd64.tar.gz

解压安装包
tar -zxvf prometheus-3.0.0-beta.1.linux-amd64.tar.gz

重命名目录
mv prometheus-3.0.0-beta.1.linux-amd64 prometheus-3.0.0

在 prometheus.yml 添加 Clickhouse 配置
cd prometheus-3.0.0
vim prometheus.yml

```text
- job_name: 'clickhouse' # clickHouse任务
  static_configs:
    - targets: ['localhost:9363'] # 主机ip:9363，配置本机 ip 或者 localhost
```

后台启动服务
nohup ./prometheus --config.file=prometheus.yml > ./nohup.log 2>&1 &

停止服务
ps -ef | grep prometheus | grep -v grep | awk '{print $2}' | xargs kill -9

查看日志
tail -500f nohup.log

查看服务
http://127.0.0.1:9090/
http://127.0.0.1:9090/targets

踩坑，已经开放端口仍然无法访问，原因是没有关闭防火墙
systemctl stop firewalld    //暂时关闭防火墙
systemctl disable firewalld //永久关闭防火墙
检查：firewall-cmd --state

## 2. Grafana

[Grafana 下载地址](https://grafana.com/grafana/download)

下载安装包
wget https://dl.grafana.com/enterprise/release/grafana-enterprise-11.2.2.linux-amd64.tar.gz

解压安装包
tar -zxvf grafana-enterprise-11.2.2.linux-amd64.tar.gz

后台启动服务
nohup ./bin/grafana-server web > ./nohup.log 2>&1 &

查看日志
tail -500f nohup.log

停止服务
ps -ef | grep grafana | grep -v grep | awk '{print $2}' | xargs kill -9

查看服务
http://127.0.0.1:3000/login admin/admin
