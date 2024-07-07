#!/bin/bash

##############################################
# 说明: 基于 Docker 一键安装监控环境
##############################################


# 当前目录
CURRENT_DIR=`pwd`
# 容器命令
SERVER_NAME=$1
# 时间
TIME=$(date +%Y-%m-%d_%H:%M:%S)
# IP 地址
IP_ADDR=`curl cip.cc |grep IP |awk -F: '{ print$2 }' |awk '{ print$1 }'`


function init() {
#  grafana
  prometheus
#  influxdb
  node_exporter
#  mysqld_exporter
#  telegraf

  log "进入 Grafana: http://$IP_ADDR:3000/login admin/admin, 配置 Prometheus 数据源: http://$IP_ADDR:9090,
  导入 Grafana 模板(模板 ID: 11074)、（MySQL 模板 ID：7362）"
}


function log() {
  echo -e "\033[32m${TIME} $1 \033[0m"
}


if which docker >/dev/null; then
   log "检测到 Docker 已安装，跳过安装步骤"
#   mkdir -vp ${CURRENT_DIR}/log
#   echo "启动 Docker "
#   service docker start 2>&1 | tee -a ${CURRENT_DIR}/log/install.log
else
   if [[ -d docker ]]; then
      log "离线安装 docker"
      cp docker/bin/* /usr/bin/
      cp docker/service/docker.service /etc/systemd/system/
      chmod +x /usr/bin/docker*
      chmod 754 /etc/systemd/system/docker.service
      log "启动 docker"
#      service docker start 2>&1 | tee -a ${CURRENT_DIR}/log/install.log
   else
      log "在线安装 docker"
      curl -fsSL https://get.docker.com -o get-docker.sh 2>&1 | tee -a ${CURRENT_DIR}/log/install.log
      sudo sh get-docker.sh --mirror Aliyun 2>&1 | tee -a ${CURRENT_DIR}/log/install.log
      log "启动 docker"
      service docker start 2>&1 | tee -a ${CURRENT_DIR}/log/install.log
   fi
fi

docker ps 1>/dev/null 2>/dev/null
if [ $? != 0 ];then
   log "Docker 未正常启动，请先安装并启动 Docker 服务后再次执行本脚本"
   exit
fi


function check() {
  CONTAINER_ID=`docker ps -a |grep ${SERVER_NAME} |awk '{print $1}'`
  if [[ $CONTAINER_ID != "" ]]; then
    log "${SERVER_NAME}服务存在, 进行删除${SERVER_NAME}容器"
    docker rm -f ${SERVER_NAME}
  else
    log "${SERVER_NAME}服务不存在, 进行创建${SERVER_NAME}容器"
  fi
}


function operate() {
  log "进入容器: docker exec -it ${SERVER_NAME} /bin/bash"
  log "查看容器: docker inspect ${SERVER_NAME}"
  log "查看日志: docker logs -f ${SERVER_NAME}"
  log "删除容器: docker rm -f ${SERVER_NAME} \n\n"
}


function grafana() {
  SERVER_NAME=grafana
  check

  docker run -d \
  --name grafana \
  -p 3000:3000 \
  grafana/grafana

  if [ ! -d ${CURRENT_DIR}/grafana ];then
    mkdir -vp ${CURRENT_DIR}/grafana
  fi

  docker cp grafana:/etc/grafana ${CURRENT_DIR}/grafana/conf
  docker cp grafana:/var/lib/grafana ${CURRENT_DIR}/grafana/data
  docker cp grafana:/var/log/grafana ${CURRENT_DIR}/grafana/log

  groupadd -g 472 grafana
  useradd  -u 472 grafana -g 472
  chown -R grafana:grafana ${CURRENT_DIR}/grafana

  docker rm -f grafana

  docker run -d \
  --name grafana \
  -p 3000:3000 \
  -v ${CURRENT_DIR}/grafana/conf:/etc/grafana \
  -v ${CURRENT_DIR}/grafana/data:/var/lib/grafana \
  -v ${CURRENT_DIR}/grafana/log:/var/log/grafana \
  grafana/grafana

  log "访问地址: http://$IP_ADDR:3000/login admin/admin"

  operate
}


function prometheus() {
  SERVER_NAME=prometheus
  check

  if [ ! -d prometheus ];then
    mkdir prometheus
    cd prometheus
  else
    cd prometheus
  fi

  rm -rf prometheus.yml

# 踩坑：此处需顶格
cat >> prometheus.yml <<EOF
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: "prometheus"
    static_configs:
    - targets: ["localhost:9090","127.0.0.1:9100"]
    # 127.0.0.1:9100 是 xxx-exporter 的地址

    - job_name: "mysql"
      static_configs:
      - targets: ["127.0.0.1:9104"]
EOF

  sed -i "s/127.0.0.1/$IP_ADDR/p" prometheus.yml

  docker run -d \
  --name prometheus \
  -p 9090:9090 \
  -v ${CURRENT_DIR}/prometheus:/etc/prometheus \
  prom/prometheus

  log "访问地址: http://$IP_ADDR:9090"

  operate
}


function influxdb() {
  SERVER_NAME=influxdb
  check

  docker run -d \
  --name influxdb \
  -p 8083:8083 \
  -p 8086:8086 \
  -v ${CURRENT_DIR}/influxdb:/var/lib/influxdb \
  tutum/influxdb

  log "可视化页面访问地址: http://$IP_ADDR:8083"
  log "API 端口访问地址: http://$IP_ADDR:8086"

  operate
}


# 注: 方法名带着 - , 需要将脚本赋予执行权限, 并使用./demo.sh 的执行方式
function node_exporter() {
  SERVER_NAME=node-exporter
  check

  docker run -d \
  --name node-exporter \
  -p 9100:9100 \
  -v /${CURRENT_DIR}/node-exporter/proc:/host/proc:ro \
  -v /${CURRENT_DIR}/node-exporter/sys:/host/sys:ro \
  -v /${CURRENT_DIR}/node-exporter:/root/dockerfs:ro \
  prom/node-exporter

  log "访问地址: http://$IP_ADDR:9100"

  operate
}


# 注: 方法名带着 - , 需要将脚本赋予执行权限, 并使用./demo.sh 的执行方式
function mysqld_exporter() {
    SERVER_NAME=mysqld-exporter
    check

    docker run -d \
      --name mysqld-exporter
      -p 9104:9104 \
      --net="host" \
      --pid="host" \
      -e DATA_SOURCE_NAME="root:root@($IP_ADDR:3306)/" \
      prom/mysqld-exporter

    log "访问地址: http://$IP_ADDR:9104"

    operate
}


function telegraf() {
  SERVER_NAME=telegraf
  check

  mkdir -vp telegraf
  docker run --rm telegraf:alpine telegraf config > ${CURRENT_DIR}/telegraf/telegraf.conf
  docker run -d --name=telegraf \
  -p 8125:8125/udp \
  -v ${CURRENT_DIR}/telegraf/telegraf.conf:/etc/telegraf/telegraf.conf:ro \
  -v ${CURRENT_DIR}/telegraf:/hostfs:ro \
  -e HOST_ETC=/hostfs/etc \
  -e HOST_PROC=/hostfs/proc \
  -e HOST_SYS=/hostfs/sys \
  -e HOST_VAR=/hostfs/var \
  -e HOST_RUN=/hostfs/run \
  -e HOST_MOUNT_PREFIX=/hostfs \
  telegraf:alpine

  operate
}

init