#!/bin/zsh


#### 变量集合 ####
root_path="/root/jmeter" # 根路径
filename=$1              # 文件名称
threads=$2               # 线程数
url=$3                   # 请求 URL


#### 执行 jmx 命令 #### todo：把环境变量配置好后，在脚本去掉路径
echo "${root_path}/apache-jmeter-5.5/bin/jmeter
      -n -t ${root_path}/autotest/testcase/${filename}.jmx
      -l ${root_path}/autotest/results/result.jtl
      -e -o ${root_path}/autotest/results/result`date +%Y%m%d%H%M%S`
      -Jthreads=${threads}
      -Jurl=${url}"

${root_path}/apache-jmeter-5.5/bin/jmeter \
-n -t ${root_path}/autotest/testcase/${filename}.jmx \
-l ${root_path}/autotest/results/result.jtl \
-e -o ${root_path}/autotest/results/result`date +%Y%m%d%H%M%S` \
-Jthreads=${threads} \
-Jurl=${url}