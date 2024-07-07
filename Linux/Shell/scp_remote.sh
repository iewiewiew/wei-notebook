#!/bin/bash

time=$(date +%Y-%m-%d_%H:%M:%S)

function usage() {
    echo -e "\033[32m复制本地文件到远程示例: scpr lr scp_remote.sh\033[0m"
    echo -e "\033[32m复制远程文件到本地示例: scpr rl scp_remote.sh\033[0m"
}

function scpr() {
    if [ "$1" == "lr" ]; then
        local_file="$2"
        echo -e "\033[32mscp -r '$(pwd)/$local_file' root@114.67.240.27:/root/\033[0m"
        scp -r "$(pwd)/$local_file" root@114.67.240.27:/root/
    elif [ "$1" == "rl" ]; then
        remote_file="$2"
        echo -e "\033[32mscp -r root@114.67.240.27:/root/'$remote_file' '$(pwd)/'\033[0m"
        scp -r root@114.67.240.27:/root/"$remote_file" "$(pwd)/"
    else
        usage
        exit 1
    fi
}

# 检查参数数量
if [ $# -ne 2 ]; then
    usage
    exit 1
fi


# 调用文件复制函数
scpr "$1" "$2"