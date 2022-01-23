#! /bin/bash

#进入容器 kubectl exec -it mysql-master -- sh

#备份
mysqldump -hmysql-master -P3306 -uroot -proot --set-gtid-purged=off --single-transaction --no-autocommit --master-data=2 -A > /var/lib/mysql/mysql-data.sql

#恢复
mysql -hmysql-master -P3306 -uroot -proot < /var/lib/mysql/mysql-data.sql