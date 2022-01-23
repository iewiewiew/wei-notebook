#!/bin/bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：function 集合.
#-----------------------------------------------------------------------------

# 在 shell 脚本中，local 关键字用于声明一个局部变量，其作用域仅限于当前的函数内部。这意味着在函数外部无法访问该变量。
function local_demo {
  local myvar="Hello"
  echo ${myvar}
}


local_demo
echo "无法输出局部变量" ${myvar}


# 将当前工作目录切换到正在运行的脚本所在目录的父目录
function crtl_demo {
  local crtl
  crtl=$(
    cd -- "$(dirname "$0")" || exit 1
    pwd
  )

  echo ${crtl}
}

crtl_demo


function main() {
  echo "Hello, $1!"
}

main "$@"