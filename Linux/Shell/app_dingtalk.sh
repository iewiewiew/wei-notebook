#!/bin/bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：检查服务进程是否存在, 若不存在则进行钉钉通知.
#-----------------------------------------------------------------------------

time=$(date +%Y-%m-%d_%H:%M:%S)

# content 里面的参数需要加 ''
funDingTalk() {
  curl 'https://oapi.dingtalk.com/robot/send?access_token=1234567890' \
  -H 'Content-Type: application/json' \
  -d '{"msgtype": "text",
       "text": {
          "content": "'$time' test2环境：tc-'$1' '$2' has been killed"
         }
       }'
}

pid_check() {
  pid=$(ps aux | grep tc-$1 | grep -v grep | awk '{print $2}')
  if [ "$pid" ]; then
    echo -e "\033[32m$time tc-$1 $pid 启动成功\n\033[0m"
  else
    echo -e "\033[31m$time tc-$1 $pid 启动失败\n\033[0m"
    funDingTalk $1
  fi
}

core_pid_check() {
  pid=$(ps aux | grep tc-$1 | grep jetty | grep -v grep | awk '{print $2}')
  if [ "$pid" ]; then
    echo -e "\033[32m$time tc-$1 $2 $pid 启动成功\n\033[0m"
  else
    echo -e "\033[31m$time tc-$1 $2 $pid 启动失败\n\033[0m"
    funDingTalk $1 $2
  fi
}

oms_pid_check() {
  pid=$(ps aux | grep tc-$1 | grep tomcat | grep -v grep | awk '{print $2}')
  if [ "$pid" ]; then
    echo -e "\033[32m$time tc-$1 $2 $pid 启动成功\n\033[0m"
  else
    echo -e "\033[31m$time tc-$1 $2 $pid 启动失败\n\033[0m"
    funDingTalk $1 $2
  fi
}

app_list=(demo1 demo2 demo3 demo4)

for i in ${app_list[@]}; do
  if [[ $i = demo3 ]]; then
    oms_pid_check $i oms $time
  elif [[ $i = demo4 ]]; then
    pid_check $i
  else
    core_pid_check $i core $time
    oms_pid_check $i oms $time
  fi
done
