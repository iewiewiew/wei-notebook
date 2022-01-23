#1、进入 mysql 容器
docker exec -it <容器 ID> /bin/bash
#2、进入 mysql 数据库 注：特殊字符如！需加\转义,举例：Aa\!123qwe
mysql -127.0.0.1 -uroot -ppassword
#3、查看数据库
show databases;
#4、切换数据库
use metersphere;
#5、查看表
show tables;

#docker IP：127.0.0.1, 如果在数据库所在机器执行,可以不指定-h IP
#导出表数据--不指定 IP+压缩
mysqldump -uroot -ppassword metersphere | gzip > /tmp/metersphere_bak.sql.gz;

#导出表数据--指定 IP+压缩
mysqldump -h127.0.0.1 -uroot -ppassword metersphere | gzip > /tmp/metersphere_bak.sql.gz;

#导出表数据--指定 IP+压缩+时间
mysqldump -h127.0.0.1 -uroot -ppassword metersphere | gzip > /tmp/metersphere_bak_`date +%Y-%m-%d_%H:%M:%S`.sql.gz;

#备份数据库--设置最大缓冲区(临时性, 永久性得修改 my.cnf 并且重启 mysql)
mysqldump -uroot -ppassword --max_allowed_packet=128M -B metersphere > /tmp/metersphere_bak.sql;

#根据表前缀导出数据
mysqldump -uroot -ppassword metersphere $(mysql -uroot -ppassword metersphere -Bse "show tables like 'user_%'") > /tmp/metersphere_user_bak.sql;

#将容器<容器 ID>的/tmp/metersphere_bak.sql 文件拷贝到宿主机的/tmp/wmh 目录下
docker cp <容器 ID>:/tmp/metersphere_bak.sql /tmp/wmh

#将宿主机/tmp/wmh/metersphere_bak.sql 目录拷贝到容器<容器 ID>的/tmp 目录下
docker cp /tmp/wmh/metersphere_bak.sql <容器 ID>:/tmp;

#进入容器，在容器进行数据库还原
mysql -uroot -ppassword metersphere < /tmp/metersphere_bak.sql;