#!/bin/bash

#-----------------------------------------------------------------------------
# author: other
# 脚本说明：主机信息.
#-----------------------------------------------------------------------------

#获取要监控的本地服务器 IP 地址
IP=`ifconfig|grepinet|grep-vE'inet6|127.0.0.1'|awk'{print$2}'`
echo"IP 地址："$IP

#获取 cpu 总核数
cpu_num=`grep-c"modelname"/proc/cpuinfo`
echo"cpu 总核数："$cpu_num

#1、获取 CPU 利用率
################################################
#us 用户空间占用 CPU 百分比
#sy 内核空间占用 CPU 百分比
#ni 用户进程空间内改变过优先级的进程占用 CPU 百分比
#id 空闲 CPU 百分比
#wa 等待输入输出的 CPU 时间百分比
#hi 硬件中断
#si 软件中断
#################################################
#获取用户空间占用 CPU 百分比
cpu_user=`top-b-n1|grepCpu|awk'{print$2}'|cut-f1-d"%"`
echo"用户空间占用 CPU 百分比："$cpu_user

#获取内核空间占用 CPU 百分比
cpu_system=`top-b-n1|grepCpu|awk'{print$4}'|cut-f1-d"%"`
echo"内核空间占用 CPU 百分比："$cpu_system

#获取空闲 CPU 百分比
cpu_idle=`top-b-n1|grepCpu|awk'{print$8}'|cut-f1-d"%"`
echo"空闲 CPU 百分比："$cpu_idle

#获取等待输入输出占 CPU 百分比
cpu_iowait=`top-b-n1|grepCpu|awk'{print$10}'|cut-f1-d"%"`
echo"等待输入输出占 CPU 百分比："$cpu_iowait

#2、获取 CPU 上下文切换和中断次数
#获取 CPU 中断次数
cpu_interrupt=`vmstat-n11|sed-n3p|awk'{print$11}'`
echo"CPU 中断次数："$cpu_interrupt

#获取 CPU 上下文切换次数
cpu_context_switch=`vmstat-n11|sed-n3p|awk'{print$12}'`
echo"CPU 上下文切换次数："$cpu_context_switch

#3、获取 CPU 负载信息
#获取 CPU15分钟前到现在的负载平均值
cpu_load_15min=`uptime|awk'{print$11}'|cut-f1-d','`
echo"CPU 15分钟前到现在的负载平均值："$cpu_load_15min

#获取 CPU5分钟前到现在的负载平均值
cpu_load_5min=`uptime|awk'{print$10}'|cut-f1-d','`
echo"CPU 5分钟前到现在的负载平均值："$cpu_load_5min

#获取 CPU1分钟前到现在的负载平均值
cpu_load_1min=`uptime|awk'{print$9}'|cut-f1-d','`
echo"CPU 1分钟前到现在的负载平均值："$cpu_load_1min

#获取任务队列(就绪状态等待的进程数)
cpu_task_length=`vmstat-n11|sed-n3p|awk'{print$1}'`
echo"CPU 任务队列长度："$cpu_task_length

#4、获取内存信息
#获取物理内存总量
mem_total=`free|grepMem|awk'{print$2}'`
echo"物理内存总量："$mem_total

#获取操作系统已使用内存总量
mem_sys_used=`free|grepMem|awk'{print$3}'`
echo"已使用内存总量(操作系统)："$mem_sys_used

#获取操作系统未使用内存总量
mem_sys_free=`free|grepMem|awk'{print$4}'`
echo"剩余内存总量(操作系统)："$mem_sys_free

#获取应用程序已使用的内存总量
mem_user_used=`free|sed-n3p|awk'{print$3}'`
echo"已使用内存总