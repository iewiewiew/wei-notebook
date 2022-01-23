#!/bin/bash

#本脚本作用:前端编译+将部署脚本拷贝到对应 job 的工作空间

#生产
#sh /jenkins_workspace/fb-script-pro-zdb/app_build.sh ${codeName} ${groupName} ${ENV} ${Target}
#sh /jenkins_workspace/fb-script-pro-zdb/app_build.sh irs pro_base pro core/oms/omscore

#非生产
#sh /jenkins_workspace/fb-script-dev-zdb/app_build.sh ${codeName} ${groupName} ${ENV} ${Target}
#sh /jenkins_workspace/fb-script-dev-zdb/app_build.sh irs dev_base test1 core/oms/omscore

#特殊情况
#bss:无需前端编译,指定 jdk1.7,maven3.0,复制 deploy.sh 到${groupName}_${codeName},注:本脚本已指定 maven 和jdk 版本编译,部署 job 无需使用默认 maven 和jdk 构建,否则会报错
#sso,b2b-front,cb-front:无需前端编译,复制 deploy.sh 到${groupName}_${codeName}-oms
#aut:无需前端编译,复制 aut_deploy.sh 到${groupName}_${codeName}
#scheduler,mqx,etd,ecw:无需前端编译,复制 deploy.sh 到${groupName}_${codeName}
#core:无需前端编译,复制 deploy.sh 到${groupName}_${codeName}
#oms,omscore:需要前端编译,复制 deploy.sh 到${groupName}_${codeName}
#view:需要前端编译,复制 deploy.sh 到${groupName}_${codeName}(调试中)

codeName=${1}   #项目名称,例:irs
groupName=${2}  #分组名称,例:dev_base,pro_base
ENV=${3}        #环境名称,例:test1
Target=${4}     #模块名称,例:core、oms、omscore

time=`date +%Y-%m-%d_%H:%M:%S`  #时间

shell_check(){
    if [ $? -eq 0 ];then
        echo -e "\033[32m${time} ===前端编译成功，继续===\033[0m"
    else
        echo -e "\033[31m${time} ===前端编译失败，请排查问题再发布===\033[0m"
        exit 1
    fi
}

#生产脚本路径
if [[ ${ENV} = pro* ]];then
#注:=左右两边不能有空格,表示赋值
    npm_run_build="npm run build"
    sh_position="pro"
#非生产脚本路径
elif [[ ${ENV} = dev* ]] || [[ ${ENV} = comb ]] || [[ ${ENV} = test1 ]] || [[ ${ENV} = test2 ]];then
#注:=左右两边不能有空格,表示赋值
#指定 node 版本(查看版本:node -v / nvm ls),针对从节点指定 node 版本,主节点无需指定,若主节点报错找不到 nvm 可忽略
    nvm use 6.16.0
    npm_run_build="npm run build:test1"
    sh_position="dev"
else
    echo -e "\033[31m${time} 请选择正确环境!\033[0m"
    exit 1
fi


if [[ ${ENV} = "请选择" ]] ; then
    echo -e "\033[31m${time} 请选择正确环境!\033[0m"
    exit 1

elif [[ ${Target} = "请选择" ]] ; then
    echo -e "\033[31m${time} 请选择 core/oms/omscore!\033[0m"
    exit 1

