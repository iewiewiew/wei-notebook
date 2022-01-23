#!/bin/zsh

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：创建标签
#-----------------------------------------------------------------------------


time=$(date +%Y%m%d%H%M%S)

function tag() {
    # shellcheck disable=SC1060
    for i in {1..5} ; do
        echo "tag_${i}_${time}" >> tmp.txt
        git add .
        git commit -m "tag_${i}_${time}"
        git tag tag_${i}
    done

    git push --tags
}


tag