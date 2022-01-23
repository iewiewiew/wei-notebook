#--server1：MySQL 服务器1配置。
#--server2：MySQL 服务器2配置。如果是同一服务器，--server2可以省略。
#db1:db2：要比较的两个数据库。如果比较不同服务器上的同名数据库，可以省略:db2。
#--all：比较所有两服务器上所有的同名数据库。--exclude 排除无需比较的数据库。
#--run-all-tests：运行完整比较，遇到第一次差异时不停止。
#--changes-for=：修改对象。例如--changes-for=server2，那么对比以 sever1为主，生成的差异的修改也是针对 server2的对象的修改。
#-d DIFFTYPE,--difftype=DIFFTYPE：差异的信息显示的方式，有[unified|context|differ|sql]，默认是 unified。如果使用 sql，那么就直接生成差异的 SQL，这样非常方便。
#--show-reverse：在生成的差异修改里面，同时会包含 server2和 server1的修改。
#--skip-table-options：保持表的选项不变，即对比的差异里面不包括表名、AUTO_INCREMENT、ENGINE、CHARSET 等差异。
#--skip-diff：跳过对象定义比较检查。所谓对象定义，就是 CREATE 语句()里面的部分，--skip-table-options 是()外面的部分。
#--skip-object-compare：默认情况下，先检查两个数据库中相互缺失的对象，再对都存在对象间的差异。这个参数的作用就是，跳过第一步，不检查相互缺失的对象。
#--skip-checksum-table：数据一致性验证时跳过 CHECKSUM TABLE。
#--skip-data-check：跳过数据一致性验证。
#--skip-row-count：跳过字段数量检查。

#源命令
mysqldiff --server1=user:pass@host:port:socket --server2=user:pass@host:port:socket db1.object1:db2.object1 db3:db4

time=`date +%Y%m%d%H%M%S`
#修改左边的数据库,即修改 dbdemo2, dbdemo2:dbdemo
mysqldiff --server1=root:password@localhost:3306 --difftype=sql dbdemo2:dbdemo --changes-for=server1 --show-reverse > /tmp/mysql/demo_`date +%Y%m%d%H%M%S`.sql;
mysqldiff --server1=root:password@localhost:3306 --difftype=sql dbdemo2:dbdemo --changes-for=server1 --force > /tmp/mysql/demo.sql;