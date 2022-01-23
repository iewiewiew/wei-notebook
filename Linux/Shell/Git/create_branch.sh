#!/bin/zsh

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：创建分支
#-----------------------------------------------------------------------------

time=$(date +%Y%m%d%H%M%S)

function branch() {
    # shellcheck disable=SC1060
    for j in {1..1} ; do
      for i in {1..10} ; do
          echo "${j}_${i}_10条" > tmp.txt
          git add .
          git commit -m "${j}_${i}_10条_${time}"
          git branch branch_${i}
      done
      sleep 5
      git push -f https://gitqa:qwe123@master.runjs.cn/testent001/wei-demo-003.git
    done

#    git push -f origin master
#    git push --all https://gitqa:qwe123@master.runjs.cn/testent001/wei-demo-003.git
}

branch