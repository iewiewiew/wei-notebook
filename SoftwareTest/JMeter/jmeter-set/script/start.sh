#!/bin/bash


trap 'echo "收到 SIGINT 信号，执行清理操作"; exit 1' SIGINT SIGTERM


TIME=$(date +%Y-%m-%d_%H:%M:%S)
BASE_PATH="/root/jmeter-test"
IP_ADDR=`curl cip.cc |grep IP |awk -F: '{ print$2 }' |awk '{ print$1 }'`


echo -e "\033[32m${TIME} 0、查看路径\033[0m"
cd .. && pwd


function build_jmeter() {
    IMAGES_ID=`docker images |grep jmeter-test |awk '{print $3}'`
    if [ "$IMAGES_ID" != "" ]; then
        echo -e "\033[32m${TIME} 1、准备 JMeter 环境 >> jmeter-test 镜像已存在\033[0m"
    else
        echo -e "\033[32m${TIME} 1、准备 JMeter 环境 >> 构建 jmeter-test 镜像\033[0m"
        docker build --no-cache -t jmeter-test:latest -f dockerfile/Dockerfile-JMeter .
    fi

    CONTAINER_ID=`docker ps -a |grep jmeter-test |awk '{print $1}'`
    if [ "$CONTAINER_ID" != "" ]; then
        echo -e "\033[32m${TIME} 1、准备 JMeter 环境 >> jmeter-test 容器已存在\033[0m"
    else
        echo -e "\033[32m${TIME} 1、准备 JMeter 环境 >> 运行 jmeter-test 容器\033[0m"
        docker run -it -d --name jmeter-test -v ${BASE_PATH}:${BASE_PATH} jmeter-test:latest
    fi
}


function exec_jmx() {
    # 仅按当天日期压缩上一次文件，不做历史保留
    cd ${BASE_PATH} && tar -zcf result_$(date +%Y%m%d).tar.gz result/

    array=("all" "aa" "bb")
#    array=("all")
    for i in "${array[@]}"; do
        cd ${BASE_PATH} && rm -rf result/${i}

        echo -e "\033[32m${TIME} 2、执行脚本 >> jmeter-test-${i}.jmx\033[0m"
        docker exec -i jmeter-test sh -c "jmeter -n -t /root/jmeter-test/testcase/jmeter-test-${i}.jmx -l /root/jmeter-test/result/${i}/result.csv -e -o /root/jmeter-test/result/${i}/"

        # 间隔时间 待定
        sleep 2
    done
}


function run_nginx() {
    [ -d "/root/jmeter-test/nginx/html" ] && echo -e "\033[32m${TIME} 3、Nginx 目录已存在\033[0m" || mkdir -vp nginx/html
    cp -R result/all/* ${BASE_PATH}/nginx/html

    CONTAINER_ID=`docker ps |grep nginx |awk '{print $1}'`
    if [ "$CONTAINER_ID" != "" ]; then
        echo -e "\033[32m${TIME} 3、运行 Nginx >> nginx 容器已存在\033[0m"
    else
        echo -e "\033[32m${TIME} 3、运行 Nginx >> 运行 nginx 容器\033[0m"
        docker run -it -d --name nginx -p 9999:80 -v ${BASE_PATH}/nginx/html:/usr/share/nginx/html nginx:latest
    fi
    docker restart nginx
}


function generate_report() {
    IMAGES_ID=`docker images |grep jmeter-report |awk '{print $3}'`
    if [ "$IMAGES_ID" != "" ]; then
        echo -e "\033[32m${TIME} 4、生成测试报告 >> jmeter-report 镜像已存在\033[0m"
    else
        echo -e "\033[32m${TIME} 4、生成测试报告 >> 构建 jmeter-report 镜像\033[0m"
        docker build --no-cache -t jmeter-report:latest -f dockerfile/Dockerfile-Report .
    fi

    CONTAINER_ID=`docker ps -a |grep jmeter-report |awk '{print $1}'`
    if [ "$CONTAINER_ID" != "" ]; then
        docker rm -f jmeter-report
    fi
    echo -e "\033[32m${TIME} 4、生成测试报告 >> 运行生成测试报告容器\033[0m"
    docker run -it -d --name jmeter-report -p 8888:8888 -v ${BASE_PATH}:${BASE_PATH} jmeter-report:latest
}


function send_notice() {
    echo -e "\033[32m${TIME} 5、发送构建完成通知\033[0m"

    local webhook_url="https://open.feishu.cn/open-apis/bot/v2/hook/295f2048-e071-4ea8-8847-5060711dc804"
    local json_data='{"msg_type":"interactive","card":{"elements":[{"tag":"div","text":{"content":"<at id=all></at>任务完成","tag":"lark_md"}},{"actions":[{"tag":"button","text":{"content":"点击下载报告","tag":"lark_md"},"url":"http://'${IP_ADDR}':8888","type":"default","value":{}}],"tag":"action"},{"actions":[{"tag":"button","text":{"content":"点击查看报告","tag":"lark_md"},"url":"http://'${IP_ADDR}':9999","type":"default","value":{}}],"tag":"action"}],"header":{"template":"blue","title":{"content":"通知","tag":"plain_text"}}}}'
    curl -X POST -H "Content-Type: application/json" -d "${json_data}" "${webhook_url}"
}


function main() {
   build_jmeter
   exec_jmx
   run_nginx
   generate_report
   send_notice

   echo -e "\033[32m${TIME} 生成测试报告路径: ${BASE_PATH}/result/jmeter_test_report_$(date +%Y%m%d).xlsx\033[0m"
   echo -e "\033[32m${TIME} 下载测试报告地址: http://${IP_ADDR}:8888/\033[0m"
   echo -e "\033[32m${TIME} 查看测试报告地址: http:/${IP_ADDR}:9999/\033[0m"
}

main