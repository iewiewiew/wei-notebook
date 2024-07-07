#!/bin/bash

#sh /jenkins_workspace/fb-script-dev-zdb/docker/docker_app_build.sh ${comp} ${app} ${module}

comp=${1}
app=${2}
module=${3}
time=`date +%Y-%m-%d_%H:%M:%S`

shell_check(){
    if [ $? -eq 0 ];then
        echo -e "\033[32m${time} ===前端编译成功，继续===\033[0m"
    else
        echo -e "\033[31m${time} ===前端编译失败，请排查问题再发布===\033[0m"
        exit 1
    fi
}

if [[ ${module} = "请选择" ]] ; then
    echo -e "\033[31m${time} 请选择 core/oms/omscore!\033[0m"
    exit 1

elif [[ ${app} = "bss" ]] ; then
    echo -e "\033[32m${time} 指定 jdk1.7 ${app}\033[0m"
    # 设置 jdk 环境变量,指定 jdk1.7
    export JAVA_HOME=/usr/java/jdk1.7.0_79
    export PATH=$JAVA_HOME/bin:$PATH
    export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
    # 指定 maven3.0
    cd /jenkins_workspace/docker_${comp}_${app}/
    /usr/local/maven/apache-maven-3.0.5/bin/mvn clean package -U -Dmaven.test.skip=true
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-dev-zdb/docker/docker_deploy.sh to /jenkins_workspace/docker_${comp}_${app}\033[0m"
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-dev-zdb/docker/Dockerfile  /jenkins_workspace/docker_${comp}_${app}\033[0m"
    cp /jenkins_workspace/fb-script-dev-zdb/docker/docker_deploy.sh  /jenkins_workspace/docker_${comp}_${app}
    cp /jenkins_workspace/fb-script-dev-zdb/docker/Dockerfile  /jenkins_workspace/docker_${comp}_${app}

elif [[ ${app} = "sso" || ${app} = "b2b-front" || ${app} = "cb-front" ]] ; then
    echo -e "\033[32m${time} ${comp} ${app} ${module} 无需前端编译\033[0m"
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-dev-zdb/docker/docker_deploy.sh to /jenkins_workspace/docker_${comp}_${app}-oms\033[0m"
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-dev-zdb/docker/oms_dockerfile/Dockerfile  /jenkins_workspace/docker_${comp}_${app}\033[0m"
    cp /jenkins_workspace/fb-script-dev-zdb/docker/docker_deploy.sh  /jenkins_workspace/docker_${comp}_${app}
    cp /jenkins_workspace/fb-script-dev-zdb/docker/oms_dockerfile/Dockerfile  /jenkins_workspace/docker_${comp}_${app}

elif [[ ${app} = "aut" ]] ; then
    echo -e "\033[32m${time} ${comp} ${app} ${module} 无需前端编译\033[0m"
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-dev-zdb/docker/docker_deploy.sh to /jenkins_workspace/docker_${comp}_${app}\033[0m"
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-dev-zdb/docker/Dockerfile  /jenkins_workspace/docker_${comp}_${app}\033[0m"
    cp /jenkins_workspace/fb-script-dev-zdb/docker/docker_deploy.sh  /jenkins_workspace/docker_${comp}_${app}
    cp /jenkins_workspace/fb-script-dev-zdb/docker/Dockerfile  /jenkins_workspace/docker_${comp}_${app}

elif [[ ${app} = "scheduler" || ${app} = "mqx" || ${app} = "etd" ]]; then
    echo -e "\033[32m${time} ${comp} ${app} ${module} 无需前端编译\033[0m"
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-dev-zdb/docker/docker_deploy.sh to /jenkins_workspace/docker_${comp}_${app}\033[0m"
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-dev-zdb/docker/core_dockerfile/Dockerfile  /jenkins_workspace/docker_${comp}_${app}\033[0m"
    cp /jenkins_workspace/fb-script-dev-zdb/docker/docker_deploy.sh  /jenkins_workspace/docker_${comp}_${app}
    cp /jenkins_workspace/fb-script-dev-zdb/docker/core_dockerfile/Dockerfile  /jenkins_workspace/docker_${comp}_${app}

elif [[ ${module} = "core" ]]; then
    echo -e "\033[32m${time} ${comp} ${app} ${module} 无需前端编译\033[0m"
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-dev-zdb/docker/docker_deploy.sh to /jenkins_workspace/docker_${comp}_${app}\033[0m"
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-dev-zdb/docker/core_dockerfile/Dockerfile  /jenkins_workspace/docker_${comp}_${app}\033[0m"
    cp /jenkins_workspace/fb-script-dev-zdb/docker/docker_deploy.sh  /jenkins_workspace/docker_${comp}_${app}
    cp /jenkins_workspace/fb-script-dev-zdb/docker/core_dockerfile/Dockerfile  /jenkins_workspace/docker_${comp}_${app}

elif [[ ${module} = "oms" || ${module} = "omscore" ]]; then
    echo -e "\033[32m${time} ${comp} ${app} ${module} 前端编译 cnpm install\033[0m"
    cd /jenkins_workspace/docker_${comp}_${app}/${app}-view/
    cnpm install
    echo -e "\033[32m${time} ${comp} ${app} ${module} 前端编译 npm run build:test1 注:非生产(dev、comb、test1、test2、uat)使用同一套 test1配置 \033[0m"
    npm run build:test1
    shell_check
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-dev-zdb/docker/docker_deploy.sh to /jenkins_workspace/docker_${comp}_${app}\033[0m"
    echo -e "\033[32m${time} cp /jenkins_workspace/fb-script-dev-zdb/docker/oms_dockerfile/Dockerfile  /jenkins_workspace/docker_${comp}_${app}\033[0m"
    cp /jenkins_workspace/fb-script-dev-zdb/docker/docker_deploy.sh  /jenkins_workspace/docker_${comp}_${app}
    cp /jenkins_workspace/fb-script-dev-zdb/docker/oms_dockerfile/Dockerfile  /jenkins_workspace/docker_${comp}_${app}

else
    echo -e "\033[31m${time} 请输入正确参数!\033[0m"
fi