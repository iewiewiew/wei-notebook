#!/bin/bash

#本脚本作用:部署项目

#sh /root/data/${comp}-${codeName}/aut_deploy.sh ${codeName} ${target} ${ENV} ${comp}
#sh /root/data/${comp}-${codeName}/aut_deploy.sh aut core test1 fb

#部署流程(core 和oms 流程一致)：
#1、解压从 Jenkins 发送到/root/data 目录下的压缩包:xxx-core.tar.gz、xxx-oms.war
#2、检查解压命令是否执行成功(shell_check),如果执行失败直接退出
#3、停止服务
#4、覆盖代码
#5、拉取 disconf(core_disconf、oms_disconf)
#6、检查拉取 disconf 是否成功(shell_check),如果执行失败直接退出
#7、/app/${comp}-${codeName} 分组(chown_codeName)
#8、重启服务
#9、检查重启命令是否执行成功(shell_check),如果执行失败直接退出
#10、检查服务是否有进程(core_pid_check、oms_pid_check),如果无进程直接退出
#11、查看启动日志(core_query_log、oms_query_log)
#12、删除/root/data 目录下旧压缩包(del_old_codeName),避免再次部署代码重复

codeName=${1}  #项目名称,例:aut
Target=${2}    #模块名称,例:oms
ENV=${3}       #环境名称,例:test1
comp=${4}      #名称前缀,例:fb 或者 jly
time=`date +%Y-%m-%d_%H:%M:%S`  #时间

#生产 disconf 地址
if [[ ${ENV} = pro* ]];then
    disconfName=disconf.demo.com
#非生产 disconf 地址
elif  [[ ${ENV} = dev* ]] || [[ ${ENV} = comb ]] || [[ ${ENV} = test1 ]] || [[ ${ENV} = test2 ]] || [[ ${ENV} = uat ]];then
    disconfName=disconfdev.demo.com
else
    echo -e "\033[31m${time} 请输入正确参数!\033[0m"
    exit 1
fi

