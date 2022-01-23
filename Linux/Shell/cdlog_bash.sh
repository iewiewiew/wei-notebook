#!/bin/bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：
# demo：alias cd='func() {cd /app; ls;}; func'
# cd /etc/profile.d,把 cdlog_bash.sh 放上去,source cdlog_bash.sh,
# 查看是否成功写入:alias,然后输入 cdlog,看到有一些提示就表示成功了.
#-----------------------------------------------------------------------------

alias cdlog='func() {

fun_cdlog(){
    #进入对应的 log 目录
    if [[ ${module} = core && ! ${log} ]];then
        cd /app/${comp}-${codeName}/jetty/${codeName}-${module}/logs/${codeName}-${module} && ll;
    elif [[ ${module} = oms && ! ${log} ]];then
        cd /app/${comp}-${codeName}/tomcat/logs/${codeName}-${module} && ll;
    elif [[ ${codeName} = wcs && ! ${module} && ! ${log} ]];then
        cd /app/${comp}-${codeName}/python/logs &&  ll;

    #进入对应的启动项目的目录
    elif [[ ${module} = core && ${log} = sdir ]];then
        cd /app/${comp}-${codeName}/jetty/${codeName}-core/bin && ll;
    elif [[ ${module} = oms && ${log} = sdir ]];then
        cd /app/${comp}-${codeName}/tomcat && ll;
    elif [[ ${codeName} = wcs && ${log} = sdir ]];then
        cd /app/${comp}-${codeName}/python && ll;

    #查看 log 的日志
    elif [[ ${module} = core && ${log} = log ]];then
        cd /app/${comp}-${codeName}/jetty/${codeName}-core/logs/${codeName}-${module}; tail -f -n 500 ${codeName}-${module}.log
    elif [[ ${module} = oms && ${log} = log ]];then
        cd /app/${comp}-${codeName}/tomcat/logs/${codeName}-${module}; tail -f -n 500 ${codeName}-${module}.log
    elif [[ ${codeName} = wcs && ${module} = log ]];then
        cd /app/${comp}-${codeName}/python/logs; tail -f -n 500 spdier.log
    elif [[ ${codeName} = wcs && ${module} = log1 ]];then
        cd /app/${comp}-${codeName}/python/logs1; tail -f -n 500 spdier.log
    elif [[ ${codeName} = wcs && ${module} = log2 ]];then
        cd /app/${comp}-${codeName}/python/logs2; tail -f -n 500 spdier.log

    #查看启动的日志
    elif [[ ${module} = core && ${log} = slog ]];then
        cd /app/${comp}-${codeName}/jetty/${codeName}-core/logs; tail -f -n 500 stdout.log
    elif [[ ${module} = oms && ${log} = slog ]];then
        cd /app/${comp}-${codeName}/tomcat/logs; tail -f -n 500 catalina.out

    #查看 err 的日志
    elif [[ ${module} = core && ${log} = err ]];then
        cd /app/${comp}-${codeName}/jetty/${codeName}-core/logs/${codeName}-${module}; tail -f -n 500 ${codeName}-${module}_err.log
    elif [[ ${module} = oms && ${log} = err ]];then
        cd /app/${comp}-${codeName}/tomcat/logs/${codeName}-${module}; tail -f -n 500 ${codeName}-${module}_err.log

    #grep 命令查看日志
    elif [[ ${module} = core && ${log} = grep ]];then
        cd /app/${comp}-${codeName}/jetty/${codeName}-core/logs/${codeName}-${module}; more ${codeName}-${module}.log | grep ${cont}
    elif [[ ${module} = oms && ${log} = grep ]];then
        cd /app/${comp}-${codeName}/tomcat/logs/${codeName}-${module}; more ${codeName}-${module}.log | grep ${cont}

    #启动 core 或者 oms
    elif [[ ${module} = core && ${log} = start ]];then
        cd /app/${comp}-${codeName}/jetty/${codeName}-core/bin; su ${comp}-${codeName} -s /bin/bash stop.sh; su ${comp}-${codeName} -s /bin/bash start.sh
    elif [[ ${module} = oms && ${log} = start ]];then
        cd /app/${comp}-${codeName}/tomcat; su ${comp}-${codeName} ${comp}-${codeName}.sh stop; su ${comp}-${codeName} ${comp}-${codeName}.sh start

    #停止 core 或者 oms
    elif [[ ${module} = core && ${log} = stop ]];then
        cd /app/${comp}-${codeName}/jetty/${codeName}-core/bin; su ${comp}-${codeName} -s /bin/bash stop.sh
    elif [[ ${module} = oms && ${log} = stop ]];then
        cd /app/${comp}-${codeName}/tomcat; su ${comp}-${codeName} ${comp}-${codeName}.sh stop

    #查看进程
    elif [[ ${log} = ps ]];then
        ps -ef|grep ${comp}-${codeName}

    else
        echo -e "\033[32m 请输入正确参数！(以 eam-core 为例子,oms 同理)\n \
1、进入 eam-core 日志目录：cdlog eam core\n \
2、进入 eam-core 启动目录：cdlog eam core sdir\n \
3、查看 eam-core.log：cdlog eam core log\n \
4、查看 stdout.log：cdlog eam core slog\n \
5、查看 eam-core_err.log：cdlog eam core err\n \
6、grep '关键字'查看 eam-core.log：cdlog eam core grep xxx\n \
7、启动 core：cdlog eam core start\n \
8、停止 core：cdlog eam core stop\n \
9、查看进程：cdlog eam ps\n \
10、如果是 jly 项目,请在 cdlog 后面加 jly,例子同上\033[0m"
    fi
}

if [[  $1 = jly && $2 != ps && $3 != ps ]];then
    comp=$1
    codeName=$2
    module=$3
    log=$4
    cont=$5
    fun_cdlog ${comp} ${codeName} ${module} ${log} ${cont}
elif [[ $1 = jly && $2 != ps && $3 = ps ]];then
    comp=$1
    codeName=$2
    log=$3
    fun_cdlog ${comp} ${codeName} ${log}
elif [[ $1 != jly && $2 != ps ]];then
    comp=fb
    codeName=$1
    module=$2
    log=$3
    cont=$4
    fun_cdlog ${comp} ${codeName} ${module} ${log} ${cont}
elif [[ $1 != jly && $2 = ps ]];then
    comp=fb
    codeName=$1
    log=$2
    fun_cdlog ${comp} ${codeName} ${log}
else
    echo "请输入正确参数！"
fi

}; func'