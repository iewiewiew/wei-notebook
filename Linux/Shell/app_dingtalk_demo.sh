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
          "content": "'$time' '${HOSTNAME}' '$1' has been killed"
         }
       }'
}

pid_check() {
  pid=$(ps aux | grep $1 | grep -v grep | awk '{print $2}')
  if [ "$pid" ]; then
    echo -e "\033[32m$time $1 $pid 存在进程\n\033[0m"
  else
    echo -e "\033[31m$time $1 无进程\n\033[0m"
    funDingTalk $1
  fi
}

app_list=(app1 app2 app3 app4)

for i in ${app_list[@]}; do
  pid_check $i
done
