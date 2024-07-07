#!/bin/bash


######
# 脚本说明: 基于 Docker 一键安装中间件
######


# 目录挂载的根目录
CURRENT_DIR=`pwd`
# 容器命令
SERVER_NAME=$1
# 时间
TIME=$(date +%Y-%m-%d_%H:%M:%S)
# IP 地址
IP_ADDR=`curl cip.cc |grep IP |awk -F: '{ print$2 }' |awk '{ print$1 }'`


# 安装 Docker
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
      mkdir -vp ${CURRENT_DIR}/log
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


# 输入日志
function log() {
  echo -e "\033[32m${TIME} $1 \033[0m"
}


# 检查服务是否存在
function check() {
  CONTAINER_ID=`docker ps |grep ${SERVER_NAME} |awk '{print $1}'`
  if [[ $CONTAINER_ID != "" ]]; then
    log "${SERVER_NAME}服务存在, 进行删除${SERVER_NAME}容器"
    docker rm -f ${SERVER_NAME}
  else
    log "${SERVER_NAME}服务不存在, 进行创建${SERVER_NAME}容器"
  fi
}


# 容器操作命令
function operate() {
  log "进入容器: docker exec -it ${SERVER_NAME} /bin/bash"
  log "查看容器: docker inspect ${SERVER_NAME}"
  log "查看日志: docker logs -f ${SERVER_NAME}"
  log "删除容器: docker rm -f ${SERVER_NAME}"
  log "查看博客：https://iewiewiew.github.io/docs/"
}


function mysql() {
  check

  docker run -d \
  --name mysql \
  --restart always \
  -p 3306:3306 \
  -v /var/lib/mysql:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=root \
  mysql:8.0

  docker cp /usr/share/zoneinfo/Asia/Shanghai mysql:/etc/localtime

  docker restart mysql

  log "访问地址: $IP_ADDR 3306 root root"

  operate
}


function redis() {
  check

  docker run -d \
  --name redis \
  -p 6379:6379 \
  -v ${CURRENT_DIR}/docker/redis/redis.conf:/etc/redis/redis.conf \
  -v ${CURRENT_DIR}/docker/redis/data:/data \
  redis \
  redis-server /etc/redis/redis.conf --appendonly yes --requirepass "root"

  log "访问地址: $IP_ADDR 6379 root root"
  log "进入客户端: docker exec -it redis redis-cli"

  operate
}



function postgres() {
  check

  docker run -d \
  --name postgres \
  --restart=always \
  -p 5432:5432 \
  -v ${CURRENT_DIR}/docker/postgresql:/var/lib/postgresql/data \
  -e POSTGRES_PASSWORD=postgres \
  postgres

  log "访问地址: $IP_ADDR 5432 postgres postgres"

  operate
}


function mongodb() {
  check

  docker run -d \
  --name mongodb \
  --restart always \
  --privileged \
  -p 27017:27017 \
  -v ${CURRENT_DIR}/docker/mongo:/data/db \
  mongo

  operate
}


function portainer() {
  check

  docker run -d \
  --name portainer \
  --restart=always \
  -p 9000:9000 \
  -p 8000:8000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${CURRENT_DIR}/docker/docker/portainer/data:/data \
   portainer/portainer

  log "访问地址: http://"$IP_ADDR":9000"

  operate
}


function jenkins() {
  check

  docker run -d \
  --name=jenkins \
  --restart=always \
  -u root \
  -p 5555:8080 \
  -p 50000:50000 \
  -v /var/jenkins_home:/var/jenkins_home \
  -v /etc/localtime:/etc/localtime \
  jenkins/jenkins

  log "访问地址: http://"$IP_ADDR":5555"
  log "查看密码: cat /var/jenkins_home/secrets/initialAdminPassword"

  operate
}


function minio() {
  check

  docker run -d \
  --restart=always \
  --name minio \
  -p 9090:9090 \
  -p 9001:9001 \
  -v ${CURRENT_DIR}/docker/minio/data:/data \
  -e "MINIO_ROOT_USER=minioadmin" \
  -e "MINIO_ROOT_PASSWORD=minioadmin" \
  minio/minio server /data --console-address ":9090" -address ":9000"

  log "访问地址: http://$IP_ADDR:9090 minioadmin/minioadmin"

  operate
}


function help() {
  log "执行命令：sh install_software.sh <服务名称>
举例：sh install_software.sh portainer|jenkins|mysql|redis|postgres|mongodb|minio"
}


case $1 in
"portainer")
portainer
;;
"jenkins")
jenkins
;;
"mysql")
mysql
;;
"redis")
redis
;;
"postgres")
postgres
;;
"mongodb")
mongodb
;;
"minio")
minio
;;
*)
help
;;
esac
