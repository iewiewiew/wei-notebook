#!/bin/bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：shell 脚本收到中断信号时输出一条消息并终止执行.
#-----------------------------------------------------------------------------


# 捕获中断信号并执行清理操作
trap 'echo "收到中断信号，终止脚本执行"; exit' INT

echo "开始执行脚本..."

echo "脚本执行完成"
#exit

function error() {
  echo "Error occurred. Exiting..."
  exit 1
}


function test_error() {
   trap error ERR
   1/0
#   trap - ERR
}

test_error