#!/bin/bash


#!/bin/bash
host_name=("127.0.0.1" "127.0.0.2")

# $1: 文件的绝对路径
sync() {
    for ip in ${host_name[*]}; do
        rsync -auz -e 'ssh -p 22' $1 root@${ip}:/tmp
    done
}
sync