elif [[ ${codeName} = "bss" ]] ; then
    echo -e "\033[32m${time} 指定 jdk1.7 ${codeName}\033[0m"
    #设置 jdk 环境变量,指定 jdk1.7
    export JAVA_HOME=/usr/java/jdk1.7.0_79
    export PATH=$JAVA_HOME/bin:$PATH
    export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
    #指定 maven3.0
    cd /jenkins_workspace/${groupName}_${codeName}/
    /usr/local/maven/apache-maven-3.0.5/bin/mvn clean package -U -Dmaven.test.skip=true
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-${sh_position}-zdb/deploy.sh to /jenkins_workspace/${groupName}_${codeName}\033[0m"
    cp /jenkins_workspace/fb-script-${sh_position}-zdb/deploy.sh  /jenkins_workspace/${groupName}_${codeName}

elif [[ ${codeName} = "sso" || ${codeName} = "b2b-front" || ${codeName} = "cb-front" ]] ; then
    echo -e "\033[32m${time} ${groupName} ${codeName} ${ENV} ${Target} 无需前端编译\033[0m"
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-${sh_position}-zdb/deploy.sh to /jenkins_workspace/${groupName}_${codeName}-oms\033[0m"
    cp /jenkins_workspace/fb-script-${sh_position}-zdb/deploy.sh  /jenkins_workspace/${groupName}_${codeName}-oms

elif [[ ${codeName} = "aut" ]] ; then
    echo -e "\033[32m${time} ${groupName} ${codeName} ${ENV} ${Target} 无需前端编译\033[0m"
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-${sh_position}-zdb/aut_deploy.sh to /jenkins_workspace/${groupName}_${codeName}\033[0m"
    cp /jenkins_workspace/fb-script-${sh_position}-zdb/aut_deploy.sh  /jenkins_workspace/${groupName}_${codeName}

elif [[ ${codeName} = "scheduler" || ${codeName} = "mqx" || ${codeName} = "etd" || ${codeName} = "ecw" ]]; then
    echo -e "\033[32m${time} ${groupName} ${codeName} ${ENV} ${Target} 无需前端编译\033[0m"
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-${sh_position}-zdb/deploy.sh to /jenkins_workspace/${groupName}_${codeName}\033[0m"
    cp /jenkins_workspace/fb-script-${sh_position}-zdb/deploy.sh  /jenkins_workspace/${groupName}_${codeName}

elif [[ ${Target} = "core" ]] ; then
    echo -e "\033[32m${time} ${groupName} ${codeName} ${ENV} ${Target} 无需前端编译\033[0m"
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-${sh_position}-zdb/deploy.sh to /jenkins_workspace/${groupName}_${codeName}\033[0m"
    cp /jenkins_workspace/fb-script-${sh_position}-zdb/deploy.sh  /jenkins_workspace/${groupName}_${codeName}

elif [[ ${Target} = "oms" || ${Target} = "omscore" ]] ; then
    echo -e "\033[32m${time} ${groupName} ${codeName} ${ENV} ${Target} 前端编译 cnpm install\033[0m"
    cd /jenkins_workspace/${groupName}_${codeName}/${codeName}-view/
    cnpm install
    echo -e "\033[32m${time} ${groupName} ${codeName} ${ENV} ${Target} 前端编译 ${npm_run_build} 注:非生产(dev、comb、test1、test2)使用同一套 test1配置\033[0m"
    ${npm_run_build}
    shell_check
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-${sh_position}-zdb/deploy.sh to /jenkins_workspace/${groupName}_${codeName}\033[0m"
    cp /jenkins_workspace/fb-script-${sh_position}-zdb/deploy.sh  /jenkins_workspace/${groupName}_${codeName}

#仅进行 view 前端编译,注:调试中
elif [[ ${Target} = "view" ]] ; then
    echo -e "\033[32m${time} ${groupName} ${codeName} ${ENV} ${Target} 前端编译 cnpm install\033[0m"
    cd /jenkins_workspace/${groupName}_${codeName}/${codeName}-view/
    cnpm install
    echo -e "\033[32m${time} ${groupName} ${codeName} ${ENV} ${Target} 前端编译 ${npm_run_build} 注:非生产(dev、comb、test1、test2使用同一套 test1配置\033[0m"
    ${npm_run_build}
    shell_check
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-${sh_position}-zdb/deploy.sh to /jenkins_workspace/${groupName}_${codeName}\033[0m"
    cp /jenkins_workspace/fb-script-${sh_position}-zdb/deploy.sh  /jenkins_workspace/${groupName}_${codeName}

else
    echo -e "\033[31m${time} 请输入正确参数!\033[0m"
fi


