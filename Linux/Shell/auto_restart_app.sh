#!/bin/bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：
# comb,dev,test1,test2环境：9点到21点,周一到周五,每隔1小时执行一次检测系统服务
# (app+dubboadmin)是否存在,如果不存在则重启,并进行钉钉通知;
#
# dev 环境：9点到21点,周一到周五,每隔1小时执行一次检测 disconf 服务是否存在,
# 并进行钉钉通知（注：不做自动重启，请先去排查问题）
#-----------------------------------------------------------------------------

time=`date +%Y-%m-%d_%H:%M:%S`

#jly 一般项目
normal_jly_app_list=(demo1)
#jly 只用 tomca 启动的项目
oms_jly_app_list=(demo2)
#fb 一般项目
normal_fb_app_list=(demo3)
#fb 只用 tomcat 启动的项目
oms_fb_app_list=(demo4)

#1.1、检查 core 服务
check_service_core(){
    j=0
    for i in `seq 1 3`
    do
        pid=`ps aux | grep ${comp}-${app} | grep jetty | grep -v grep | awk '{print $2}'`;
        if [ "${pid}" ]; then
            echo -e "\033[32m${time} ${comp}-${app} core 进程存在\033[0m";
            break;
        else
            j=$[$j+1]
            echo -e "\033[31m${time} 第${j}次检测,${comp}-${app} core 进程不存在\033[0m"
        fi
        #检测3次服务仍不存在
        if [ $j -eq 3 ];then
            echo -e "\033[31m${time} ${comp}-${app} core 进程不存在,即将启动项目\033[0m"
            start_core
            module=core
            ding_talk
        fi
        #每隔20s 检测一次
        sleep 20s
    done
}

#1.2、检查 oms 服务
check_service_oms(){
    j=0
    for i in `seq 1 3`
    do
        pid=`ps aux | grep ${comp}-${app} | grep tomcat | grep -v grep | awk '{print $2}'`;
        if [ "${pid}" ]; then
            echo -e "\033[32m${time} ${comp}-${app} oms 进程存在\033[0m\n";
            break;
        else
            j=$[$j+1]
            echo -e "\033[31m${time} 第${j}次检测,${comp}-${app} oms 进程不存在\033[0m\n"
        fi
        #检测3次服务仍不存在
        if [ $j -eq 3 ];then
            echo -e "\033[31m${time} ${comp}-${app} oms 进程不存在,即将启动项目\033[0m"
            start_oms
            module=oms
            ding_talk
        fi
        #每隔20s 检测一次
        sleep 20s
    done
}

#2.1、启动 core 服务
start_core(){
    echo -e "\033[32m${time} ${comp}-${app} core 启动中...\033[0m"
    cd /app/${comp}-${app}/jetty/${app}-core/bin
    su ${comp}-${app} stop.sh
    su ${comp}-${app} start.sh
}

#2.2、启动 oms 服务
start_oms(){
    echo -e "\033[32m${time} ${comp}-${app} oms 启动中...\033[0m"
    cd /app/${comp}-${app}/tomcat
    su ${comp}-${app} ${comp}-${app}.sh stop
    su ${comp}-${app} ${comp}-${app}.sh start
}


