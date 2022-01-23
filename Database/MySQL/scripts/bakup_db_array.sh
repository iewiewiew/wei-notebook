#! /bin/bash

# 进入数据库：mysql -h127.0.0.1 -uroot -proot

# 1.1 源数据库组 注：= 两边不要有空格
src_databasename=(dbname_a dbname_b)
# 1.2 目标数据库组
dst_databasename=(dbname_a dbname_b)

# 注：数组变量前要加！
for i in ${!src_databasename[@]}
do
    # 2.1 源数据库备份（带时间）注：正式使用时可注释掉，最好是在目录上加当天加日期，例：20201020
    mysqldump -h127.0.0.1 -uroot -proot ${src_databasename[$i]} | gzip > /deploy_demo/${src_databasename[$i]}_`date +%Y-%m-%d_%H:%M:%S`.sql.gz;
    echo "${src_databasename[$i]} 备份成功，路径：/tmp/${src_databasename[$i]}_`date +%Y-%m-%d_%H:%M:%S`.sql.gz"

    # 2.2 源数据库备份（不带时间）
    mysqldump -h127.0.0.1 -uroot -proot ${src_databasename[$i]} | gzip > /deploy_demo/${src_databasename[$i]}.sql.gz;
    echo "${src_databasename[$i]} 备份成功，路径：/tmp/${src_databasename[$i]}.sql.gz"

    # 3 解压数据库并还原
    gunzip < /deploy_demo/${src_databasename[$i]}.sql.gz | mysql -h127.0.0.1 -uroot -proot ${src_databasename[$i]};
    echo "${src_databasename[$i]} 还原成功"
done