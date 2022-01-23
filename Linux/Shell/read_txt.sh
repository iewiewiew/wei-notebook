#!/bin/bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：读取 txt 内容, 切割字符串.
#-----------------------------------------------------------------------------

array1=$(cat ./demo.txt)
array2='a,b,c'

for arr in ${array1}; do
  vars=(${arr//,/ })
  echo "获取变量1: ${vars[0]} ${vars[1]} ${vars[2]}"

  for var in ${vars[@]}; do
    echo "获取变量2: ${var}"
  done
  echo " "
done
