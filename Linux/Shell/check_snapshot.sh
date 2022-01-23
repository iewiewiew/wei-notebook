#!/bin/bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：
# 检查编译后的项目包是否包含快照版,如果包含快照版则退出.
# ls -l *bsf-api*202* || ls -l *bsf-api*SNAPSHOT*
# 快照版格式1：yyyyMMdd.hhmmss,举例：bsf-api-1.0.4-20201021.093600-1.jar,只检测带项目名 api 包含202的快照版
# 快照版格式2：SNAPSHOT,举例：bsf-api-1.0.4-SNAPSHOT-1.jar,只检测带项目名 api 包含 SNAPSHOT 的快照版
#-----------------------------------------------------------------------------

comp=${1}      #名称前缀,例:fb 或者 jly
groupName=${2} #分组名称,例:pro_bis
codeName=${3}  #项目名称,例:cbs
Target=${4}    #模块名称,例:core 或者 oms
time=`date +%Y-%m-%d_%H:%M:%S`  #时间

#检查快照包公共方法
fun_check_api_snapshot(){
    #业务组
    ls -l *cap-api*202* || ls -l *cas-api*202* || ls -l *cbs-api*202* || ls -l *eam-api*202* || ls -l *pls-api*202* || \
    ls -l *cap-api*SNAPSHOT* || ls -l *cas-api*SNAPSHOT* || ls -l *cbs-api*SNAPSHOT* || ls -l *eam-api*SNAPSHOT* || ls -l *pls-api*SNAPSHOT* || \
    #九里云组
    ls -l *aps-api*202* || ls -l *aut-api*202* || ls -l *bsf-api*202* || ls -l *dcs-api*202* || ls -l *mqx-api*202* || ls -l *prs-api*202* || ls -l *scheduler-api*202* || ls -l *sso-api*202* || \
    ls -l *aps-api*SNAPSHOT* || ls -l *aut-api*SNAPSHOT* || ls -l *bsf-api*SNAPSHOT* || ls -l *dcs-api*SNAPSHOT* || ls -l *mqx-api*SNAPSHOT* || ls -l *prs-api*SNAPSHOT* || ls -l *scheduler-api*SNAPSHOT* || ls -l *sso-api*SNAPSHOT* || \
    #基础组
    ls -l *b2b-front-api*202* || ls -l *bss-api*202* || ls -l *cb-front-api*202* || ls -l *irs-api*202*  || \
    ls -l *b2b-front-api*SNAPSHOT* || ls -l *bss-api*SNAPSHOT* || ls -l *cb-front-api*SNAPSHOT* || ls -l *irs-api*SNAPSHOT*  || \
    #风控组
    ls -l *rms-api*202* || ls -l *res-api*202* || ls -l *ecw-api*202* || ls -l *fes-api*202* || \
    ls -l *rms-api*SNAPSHOT*  || ls -l *res-api*SNAPSHOT* || ls -l *ecw-api*SNAPSHOT* || ls -l *fes-api*SNAPSHOT*
}

#特殊项目
fun_oms(){
    cd /jenkins_workspace/${groupName}_${codeName}-oms/target/${codeName}-oms/WEB-INF/lib && fun_check_api_snapshot

    if [ $? -eq 0 ];then
        echo -e "\033[31m${time} /jenkins_workspace/${groupName}_${codeName}-oms/target/${codeName}-oms/WEB-INF/lib 包含快照版 api 压缩包,请更换成正式版进行发布\033[0m"
        exit 1
    else
        echo -e "\033[32m${time} /jenkins_workspace/${groupName}_${codeName}-oms/target/${codeName}-oms/WEB-INF/lib 无快照版 api 压缩包,此报错请忽略\033[0m"
    fi
}

#一般项目 core
fun_normal_core(){
    cd /jenkins_workspace/${groupName}_${codeName}/${codeName}-core/target && tar -zxf ${codeName}-core.tar.gz && cd ${codeName}-core/lib && fun_check_api_snapshot
    if [ $? -eq 0 ];then
        echo -e "\033[31m${time} /jenkins_workspace/${groupName}_${codeName}/${codeName}-core/target/${codeName}-core/lib 包含快照版 api 压缩包,请更换成正式版进行发布\033[0m"
        exit 1
    else
        echo -e "\033[32m${time} /jenkins_workspace/${groupName}_${codeName}/${codeName}-core/target/${codeName}-core/lib 无快照版 api 压缩包,此报错请忽略\033[0m"
    fi
}

#一般项目 oms
fun_normal_oms(){
    cd /jenkins_workspace/${groupName}_${codeName}/${codeName}-oms/target/${codeName}-oms/WEB-INF/lib && fun_check_api_snapshot
    if [ $? -eq 0 ];then
        echo -e "\033[31m${time} /jenkins_workspace/${groupName}_${codeName}/${codeName}-oms/target/${codeName}-oms/WEB-INF/lib 包含快照版 api 压缩包,请更换成正式版进行发布\033[0m"
        exit 1
    else
        echo -e "\033[32m${time} /jenkins_workspace/${groupName}_${codeName}/${codeName}-oms/target/${codeName}-oms/WEB-INF/lib 无快照版 api 压缩包,此报错请忽略\033[0m"
    fi
}

#aut 项目 core
fun_aut_core(){
    cd /jenkins_workspace/${groupName}_${codeName}/${codeName}-core/target/${codeName}-core/WEB-INF/lib && fun_check_api_snapshot
    if [ $? -eq 0 ];then
        echo -e "\033[31m${time} /jenkins_workspace/${groupName}_${codeName}/${codeName}-core/target/${codeName}-oms/WEB-INF/lib 包含快照版 api 压缩包,请更换成正式版进行发布\033[0m"
        exit 1
    else
        echo -e "\033[32m${time} /jenkins_workspace/${groupName}_${codeName}/${codeName}-core/target/${codeName}-oms/WEB-INF/lib 无快照版 api 压缩包,此报错请忽略\033[0m"
    fi
}

#aut 项目 oms
fun_aut_oms(){
    cd /jenkins_workspace/${groupName}_${codeName}/${codeName}-oms/target/${codeName}-oms/WEB-INF/lib && fun_check_api_snapshot
    if [ $? -eq 0 ];then
        echo -e "\033[31m${time} /jenkins_workspace/${groupName}_${codeName}/${codeName}-oms/target/${codeName}-oms/WEB-INF/lib 包含快照版 api 压缩包,请更换成正式版进行发布\033[0m"
        exit 1
    else
        echo -e "\033[32m${time} /jenkins_workspace/${groupName}_${codeName}/${codeName}-oms/target/${codeName}-oms/WEB-INF/lib 无快照版 api 压缩包,此报错请忽略\033[0m"
    fi
}

if [[ ${codeName} = "sso" || ${codeName} = "b2b-front" || ${codeName} = "cb-front" ]]; then
    fun_oms
elif [[ ${codeName} = "aut" ]]; then
    if [[ ${Target} = "core" ]]; then
        fun_aut_core
    elif [[ ${Target} = "oms" ]]; then
        fun_aut_oms
    else
        echo -e "\033[31m${time} 请输入正确参数!\033[0m"
    fi
else
    if [[ ${Target} = "core" ]]; then
        fun_normal_core
    elif [[ ${Target} = "oms" ]]; then
        fun_normal_oms
    else
        echo -e "\033[31m${time} 请输入正确参数!\033[0m"
    fi
fi