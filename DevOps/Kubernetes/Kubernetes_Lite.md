[TOC]

<h1 align="center">Kubernetes_Lite</h1>

> By：weimenghua  
> Date：2022.10.01   
> Description：k8s 轻量版



## 1. K0S

**参考资料**  
[k0sproject](https://k0sproject.io/)  
[docs.k0sproject](https://docs.k0sproject.io/v1.27.1+k0s.0/)

### 1.1 K0S 简介

K0S 轻量级 Kubernetes

### 1.2 K0S 搭建

```
curl -sSLf https://get.k0s.sh | sudo sh

sudo k0s install controller --single

sudo k0s start

sudo k0s status
```



## 2. K3S

**参考资料**  
[K3S 官网](https://k3s.io/)  
[K3S 文档](https://docs.rancher.cn/docs/k3s/_index)  
[K3S 源码](https://github.com/k3s-io/k3s)

### 2.1 K3S 简介

K3S 轻量级 Kubernetes

### 2.2 K3S 搭建

```
关闭防火墙
sed -i 's/enforcing/disabled/' /etc/selinux/config

安装
方式一
curl -sfL https://rancher-mirror.oss-cn-beijing.aliyuncs.com/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn sh -
方式二
curl -sfL https://get.k3s.io | sh -

待定
dnf install -y container-selinux
dnf install -y https://rpm.rancher.io/k3s/stable/common/centos/8/noarch/

配置
mkdir -p $HOME/.kube
cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
cat ~/.kube/config

vim ~/.kube/config
修改 127.0.0.1 为公网 IP

重启
systemctl restart k3s

停止
systemctl stop k3s

查看状态
systemctl status k3s.service

验证
kubectl get node

卸载
sh /usr/local/bin/k3s-uninstall.sh
```



## 3. KubeSphere

[KubeSphere 官网](https://kubesphere.io/zh/)



## 4. MiniKube

### 4.1 MiniKube 搭建

Minikube 是一种轻量级的 Kubernetes 实现，可在本地计算机上创建 VM 并部署仅包含一个节点的简单集群。 Minikube 可用于 Linux ， macOS 和 Windows 系统。Minikube CLI 提供了用于引导集群工作的多种操作，包括启动、停止、查看状态和删除。
```
1、下载 minikube
curl -Lo minikube https://kubernetes.oss-cn-hangzhou.aliyuncs.com/minikube/releases/v1.18.1/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

2、启动 minikube
minikube start      
```

### 4.2 MiniKube 常用指令

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