#2、检查解压命令是否执行成功
#6、检查拉取 disconf 命令是否执行成功
#9、检查重启命令是否执行成功
shell_check(){
    if [ $? -eq 0 ];then
        echo -e "\033[32m${time} 2|6|9、上一条命令（2、解压压缩包|6、拉取 disconf|9、重启服务）执行成功,继续\033[0m"
    else
        echo -e "\033[31m${time} 2|6|9、上一条命令（2、解压压缩包|6、拉取 disconf|9、重启服务）执行失败,执行：del_old_codeName ${codeName}结束后退出===
排查方案：
1、请检查 maven 打包是否正常
2、前往服务器：cdlog ${codeName} core/oms slog 或者 cdlog jly ${codeName} core/oms slog 查看启动日志,一般错误原因如下：
   2.1、表结构没有同步
   2.2、disconf 没有配置 dubbo 组
   2.3、用 root 权限在服务器上重启应用,导致某些文件所属用户变成 root,普通用户无法读取
   2.4、没接 disconf/disconf 没有配置文件/disconf 数据库 app 表name 字段带空格
3、如果启动失败的原因是 disconf 配置错误,前往 http://${disconfName} 配置正确后，在服务器上执行：cdlog ${codeName} core/oms start 或者 cdlog jly ${codeName} core/oms start 即可重启
4、注:单独部署 core 或者 oms 失败都会执行查看 core 和oms 的日志,如果无法查看启动日志,报错请忽略,请直接到服务器查看\033[0m"

        del_old_codeName ${codeName}
        core_query_log
        oms_query_log
        exit 1
    fi
}


#5、拉取 disconf
core_disconf(){
    echo -e "\033[32m${time} 5、从 disconf 拉取${codeName}的配置文件(注：aut 的core 和oms 都用 tomcat 启动，aut 的core 和oms 都只有一个配置)\033[0m"
    if [[ ${comp} = "fb" ]]; then
       cd /app/${comp}-${codeName}/tomcat/webapps/${codeName}-core/WEB-INF/classes && wget -O configs.tar.gz http://${disconfName}/api/config/downConfigs?app=fb-${codeName}-oms'&'env=${ENV}'&'version=1.0.0 && tar -xvf configs.tar.gz && rm -rf configs.tar.gz
    elif [[ ${comp} = "jly" ]]; then
       cd /app/${comp}-${codeName}/tomcat/webapps/${codeName}-core/WEB-INF/classes && wget -O configs.tar.gz http://${disconfName}/api/config/downConfigs?app=jly-${codeName}-oms'&'env=${ENV}'&'version=1.0.0 && tar -xvf configs.tar.gz && rm -rf configs.tar.gz
    else
        echo -e "\033[31m${time} 请输入正确参数!\033[0m"
    fi
}


#5、拉取 disconf
oms_disconf(){
    echo -e "\033[32m${time} 5、从 disconf 拉取${codeName}的配置文件(注：aut 的core 和oms 都用 tomcat 启动，aut 的core 和oms 都只有一个配置)\033[0m"
    if [[ ${comp} = "fb" ]]; then
       cd /app/${comp}-${codeName}/tomcat/webapps/${codeName}-oms/WEB-INF/classes && wget -O configs.tar.gz http://${disconfName}/api/config/downConfigs?app=fb-${codeName}-oms'&'env=${ENV}'&'version=1.0.0 && tar -xvf configs.tar.gz && rm -rf configs.tar.gz
    elif [[ ${comp} = "jly" ]]; then
       cd /app/${comp}-${codeName}/tomcat/webapps/${codeName}-oms/WEB-INF/classes && wget -O configs.tar.gz http://${disconfName}/api/config/downConfigs?app=jly-${codeName}-oms'&'env=${ENV}'&'version=1.0.0 && tar -xvf configs.tar.gz && rm -rf configs.tar.gz
    else
        echo -e "\033[31m${time} 请输入正确参数!\033[0m"
    fi
}

#7、/app/${comp}-${codeName} 分组
chown_codeName(){
    echo -e "\033[32m${time} 7、分组：cd /app && chown -R ${comp}-${codeName}:coreapp ${comp}-${codeName}\033[0m"
    cd /app && chown -R ${comp}-${codeName}:coreapp ${comp}-${codeName}
}

#10、检查服务是否有进程
core_pid_check(){
    pid=`ps aux | grep ${comp}-${codeName} | grep tomcat | grep -v grep | awk '{print $2}'`
    if [ "${pid}" ]; then
        echo -e "\033[32m${time} 10、${comp}-${codeName} core ${pid} 启动成功\033[0m"
    else
        echo -e "\033[31m${time} 10、${comp}-${codeName} core ${pid} 启动失败\033[0m"
        exit 1
    fi
}

#10、检查服务是否有进程
oms_pid_check(){
    pid=`ps aux | grep ${comp}-${codeName} | grep tomcat | grep -v grep | awk '{print $2}'`
    if [ "${pid}" ]; then
        echo -e "\033[32m${time} 10、${comp}-${codeName} oms ${pid} 启动成功\033[0m"
    else
        echo -e "\033[31m${time} 10、${comp}-${codeName} oms ${pid} 启动失败\033[0m"
        exit 1
    fi
}

#11、查看启动日志
core_query_log(){
    if [[ ${comp} = "fb" ]];then
        echo -e "\n\033[44;37m${time} 11、${codeName}-core 的启动日志开始,注:日志可能有延迟,以服务器上最新日志为准,查看启动日志：cdlog ${codeName} oms slog (注：aut 的core 和oms 都用 tomcat 启动)\033[0m\n"
    elif [[ ${comp} = "jly" ]];then
        echo -e "\n\033[44;37m${time} 11、${codeName}-core 的启动日志开始,注:日志可能有延迟,以服务器上最新日志为准,查看启动日志：cdlog jly ${codeName} oms slog (注：aut 的core 和oms 都用 tomcat 启动)\033[0m\n"
    fi
    sleep 38s
    cd /app/${comp}-${codeName}/tomcat/logs && tail -n 200 catalina.out
    sleep 2s
    if [[ ${comp} = "fb" ]];then
        echo -e "\n\033[44;37m${time} 11、${codeName}-core 的启动日志结束,注:日志可能有延迟,以服务器上最新日志为准,查看启动日志：cdlog ${codeName} oms slog (注：aut 的core 和oms 都用 tomcat 启动)\033[0m\n"
    elif [[ ${comp} = "jly" ]];then
        echo -e "\n\033[44;37m${time} 11、${codeName}-core 的启动日志结束,注:日志可能有延迟,以服务器上最新日志为准,查看启动日志：cdlog jly ${codeName} oms slog (注：aut 的core 和oms 都用 tomcat 启动)\033[0m\n"
    fi
}

#11、查看启动日志
oms_query_log(){
    if [[ ${comp} = "fb" ]];then
        echo -e "\n\033[44;37m${time} 11、${codeName}-oms 的启动日志开始,注:日志可能有延迟,以服务器上最新日志为准,查看启动日志：cdlog ${codeName} oms slog (注：aut 的core 和oms 都用 tomcat 启动)\033[0m\n"
    elif [[ ${comp} = "jly" ]];then
        echo -e "\n\033[44;37m${time} 11、${codeName}-oms 的启动日志开始,注:日志可能有延迟,以服务器上最新日志为准,查看启动日志：cdlog jly ${codeName} oms slog (注：aut 的core 和oms 都用 tomcat 启动)\033[0m\n"
    fi
    sleep 38s
    cd /app/${comp}-${codeName}/tomcat/logs && tail -n 200 catalina.out
    sleep 2s
    if [[ ${comp} = "fb" ]];then
        echo -e "\n\033[44;37m${time} 11、${codeName}-oms 的启动日志结束,注:日志可能有延迟,以服务器上最新日志为准,查看启动日志：cdlog ${codeName} oms slog (注：aut 的core 和oms 都用 tomcat 启动)\033[0m\n"
    elif [[ ${comp} = "jly" ]];then
        echo -e "\n\033[44;37m${time} 11、${codeName}-oms 的启动日志结束,注:日志可能有延迟,以服务器上最新日志为准,查看启动日志：cdlog jly ${codeName} oms slog (注：aut 的core 和oms 都用 tomcat 启动)\033[0m\n"
    fi
}

#12、删除/root/data 目录下旧压缩包
del_old_codeName(){
    echo -e "\033[32m${time} 12、删除${comp}-${codeName}：cd /root/data && rm -rf ${comp}-${codeName},避免再次部署代码重复\033[0m"
    cd /root/data && rm -rf ${comp}-${codeName}
}

#部署 core 服务
deploy_core(){

    echo -e "\033[32m${time} 1、解压${codeName}-core.war：cd /root/data/${comp}-${codeName}/${codeName}-core/target/ && mkdir ${codeName}-core && unzip -oq ${codeName}-core.war -d ${codeName}-core\033[0m"
    cd /root/data/${comp}-${codeName}/${codeName}-core/target/ && mkdir ${codeName}-core && unzip -oq ${codeName}-core.war -d ${codeName}-core

    shell_check

    echo -e "\033[32m${time} 3、停止${comp}-${codeName} core 服务：cd /app/${comp}-${codeName}/tomcat/ && su ${comp}-${codeName} ${comp}-${codeName}.sh stop\033[0m"
    cd /app/${comp}-${codeName}/tomcat/ && su ${comp}-${codeName} ${comp}-${codeName}.sh stop

    echo -e "\033[32m${time} 4、rsync -r --delete /root/data/${comp}-${codeName}/${codeName}-core/target/${codeName}-core/ /app/${comp}-${codeName}/tomcat/webapps/${codeName}-core\033[0m"
    rsync -r --delete /root/data/${comp}-${codeName}/${codeName}-core/target/${codeName}-core/ /app/${comp}-${codeName}/tomcat/webapps/${codeName}-core

    core_disconf

    shell_check

    chown_codeName

    echo -e "\033[32m${time} 8、重启${codeName}：cd /app/${comp}-${codeName}/tomcat/ && su ${comp}-${codeName} ${comp}-${codeName}.sh start\033[0m"
    cd /app/${comp}-${codeName}/tomcat/ && su ${comp}-${codeName} ${comp}-${codeName}.sh start

    shell_check

    core_pid_check

    core_query_log

}

#部署 oms 服务
deploy_oms(){

    echo -e "\033[32m${time} 1、解压${codeName}-oms.war：cd /root/data/${comp}-${codeName}/${codeName}-oms/target/ && mkdir ${codeName}-oms && unzip -oq ${codeName}-oms.war -d ${codeName}-oms\033[0m"
    cd /root/data/${comp}-${codeName}/${codeName}-oms/target/ && mkdir ${codeName}-oms && unzip -oq ${codeName}-oms.war -d ${codeName}-oms

    shell_check

    echo -e "\033[32m${time} 3、停止${comp}-${codeName} oms 服务：cd /app/${comp}-${codeName}/tomcat/ && su ${comp}-${codeName} ${comp}-${codeName}.sh stop\033[0m"
    cd /app/${comp}-${codeName}/tomcat/ && su ${comp}-${codeName} ${comp}-${codeName}.sh stop

    echo -e "\033[32m${time} 4.1、cd /app/${comp}-${codeName}/tomcat/webapps && rm -rf ${codeName}-oms\033[0m"
    echo -e "\033[32m${time} 4.2、rsync -r --delete /root/data/${comp}-${codeName}/${codeName}-oms/target/${codeName}-oms/ /app/${codeName}-${codeName}/tomcat/webapps/${codeName}-oms --exclude=WEB-INF/classes/default.properties\033[0m"
    cd /app/${comp}-${codeName}/tomcat/webapps && rm -rf ${codeName}-oms
    rsync -r --delete /root/data/${comp}-${codeName}/${codeName}-oms/target/${codeName}-oms/ /app/${comp}-${codeName}/tomcat/webapps/${codeName}-oms --exclude=WEB-INF/classes/default.properties

    oms_disconf

    shell_check

    chown_codeName

    echo -e "\033[32m${time} 8、重启${codeName}-oms：cd /app/${comp}-${codeName}/tomcat/ && su ${comp}-${codeName} ${comp}-${codeName}.sh start\033[0m"
    cd /app/${comp}-${codeName}/tomcat/ && su ${comp}-${codeName} ${comp}-${codeName}.sh start

    shell_check

    oms_pid_check

    oms_query_log

}

#============部署流程============
if [[ ${Target} = core ]];then
    deploy_core
    del_old_codeName
elif [[ ${Target} = oms ]];then
    deploy_oms
    del_old_codeName
elif [[ ${Target} = omscore ]];then
    deploy_core
    echo -e "\n\033[32m${time} ===部署 core 完成，开始部署 oms===\033[0m\n"
    deploy_oms
    del_old_codeName
else
    echo -e "\033[31m${time} 请输入正确参数!\033[0m"
    exit 1
fi