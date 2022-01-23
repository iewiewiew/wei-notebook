#!/bin/bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：字符串排序
#-----------------------------------------------------------------------------

#arr="ccc
#     aaa
#     bbb
#     abc
#     def"

arr="config
     init
     add
     rm
     commit
     clone
     fetch
     pull
     push
     checkout
     cherry-pick
     branch
     tag
     remote
     status
     stash
     reset
     revert
     diff
     show
     log
     gc
     submodule
     subtree
     bundle
     clean
     other
"


arr_sort(){
  #tr 将子字符串中的空白转换为换行符, 再用 sort 排序, 按 ASCII 正向排序, -r 参数:  按 ASCII 码反向排序
  array=(`echo ${arr} | tr ' ' '\n' | sort` )

  for ((i=0; i<${#array[@]}; i++)); do
    seq=`expr $i + 1`
    echo ${seq}". "${array[i]}
#    echo ${array[i]}
  done
}

arr_sort