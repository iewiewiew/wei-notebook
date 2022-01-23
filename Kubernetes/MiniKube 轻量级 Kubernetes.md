[TOC]

---

<h1 align="center">Minikube 轻量级 Kubernetes</h1>

> By：weimenghua  
> Date：2022.10.01   
> Description：Rancher



### MiniKube 搭建

Minikube 是一种轻量级的 Kubernetes 实现，可在本地计算机上创建 VM 并部署仅包含一个节点的简单集群。 Minikube 可用于 Linux ， macOS 和 Windows 系统。Minikube CLI 提供了用于引导集群工作的多种操作，包括启动、停止、查看状态和删除。
```
1、下载 minikube
curl -Lo minikube https://kubernetes.oss-cn-hangzhou.aliyuncs.com/minikube/releases/v1.18.1/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

2、启动 minikube
minikube start      
```



### MiniKube 常用指令

```
1. minikube version             //查看版本
2. minikube status              //查看状态
3. minikube profile list        //查看属性
4. minikube addons list         //查看当前支持的插件
5. minikube service list        //查看服务列表
6. minikube node list           //参看添加的 node
7. minikube ssh                 //登录
8. minikube ip                  //获取 IP 地址
9. minikube start               //启动或重启
10. minikube stop               //停止
11. minikube delete             //删除
12. minikube dashboard          //在默认浏览器中启动仪表盘
13. rm-rf ~/.minikube           //重置(清理所有缓存的镜像）
```
