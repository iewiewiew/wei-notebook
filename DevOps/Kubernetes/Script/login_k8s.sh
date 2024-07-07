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
