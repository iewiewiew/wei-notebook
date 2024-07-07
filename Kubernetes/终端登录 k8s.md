[TOC]

<h1 align="center">终端登录 k8s</h1>

> By：weimenghua  
> Date：2023.05.31  
> Description：



### 1. 安装 kubectl

```
下载
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

安装
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

验证
kubectl -h
```



### 2. 配置

```
查看上下文获取<cluster_name>
kubectl config current-context
举例：<cluster_name>=default

查看集群状态获取<cluster_ip>
kubectl cluster-info
举例：<cluster_ip>=127.0.0.1

获取<username>
kubectl config view --minify --output 'jsonpath={..name}'
举例：<username>=default

获取<token>
k3s kubectl -n kubernetes-dashboard create token admin-user

获取上下文列表
kubectl config get-contexts

配置
kubectl config set-cluster <cluster_name> --server=https://<cluster_ip>:6443 --insecure-skip-tls-verify=true
kubectl config set-credentials <username> --token=<token>
kubectl config set-context <cluster_name> --user=<username> --cluster=<cluster_name>
kubectl config use-context <cluster_name>

举例
kubectl config set-cluster default --server=https://127.0.0.1:6443 --insecure-skip-tls-verify=true
kubectl config set-credentials default --token=`k3s kubectl -n kubernetes-dashboard create token admin-user
`
kubectl config set-context default --user=default --cluster=default
kubectl config use-context default

查看本地 config
cat ~/.kube/config
```



### 3. 添加脚本

```
#!/bin/bash


# 方式一：vim ~/.bashrc，添加：function 脚本 和 alias='pod' alias='log' 后执行：source ~/.bashrc
# 方式二：把 login_k8s.sh 上传到 /etc/profile.d 后执行：source /etc/profile.d


function pod() {
  if [ -z "$1" ]; then
    echo -e "\033[32m kubectl get pod -A \033[0m"
    kubectl get pod -A
  else
    kubectl config set-context --current --namespace=$1

    echo -e "\033[32m 获取第1个 pod 名称: kubectl get pod -n $1 |grep $2 |awk '{print \$1}' |head -n 1 \033[0m"
    pod_name=`kubectl get pod -n $1 |grep $2 |awk  '{print \$1}' |head -n 1`

    echo -e "\033[32m 进入第1个 pod: kubectl exec -it pod/$pod_name -n $1 -- sh \033[0m"
    kubectl exec -it pod/$pod_name -n $1 -- sh
  fi
}


function log() {
  if [ -z "$1" ]; then
    echo -e "\033[32m kubectl get pod -A \033[0m"
    kubectl get pod -A
  else
    kubectl config set-context --current --namespace=$1

    echo -e "\033[32m 获取第1个 pod 名称: kubectl get pod -n $1 |grep $2 |awk '{print \$1}' |head -n 1 \033[0m"
    pod_name=`kubectl get pod -n $1 |grep $2 |awk  '{print \$1}' |head -n 1`

    kubectl logs -f $pod_name -n $1
  fi
}

alias pod='pod'
alias log='log'
```
