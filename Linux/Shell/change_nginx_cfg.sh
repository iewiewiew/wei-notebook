#!/usr/bin/env bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：批量替换 Nginx 的vhost 目录下的文件内容.
#-----------------------------------------------------------------------------

cd /tmp/nginx/conf/vhost/
# 注：不能用 ll，只能用 ls；获取 vhost_list 目录下所有文件
vhost_list=$(ls -d *)

for i in ${!vhost_list[@]}; do
  sed -i "s/$1/$2/g" ${vhost_list[$i]}
done
