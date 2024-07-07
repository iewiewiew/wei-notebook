#!/usr/bin/env bash

#${BUILD_NUMBER}-${BUILD_USER}-${module}-${http_port}-${core_debug_port}-${oms_debug_port}-${branch}-${BUILD_TIMESTAMP}
#视图正则表达式:^(docker).*
#参数:comp、app、http_port、core_debug_port、oms_debug_port、module、container_name、branch
#一般 core 和 oms:*-core/target/*.tar.gz,*-oms/target/*.war,**/docker_deploy.sh,**/Dockerfile
#特殊 oms:target/*.war,**/docker_deploy.sh,**/Dockerfile
#/data/${comp}-${app}-${module}  注:要用/data,不要用/root/data（迷惑）
#cp /jenkins_workspace/fb-script-dev-zdb/docker/docker_deploy.sh /jenkins_workspace/docker_${comp}_${app}
#cp /jenkins_workspace/fb-script-dev-zdb/docker/core_dockerfile/Dockerfile /jenkins_workspace/docker_${comp}_${app}
#cp /jenkins_workspace/fb-script-dev-zdb/docker/oms_dockerfile/Dockerfile /jenkins_workspace/docker_${comp}_${app}
#sh /root/data/${comp}-${app}/docker_deploy.sh ${comp} ${app} ${module} ${http_port} ${core_debug_port} ${oms_debug_port} ${container_name}

comp=${1}
app=${2}
module=${3}
http_port=${4}
core_debug_port=${5}
oms_debug_port=${6}
container_name=${7}
time=`date +%Y-%m-%d_%H:%M:%S`

#清理缓存
echo 1 > /proc/sys/vm/drop_caches
echo 2 > /proc/sys/vm/drop_caches
echo 3 > /proc/sys/vm/drop_caches

#检测容器是否存在,不存在则 run,若存在则先删除再 run
check_container_is_exist(){
  #docker ps | grep jly-aps-core-v002 | grep -v grep | awk '{print $1}'
  pid=`docker ps | grep ${comp}-${app}-${module}-${container_name} | grep -v grep | awk '{print $1}'`
  if [ "${pid}" ]; then
      echo -e "\033[32m${time} 容器名称:${comp}-${app}-${module}-${container_name} 容器 id:${pid} 已存在,进行删除:docker rm -f ${comp}-${app}-${module}-${container_name}
注：可能存在假进程,如果报错该容器已存在,请前往 Docker 宿主机执行删除容器
删除容器：docker rm -f ${comp}-${app}-${module}-${container_name}
查看容器日志：docker logs ${comp}-${app}-${module}-${container_name}
进入容器：docker exec -it ${comp}-${app}-${module}-${container_name} /bin/bash\033[0m"
      docker rm -f ${comp}-${app}-${module}-${container_name}
      docker logs ${comp}-${app}-${module}-${container_name}
  else
      echo -e "\033[32m${time} ${comp}-${app}-${module}-${container_name} pid 不存在,防止存在假进程：docker rm -f ${comp}-${app}-${module}-${container_name},开始 run,
注：可能存在假进程,如果报错该容器已存在,请前往 Docker 宿主机执行删除容器
删除容器：docker rm -f ${comp}-${app}-${module}-${container_name}
查看容器日志：docker logs ${comp}-${app}-${module}-${container_name}
进入容器：docker exec -it ${comp}-${app}-${module}-${container_name} /bin/bash\033[0m"
      docker rm -f ${comp}-${app}-${module}-${container_name}
      docker logs ${comp}-${app}-${module}-${container_name}
  fi
}

copy_aut(){
    sed -i "10 i COPY ./${app}-${module}/target/${app}-${module}.war /usr/local/tomcat/webapps" /root/data/${comp}-${app}/Dockerfile
    sed -i "10 i COPY ./${app}-${module}/target/${app}-${module}.war /usr/local/tomcat/webapps" /root/data/${comp}-${app}/Dockerfile
}

copy_sso(){
    sed -i "10 i COPY ./target/sso-${module}.war /usr/local/tomcat/webapps" /root/data/${comp}-${app}/Dockerfile
}

copy_oms(){
    sed -i "10 i COPY ./${app}-${module}/target/${app}-${module}.war /usr/local/tomcat/webapps" /root/data/${comp}-${app}/Dockerfile
}

run_core(){

    sed -i "s/comp/${comp}/g" /root/data/${comp}-${app}/Dockerfile
    sed -i "s/demo/${app}/g" /root/data/${comp}-${app}/Dockerfile

    if [[ ${comp} = jly ]];then
       echo -e "\033[32m${time} ${comp} ${app} 需调整核心包路径 \033[0m"
       sed -i "s/com.fb.framework.dubbo.Main/com.tc.framework.dubbo.Main/g" /root/data/${comp}-${app}/Dockerfile
    else [[ ${comp} = fb ]]
       echo -e "\033[32m${time} ${comp} ${app} 无需调整核心包路径 \033[0m"
    fi

    echo -e "\033[32m${time} 构建应用镜像: cd /root/data/${comp}-${app} && docker build -t ${comp}-${app}-${module}:v1.0.0 .\033[0m"
    cd /root/data/${comp}-${app} && docker build -t ${comp}-${app}-${module}:v1.0.0 .

    #检测容器是否存在,不存在则 run,若存在则先删除再 run
    check_container_is_exist

    docker run \
    -p ${core_debug_port}:1111 \
    -v /etc/disconf/${module}/${comp}-${app}/disconf.properties:/app/core/config/disconf.properties \
    -v /bizdata:/bizdata \
    --net=host \
    --ulimit -c unlimited \
    -it --name ${comp}-${app}-${module}-${container_name} -d ${comp}-${app}-${module}:v1.0.0 /app/core/bin/start_core.sh
}

run_oms(){
    echo -e "\033[32m${time} 构建应用镜像: cd /root/data/${comp}-${app} && docker build -t ${comp}-${app}-${module}:v1.0.0 .\033[0m"
    cd /root/data/${comp}-${app} && docker build -t ${comp}-${app}-${module}:v1.0.0 .

    #检测容器是否存在,不存在则 run,若存在则先删除再 run
    check_container_is_exist

    docker run \
    -p ${http_port}:8080 \
    -p ${oms_debug_port}:2222 \
    -v /etc/disconf/${module}/${comp}-${app}/disconf.properties:/usr/local/tomcat/conf/disconf.properties \
    -v /bizdata:/bizdata \
    -it --name ${comp}-${app}-${module}-${container_name} -d ${comp}-${app}-${module}:v1.0.0 /bin/bash /usr/local/start_oms.sh
}

del_old_app(){
    echo -e "\033[32m${time} cd /root/data && rm -rf ${comp}-${app} \033[0m"
    cd /root/data && rm -rf ${comp}-${app}
}

if [[ ${app} = aut ]];then
    copy_aut
    run_oms
    del_old_app
elif [[ ${app} = sso ]] || [[ ${app} = b2b-front ]] || [[ ${app} = cb-front ]];then
    copy_sso
    run_oms
    del_old_app
elif [[ ${module} = core ]];then
    run_core
    del_old_app
elif [[ ${module} = oms ]];then
    copy_oms
    run_oms
    del_old_app
else
    echo -e "\033[31m${time} 请输入正确参数! \033[0m"
    exit 1
fi