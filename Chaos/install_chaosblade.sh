#!/bin/bash

######
# 脚本说明: 一键搭建 ChaosBlade 环境
######

LOCAL_PATH=`pwd`
echo "当前目录: ${LOCAL_PATH}"

init() {
  createChaosFileDir
  instalChaosblade
  instalChaosbladeOperator
}

uninstall() {
  uninstallChaosblade
  uninstallChaosbladeOperator
}


createChaosFileDir() {
  if ! [ -d "chaos" ]; then
    mkdir chaos
  fi
  cd chaos
}


instalChaosblade() {
  if [ `blade v |grep version |awk -F : '{print $1}'` = "version" ];then
    echo "chaosblade 已存在, 无需重复安装"
  else
    echo "开始安装 chaosblade"
    wget https://chaosblade.oss-cn-hangzhou.aliyuncs.com/agent/github/1.7.1/chaosblade-1.7.1-linux-amd64.tar.gz
    tar -zxvf chaosblade-1.7.1-linux-amd64.tar.gz && cd chaosblade-1.7.1/
    ln -s `pwd`/blade /usr/local/bin/blade
    blade v
  fi
}


instalChaosbladeOperator() {
  podInChaosblade=$(kubectl -n chaosblade get pod | wc -l)
  if [ $podInChaosblade -eq 0 ]; then
    echo "开始安装 chaosblade-operator, 查看 pod 状态: kubectl -n chaosblade get pod"
    wget https://github.com/chaosblade-io/chaosblade/releases/download/v1.7.1/chaosblade-operator-1.7.1.tgz
    helm install chaosblade-operator chaosblade-operator-1.7.1.tgz --namespace chaosblade --create-namespace
    kubectl get pod -n chaosblade
  else
    echo "chaosblade-operator 已存在，无需重复安装"
  fi
}

uninstallChaosblade() {
  rm -rf chaosblade-1.7.1*
}

uninstallChaosbladeOperator() {
  kubectl delete crd chaosblades.chaosblade.io
  helm uninstall chaosblade-operator -n chaosblade
  helm del --purge chaosblade-operator
}

init
#uninstall