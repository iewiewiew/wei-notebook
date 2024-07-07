#!/bin/zsh

##############################################
# 说明: 安装 Docker Compose
##############################################

function install_dc() {
   if command -v docker-compose >/dev/null 2>&1; then
       version=$(docker-compose --version | awk '{print $3}')
       echo "Docker Compose 版本为: ${version}"
   else
       echo "Docker Compose 未安装或未在系统的可执行路径中, 即将开始安装..."
       curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
       chmod +x /usr/local/bin/docker-compose
       ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
       docker-compose --version
   fi
}


install_dc