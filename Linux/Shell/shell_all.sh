#!/bin/bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：function 集合.
#-----------------------------------------------------------------------------

# 在 shell 脚本中，local 关键字用于声明一个局部变量，其作用域仅限于当前的函数内部。这意味着在函数外部无法访问该变量。
function local_demo {
  local myvar="Hello"
  echo "输入局部变量 ${myvar}"
}


# 将当前工作目录切换到正在运行的脚本所在目录的父目录
function crtl_demo {
  local crtl
  crtl=$(
    cd -- "$(dirname "$0")" || exit 1
    pwd
  )
  echo "获取脚本所在目录1 ${crtl}"

  crtl2=$(dirname "$(readlink -f "$0")")
  echo "获取脚本所在目录2 ${crtl2}"
}


function menu_demo() {
  echo -e "\t    标题\n"
  echo -e "\t1.    选择1\n"
  echo -e "\t2.    选择2\n"
  echo -e "\t0.    退出\n\n"
  echo -en "\t请输入:"
  read -r global_option
  echo "当前选择 ${global_option}"
}


function main() {
#  local_demo
#  crtl_demo
  menu_demo
}

main "$@"