#!/bin/zsh

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：快速切换本地 ~/.kube/config 以适配多个 k8s 环境
# 方式一
# 1、将 k8s 集群的 ~/.kube/config 写入配置文件，例如：~/.kube/config.pci、~/.kube/config.sci、~/.kube/config.wei
# 2、在 k8s_util 目录编写脚本如下
# 3、给脚本赋予执行权限：chmod u+x sw_k8s.sh，在 .zshrc 添加环境变量，如：export TMP="~/k8s_util"，export PATH=$PATH:$TMP:$PATH:.，执行生效命令：source ~/.zshrc
# 4、在任意目录执行：sw_k8s.sh pci、sw_k8s.sh sci、sw_k8s.sh wei
# 5、验证：kubectl --insecure-skip-tls-verify get ns
#
# 方式二（推荐）
# alias k8s="/Users/menghuawei/IdeaProjects/my-project/gitee-work/02.测试脚本/Shell/sw_k8s.sh"
#-----------------------------------------------------------------------------



function sw_config() {
    echo "切换到 $1 环境，1. k8s pci 2. k8s sci 3. k8s wei"
    cat ~/.kube/config.$1 > ~/.kube/config
}

sw_config $1