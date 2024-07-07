#!/bin/bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明: 清除缓存
#-----------------------------------------------------------------------------

sync
echo 1 > /proc/sys/vm/drop_caches
echo 2 > /proc/sys/vm/drop_caches
echo 3 > /proc/sys/vm/drop_caches

docker system prune -f
docker container prune --force
docker volume prune --force
docker rm $(docker ps -qf status=exited) 2>/dev/null || echo "No exited containers to remove"
