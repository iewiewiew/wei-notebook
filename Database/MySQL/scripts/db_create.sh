#! /bin/bash


#批量创建数据库，用户，分配权限
dbname_list=(dbname_a dbname_b)

# 注：数组变量前要加！
for i in ${!dbname_list[@]}; do
  mysql -h127.0.0.1 -uroot -ppassword <<EOF
  create database demo_${i} DEFAULT CHARACTER SET utf8mb4;
  grant all on demo_${i}.* to 'demo_${i}'@'%' identified by '${i}#password';
  grant select, update, insert, delete on dbname.* to 'demo_${i}'@'%';
  flush privileges;
EOF
done
