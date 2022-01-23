#!/bin/bash

#-----------------------------------------------------------------------------
# author: other
# 脚本说明：主机信息.
#-----------------------------------------------------------------------------

# shellcheck disable=SC2006
IP=`ifconfig eth0 | head -2 | tail -1 | awk '{print $2}' | awk -F":" '{print $2}'`
ZW=`ifconfig eth0 | head -2 | tail -1 | awk '{print $3}' | awk -F":" '{print $2}'`
GW=`route -n | tail -1 | awk '{print $2}'`
HN=`hostname`
DNS=`head -1 /etc/resolv.conf | awk '{print $2}'`

echo '此机 IP 地址是' $IP
echo '此机子网掩码是' $ZW
echo '此机网关是' $GW
echo '此机主机名是' $HN
echo '此机 DNS 是' $DNS

# 物理 CPU 个数
cat /proc/cpuinfo | grep 'physical id' | sort | uniq | wc -l
# 每个 CPU 核心数
cat /proc/cpuinfo | grep 'core id' | sort | uniq | wc -l
# 逻辑 CPU
cat /proc/cpuinfo | grep 'processor' | sort | uniq | wc -l
# mpstat
mpstat
mpstat 2 10