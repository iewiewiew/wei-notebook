#!/bin/bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：启动中间件.
#-----------------------------------------------------------------------------

usage="Usage: $(basename $0) (mysql|zookeeper|redis|rocketmq|dubbo-admin|all) "
command=$1

function start_mysql() {
  echo 'mysql 启动'
}

function start_zookeeper() {
  echo 'zookeeper 启动'
}

function start_redis() {
  echo 'redis 启动'
}

function start_rocketmq() {
  echo 'rocketmq 启动'
}

function start_dubbo_admin() {
  echo 'dubbo-admin 启动'
}

case $command in
mysql)
  start_mysql
  ;;
zookeeper)
  start_zookeeper
  ;;
redis)
  start_redis
  ;;
rocketmq)
  start_rocketmq
  ;;
dubbo-admin)
  start_dubbo_admin
  ;;
all)
  start_mysql
  start_zookeeper
  start_redis
  start_rocketmq
  start_dubbo_admin
  ;;
*)
  echo "Error command"
  ;;
esac
