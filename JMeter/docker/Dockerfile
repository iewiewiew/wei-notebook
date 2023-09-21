FROM openjdk:8-jdk-alpine
# FROM openjdk:8

MAINTAINER wmh

RUN wget https://mirrors.tuna.tsinghua.edu.cn/apache//jmeter/binaries/apache-jmeter-5.5.tgz \
    && tar -xzf apache-jmeter-5.5.tgz \
    && rm apache-jmeter-5.5.tgz

# 创建/root/jmeter 目录，用于存放 jmx 脚本、jtl 结果文件、html 测试报告文件
RUN mkdir /root/jmeter && chmod -R 777 /root/jmeter

ENV http_proxy ""
ENV https_proxy ""
ENV JMETER_VERSION=5.5
ENV JMETER_HOME=/usr/local/apache-jmeter-${JMETER_VERSION}
ENV JMETER_PATH=${JMETER_HOME}/bin:${PATH}
ENV PATH=${JMETER_HOME}/bin:${PATH}

# 添加 JMeter
ADD apache-jmeter-${JMETER_VERSION}.tgz /usr/local

RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone