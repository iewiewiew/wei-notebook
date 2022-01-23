#!/bin/bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：输出时间.
#-----------------------------------------------------------------------------

timestamp=$(date -d "$historyTime" +%s)
echo "时间戳：${timestamp}"

date_this_month=`date +%Y%m01`
echo "本月一月一日: ${date_this_month}"

last_month=$(date "+%Y-%m-%d %H" -d "1 month ago")
echo "一月前：${last_month}"

last_weekend=$(date "+%Y-%m-%d %H" -d "7 day ago")
echo "一周前：${last_weekend}"

last_day=`date -d "1 day ago" +%Y%m%d`
echo "一天前：${last_day}"

last_hour=$(date "+%Y-%m-%d %H" -d "-1 hours")
echo "一小时前:${last_hour}"

#获取月份
log_month=$(date -d yesterday +"%Y%m")
echo "昨天的月份：${log_month}"

#获取前一天日期 (第二天凌晨备份,即保存的日志就是当天时间的日志)
log_day=$(date -d yesterday +"%d")
echo "昨天的日期：${log_day}"
