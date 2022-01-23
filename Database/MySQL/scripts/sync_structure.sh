#!/bin/bash

time1=$(date +%Y-%m-%d)
time2=$(date +%Y-%m-%d_%H:%M:%S)

# 注：数据库位置一定要对应！！！
src_dbname_list=(dbname_a dbname_b)
dst_dbname_list=(dbname_a dbname_b)

# 1、根据当天时间创建目录, -p：如果不存在该目录则创建
funA() {
  mkdir -p /deploy_demo/src_dbname/${time1}
  mkdir -p /deploy_demo/dst_dbname/${time1}
}

# 2、源数据库压缩备份
funB() {
  mysqldump -h127.0.0.1 -P3306 -uroot -ppassword -d ${src_dbname_list[$i]} | gzip >/deploy_demo/src_dbname/${time1}/${src_dbname_list[$i]}.sql.gz
  echo -e "\033[32m$time2  ${src_dbname_list[$i]} 源数据库结构压缩备份成功 路径：/tmp/src_dbname/${time1}/${src_dbname_list[$i]}.sql.gz\n\033[0m"
}

# 2、目标数据库备份+源数据库同步到目标数据库
funC() {
  mysqldump -h127.0.0.1 -P3306 -uroot -ppassword ${dst_dbname_list[$j]} | gzip >/deploy_demo/dst_dbname/${time1}/${dst_dbname_list[$j]}.sql.gz
  echo -e "\033[32m$time2  ${dst_dbname_list[$j]} 目标数据库压缩备份成功 路径：/tmp/dst_dbname/${time1}/${dst_dbname_list[$j]}.sql.gz\n\033[0m"

  gunzip </deploy_demo/src_dbname/${time1}/${src_dbname_list[$i]}.sql.gz | mysql -uroot -ppassword ${dst_dbname_list[$j]}
  echo -e "\033[32m$time2  ${src_dbname_list[$i]} to ${dst_dbname_list[$j]} 数据结构同步成功\n\033[0m"
}

for i in ${!src_dbname_list[@]}; do
  funA
  funB
  for j in ${!dst_dbname_list[@]}; do
    # $i -eq $j ：表示参数 i 和参数 j 的位置相同, 注：数据库位置一定要对应！！！
    if [ $i -eq $j ]; then
      funC
    fi
  done
done
