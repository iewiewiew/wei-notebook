#!/bin/bash

#-----------------------------------------------------------------------------
# author: other
# 脚本说明：生成10个随机数保存于数组中并找出其最大值和最小值.
#-----------------------------------------------------------------------------

declare -i min max
declare -a nums
for ((i=0;i<10;i++));do
    nums[$i]=$RANDOM
    [ $i -eq 0 ] && min=${nums[0]} &&  max=${nums[0]}&& continue
    [ ${nums[$i]} -gt $max ] && max=${nums[$i]}
    [ ${nums[$i]} -lt $min ] && min=${nums[$i]}
done
echo "All numbers are ${nums[*]}"
echo Max is $max
echo Min is $min