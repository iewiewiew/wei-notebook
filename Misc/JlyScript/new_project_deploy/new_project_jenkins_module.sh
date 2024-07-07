#!/bin/bash

#${BUILD_NUMBER}--${BUILD_USER}-${comp}-${codeName}-${uid}-${module}-${ENV}-${startAddressPort}-${codeNameAddressPort}-${httpPort}-${ajpPort}-${shutdownPort}-${BUILD_TIMESTAMP}
host_list=(dev-zdb comb-zdb test1-zdb test2-zdb)
env_list=(dev comb test1 test2)
time=`date +%Y-%m-%d_%H:%M:%S`

deploy_core(){
    echo -e "\033[32m${time} 1.1、创建 user 用户 jetty-core tomcat-oms conf disconf-core disconf-oms 目录\033[0m"
    echo -e "\033[32m${time} 1.2、同步 jetty-core tomcat-oms conf disconf-core disconf-oms 文件\033[0m"
    ansible-playbook /jenkins_workspace/fb-script-dev-zdb/new_project_deploy/new_project_core.yml  --extra-vars "hosts=${hosts} ENV=${ENV} comp=${comp} codeName=${codeName} uid=${uid} startAddressPort=${startAddressPort} codeNameAddressPort=${codeNameAddressPort} shutdownPort=${shutdownPort} httpPort=${httpPort} ajpPort=${ajpPort}"

    if [[ ${comp} =  jly ]];then
        ansible ${hosts} -m shell -a "sed -i 's/com.fb.framework.dubbo.Main/com.tc.framework.dubbo.Main/g'  /app/${comp}-${codeName}/jetty/${codeName}-core/bin/start.sh;"
        echo -e "\033[32m${time} ${comp}核心包路径为 tc\033[0m"
    elif [[ ${comp} =  fb ]];then
        echo -e "\033[32m${time} ${comp}核心包路径为 fb\033[0m"
    else
        echo -e "\033[31m${time} 请输入正确参数\033[0m"
    fi
}

deploy_oms(){
    echo -e "\033[32m${time} 2.1、创建 user 用户 tomcat-oms conf disconf-oms 目录\033[0m"
    echo -e "\033[32m${time} 2.2、同步 tomcat-oms conf disconf-oms 文件\033[0m"
    ansible-playbook /jenkins_workspace/fb-script-dev-zdb/new_project_deploy/new_project_oms.yml  --extra-vars "hosts=${hosts} ENV=${ENV} comp=${comp} codeName=${codeName} uid=${uid} startAddressPort=${startAddressPort} codeNameAddressPort=${codeNameAddressPort} shutdownPort=${shutdownPort} httpPort=${httpPort} ajpPort=${ajpPort}"
}

deploy_module(){
    if [[ ${module} = core_and_oms ]];then
        deploy_core  ${hosts} ${ENV} ${comp} ${codeName} ${uid} ${startAddressPort} ${codeNameAddressPort} ${shutdownPort} ${httpPort} ${ajpPort}
        deploy_oms  ${hosts} ${ENV} ${comp} ${codeName} ${uid} ${startAddressPort} ${codeNameAddressPort} ${shutdownPort} ${httpPort} ${ajpPort}
    elif [[ ${module} = core ]]; then
        deploy_core ${hosts} ${ENV} ${comp} ${codeName} ${uid} ${startAddressPort} ${codeNameAddressPort} ${shutdownPort} ${httpPort} ${ajpPort}
    elif [[ ${module} = oms ]]; then
        deploy_oms ${hosts} ${ENV} ${comp} ${codeName} ${uid} ${startAddressPort} ${codeNameAddressPort} ${shutdownPort} ${httpPort} ${ajpPort}
    else
        echo -e "\033[31m${time} 请输入正确参数\033[0m"    
    fi
}

if [[ ${hosts} = dev-zdb || ${hosts} = comb-zdb || ${hosts} = test1-zdb || ${hosts} = test2-zdb ]];then
    deploy_module ${hosts} ${module} ${comp} ${ENV} ${codeName} ${uid} ${startAddressPort} ${codeNameAddressPort} ${shutdownPort} ${httpPort} ${ajpPort}
elif [[ ${hosts} = all ]];then  # 注：all 不包含 pro
    for hosts in ${!host_list[@]};
    do
        for ENV in ${!env_list[@]};
        do
            if [[ $hosts = $ENV ]];then
                echo ${ENV}
                deploy_module ${hosts} ${module} ${comp} ${ENV} ${codeName} ${uid} ${startAddressPort} ${codeNameAddressPort} ${shutdownPort} ${httpPort} ${ajpPort}
            fi
        done
    done
else
    echo -e "\033[31m${time} 请输入正确参数\033[0m"   
fi


