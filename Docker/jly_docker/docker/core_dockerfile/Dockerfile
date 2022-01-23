FROM base-images:v1.0.0

#cd Dockefile 的目录 && docker build -t <镜像名称>:<tag> .
#cd /root/data/comp-demo && docker build -t comp-demo-core:v1.0.0 .

MAINTAINER <wmh>

USER root

COPY ./demo-core/target/demo-core.tar.gz /app/core

WORKDIR /app/core
RUN bash -c 'tar -xzvf demo-core.tar.gz'
RUN bash -c 'cp ./demo-core/conf/dubbo.properties ./config'
RUN bash -c 'cp ./demo-core/lib/* ./lib/'
#注：jly 开头的系统启动脚本核心包路径是 tc,fb 开头的系统启动脚本核心包路径是 fb,基础镜像/app/core/bin/start_core.sh 默认是核心包路径是 tc
RUN bash -c 'sed -i "s/com.tc.framework.dubbo.Main/com.fb.framework.dubbo.Main/g"  /app/core/bin/start_core.sh'
