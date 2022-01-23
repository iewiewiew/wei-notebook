[TOC]

<h1 align="center">Kuboard Kubernetes 图形化管理工具</h1>

> By：weimenghua  
> Date：2022.10.02  
> Description：



### 一、Kuboard 简介
[Kuboard 简介](https://kuboard.cn/overview/)*
Kuboard，是一款免费的 Kubernetes 图形化管理工具，Kuboard 力图帮助用户快速在 Kubernetes 上落地微服务。提供了丰富的功能，结合已有或新建的代码仓库、镜像仓库、CI/CD 工具等，可以便捷的搭建一个生产可用的 Kubernetes 容器云平台，轻松管理和运行云原生应用。
样例：https://demo.kuboard.cn  
用 户：demo  
密 码：demo123

![](./img/Kuboard.png)



## 二、Kuboard 搭建
[Kuboard 安装教程](https://kuboard.cn/install/v3/install-in-k8s.html#%E5%AE%89%E8%A3%85)

```
1、安装 Kuboard
kubectl apply -f https://addons.kuboard.cn/kuboard/kuboard-v3.yaml

2、访问 Kuboard
在浏览器中打开链接 http://127.0.0.1:30080, 输入初始用户名和密码，并登录
用户名： admin
密码： Kuboard123

3、踩坑
执行：kubectl get pods -n kuboard
如果结果中没有出现 kuboard-etcd-xxxxx 的容器, 就执行：kubectl label nodes docker-desktop k8s.kuboard.cn/role=etcd 

4、创建集群，登陆 kuboard 拿到如下命令
curl -k 'http://127.0.0.1:30080/kuboard-api/cluster/default/kind/KubernetesCluster/default/resource/installAgentToKubernetes?token=0vPAhlKn6zIcNfvDsUBKX7t64yV4R46d' > kuboard-agent.yaml

kubectl apply -f ./kuboard-agent.yaml
```

**2.3.3、Kuboard 删除**

```
1、查询 pod
kubectl get pods -n kuboard
kubectl get pods --all-namespaces | grep "kuboard"

2、删除 pod
kubectl delete pods kuboard-etcd-lmtz8 --ns=kuboard

3、查询 service
kubectl get service -A

4、删除 service
kubectl delete service kuboard --ns=kube-system

5、卸载 kuboard
kubectl delete -f https://addons.kuboard.cn/kuboard/kuboard-v3.yaml

6、删除 ns 下所有资源
kubectl delete ns kuboard --force --grace-period=0
kubectl get ns kuboard -o json > kuboard.json，将 finalizers 字段去掉
kubectl proxy --port=8002
curl -k -H "Content-Type: application/json" -X PUT --data-binary @kuboard.json http://127.0.0.1:8002/api/v1/namespaces/kuboard/finalize
```
