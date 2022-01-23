#!/bin/bash

#-----------------------------------------------------------------------------
# author: other
# 脚本说明: 监控 MySQL 主从同步状态是否异常脚本
#-----------------------------------------------------------------------------

HOST=localhost
USER=root
PASSWD=123.com
IO_SQL_STATUS=$(mysql -h$HOST -u$USER -p$PASSWD -e 'show slave status\G' 2>/dev/null |awk '/Slave_.*_Running:/{print $1$2}')
for i in $IO_SQL_STATUS; do
    THREAD_STATUS_NAME=${i%:*}
    THREAD_STATUS=${i#*:}
    if [ "$THREAD_STATUS" != "Yes" ]; then
        echo "Error: MySQL Master-Slave $THREAD_STATUS_NAME status is $THREAD_STATUS!" |mail -s "Master-Slave Staus" xxx@163.com
    fi
done