#3、钉钉通知
ding_talk(){
    if [ $? -eq 0 ];then
        #有些系统存在假启动的情况,因此需要延迟120s 检测服务是否完全正常
        sleep 120s
        if [ ${module} = core ];then
            pid=`ps aux | grep ${comp}-${app} | grep jetty | grep -v grep | awk '{print $2}'`;
        elif [ ${module} = oms ];then
            pid=`ps aux | grep ${comp}-${app} | grep tomcat | grep -v grep | awk '{print $2}'`;
        else
           break;
        fi
        #content 里面的参数需要加 ''
        if [ "${pid}" ]; then
            echo -e "\033[32m${time} ${comp}-${app} ${module} 重启之后进程存在,即将发送钉钉通知\033[0m"
            curl 'https://oapi.dingtalk.com/robot/send?access_token=1234567890' \
            -H 'Content-Type: application/json' \
            -d '{"msgtype": "text",
            "text": {
                "content": "'${time}' '${HOSTNAME}' '${comp}'-'${app}' '${module}' 刚刚进行重启"
              }
            }'
        else
            echo -e "\033[31m${time} ${comp}-${app} ${module} 重启之后进程不存在,即将发送钉钉通知\033[0m\n"
            curl 'https://oapi.dingtalk.com/robot/send?access_token=1234567890' \
            -H 'Content-Type: application/json' \
            -d '{"msgtype": "text",
           "text": {
                "content": "'${time}' '${HOSTNAME}' '${comp}-${app}' '${module}' 重启之后进程不存在,请前往服务器进行排查"
             }
           }'
        fi

    else
        echo -e "\033[31m${time} ${comp}-${app} ${module} 重启失败,即将发送钉钉通知\033[0m\n"
        curl 'https://oapi.dingtalk.com/robot/send?access_token=1234567890' \
        -H 'Content-Type: application/json' \
        -d '{"msgtype": "text",
       "text": {
            "content": "'${time}' '${HOSTNAME}' '${comp}-${app}' '${module}' 刚刚重启失败,请前往服务器进行排查"
         }
       }'
    fi
}

#4、检查 dubboadmin 服务
check_dubboadmin(){
    #注:脚本用 HOSTNAME,但是在服务器上用小写 hostname
    pid=`ps aux | grep /app/tomcat-7.0 | grep tomcat | grep -v grep | awk '{print $2}'`;
    if [ "${pid}" ]; then
        echo -e "\033[32m${time} ${HOSTNAME} dubboadmin 进程存在\033[0m\n";
        break;
    else
        echo -e "\033[31m${time} ${HOSTNAME} dubboadmin 进程不存在\033[0m\n"
        cd /app/tomcat-7.0/bin && sh startup.sh
        curl 'https://oapi.dingtalk.com/robot/send?access_token=1234567890' \
        -H 'Content-Type: application/json' \
        -d '{"msgtype": "text",
        "text": {
            "content": "'${time}' '${HOSTNAME}' dubboadmin 刚刚进行重启"
         }
        }'
    fi
}

#5、检查 disconf 服务
check_disconf(){
#注:脚本用 HOSTNAME,但是在服务器上用小写 hostname
    if [[ ${HOSTNAME} = "dev-zdb-nginx" ]];then
        echo -e "\033[32m${time} ${HOSTNAME} dev 环境,检测 disconf 服务是否正常\033[0m"
    else
        echo -e "\033[32m${time} ${HOSTNAME} 非 dev 环境,无需检测 disconf 服务是否正常,退出\033[0m"
        exit 1;
    fi

    pid=`ps aux | grep fb-disconf | grep tomcat | grep -v grep | awk '{print $2}'`;
    if [ "${pid}" ]; then
        echo -e "\033[32m${time} fb-disconf 进程存在\033[0m\n";
        break;
    else
        echo -e "\033[31m${time} fb-disconf 进程不存在\033[0m\n"
        curl 'https://oapi.dingtalk.com/robot/send?access_token=1234567890' \
        -H 'Content-Type: application/json' \
        -d '{"msgtype": "text",
        "text": {
            "content": "'${time}' '${HOSTNAME}' fb-disconf 进程不存在,请前往服务器进行排查"
         }
        }'
    fi
}


for app in ${normal_jly_app_list[@]};
do
    comp=jly
    check_service_core
    check_service_oms
done

for app in ${oms_jly_app_list[@]};
do
    echo -e "\033[32m${time} ${comp}-${app} jly 只用 tomcat 启动\033[0m"
    comp=jly
    check_service_oms
done

for app in ${normal_fb_app_list[@]};
do
    comp=fb
    check_service_core
    check_service_oms
done

for app in ${oms_fb_app_list[@]};
do
    echo -e "\033[32m${time} ${comp}-${app} fb 只用 tomcat 启动\033[0m"
    comp=fb
    check_service_oms
done

check_dubboadmin

check_disconf