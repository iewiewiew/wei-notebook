#!/bin/bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：检查服务进程是否存在, 若不存在则进行邮件通知.
#-----------------------------------------------------------------------------

BASE_PATH=$(
  cd $(dirname $0)
  pwd
)

time=$(date +%Y-%m-%d_%H:%M:%S)

pid_check() {
  pid=$(ps aux | grep tc-$1 | grep -v grep | awk '{print $2}')
  if [ "$pid" ]; then
    echo -e "\033[32m$time tc-$1 $pid 启动成功\n\033[0m"
  else
    echo -e "\033[31m $time tc-$1 $pid 启动失败\n\033[0m" >$BASE_PATH/app_status_notice.log
  fi
}

core_pid_check() {
  pid=$(ps aux | grep tc-$1 | grep jetty | grep -v grep | awk '{print $2}')
  if [ "$pid" ]; then
    echo -e "\033[32m$time tc-$1 $2 $pid 启动成功\n\033[0m"
  else
    echo -e "\033[31m $time tc-$1 $2 $pid 启动失败\n\033[0m" >$BASE_PATH/app_status_notice.log
  fi
}

oms_pid_check() {
  pid=$(ps aux | grep tc-$1 | grep tomcat | grep -v grep | awk '{print $2}')
  if [ "$pid" ]; then
    echo -e "\033[32m$time tc-$1 $2 $pid 启动成功\n\033[0m"
  else
    echo -e "\033[31m $time tc-$1 $2 $pid 启动失败\n\033[0m" >$BASE_PATH/app_status_notice.log
  fi
}

app_list=(demo1 demo2 demo3 demo4)

for i in ${app_list[@]}; do
  if [[ $i = demo3 ]]; then
    oms_pid_check $i oms
  elif [[ $i = demo4 ]]; then
    pid_check $i
  else
    core_pid_check $i core
    oms_pid_check $i oms
  fi
done

for touser in $(cat $BASE_PATH/mail.properties); do
  mail -s "检测应用状态完毕" $touser <$BASE_PATH/app_status_notice.log
  echo '给'$touser'发送邮件完毕'
done
