#!/bin/bash

##############################################
# 说明：一键安装 k3s 以及 helm
##############################################


CURRENT_PATH=`pwd`
TIME=$(date +%Y-%m-%d_%H:%M:%S)
mkdir -vp k3s
cd $CURRENT_PATH/k3s
echo "当前路径: $CURRENT_PATH/k3s"


function install() {
  install_k3s
  install_helm
}


function uninstall() {
  uninstall_k3s
  uninstall_helm
}


function log() {
  echo -e "\033[32m${TIME} $1 \033[0m"
}


function install_k3s() {
  sed -i 's/enforcing/disabled/' /etc/selinux/config
  k3s=`kubectl get node |grep -v STATUS |awk '{print $2}'`
  if [[ $k3s = "Ready" ]];then
    log "k3s 已存在, 跳过安装步骤"
  else
    log "k3s 不存在, 开始进行安装"
    curl -sfL https://rancher-mirror.oss-cn-beijing.aliyuncs.com/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn sh -

    mkdir -p $HOME/.kube
    cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
    chown $(id -u):$(id -g) $HOME/.kube/config
    cat ~/.kube/config

    kubectl get node
  fi
}


function install_helm() {
  helm=`helm version |grep version`
  if [[ $helm != "" ]];then
    log "helm 已存在, 跳过安装步骤"
  else
    log "helm 不存在, 开始进行安装"
    wget https://mirrors.huaweicloud.com/helm/v3.7.2/helm-v3.7.2-linux-amd64.tar.gz
    tar -zxvf helm-v3.7.2-linux-amd64.tar.gz

    chmod 755 linux-amd64/helm
    cp linux-amd64/helm /usr/local/bin/
    ls /usr/local/bin/
  fi

if cat '/etc/profile' | grep "helm" > /dev/null
then
    log "已存在 helm, 请查看: cat /etc/profile"
else
    log "向 /etc/profile 写入配置"

cat >> /etc/profile << EOF
source <(helm completion bash)
EOF

  source /etc/profile
  cat /etc/profile
  helm version
fi
}


function uninstall_k3s() {
  log "开始卸载 k3s"
  sh /usr/local/bin/k3s-uninstall.sh
}


function uninstall_helm() {
  log "开始卸载 helm"
  rm -rf helm* & rm -rf linux-amd64
  cd /usr/local/bin/ && rm -rf helm
  sed -i '/source <(helm completion bash)/d' /etc/profile
}


case $1 in
  "install")
  install
  ;;
  "uninstall")
  uninstall
  ;;
  *)
  log "安装: sh install_k3s.sh install"
  log "卸载: sh install_k3s.sh uninstall"
  ;;
esac
