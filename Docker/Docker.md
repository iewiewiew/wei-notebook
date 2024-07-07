[TOC]

<h1 align="center">Docker</h1>

> By：weimenghua  
> Date：2022.07.24  
> Description：Docker

**参考资料**  
[dockfile 集合](https://github.com/dockerfile)  
[阿里云官方镜像站](https://developer.aliyun.com/mirror/)



## 1. Docker 简介

### 1.1 Docker 简介

1. 镜像（Image）：Docker 镜像（Image），就相当于是一个 root 文件系统。比如官方镜像 ubuntu:16.04 就包含了完整的一套 Ubuntu16.04 最小系统的 root 文件系统。
2. 容器（Container）：镜像（Image）和容器（Container）的关系，就像是面向对象程序设计中的类和实例一样，镜像是静态的定义，容器是镜像运行时的实体。容器可以被创建、启动、停止、删除、暂停等。
3. 仓库（Repository）：仓库可看着一个代码控制中心，用来保存镜像。
4. Dockerfile：Dockerfile 是一个用来构建镜像的文本文件，文本内容包含了一条条构建镜像所需的指令和说明。
5. docker-compose：Docker 提供的一个命令行工具。

### 1.2 环境搭建

1、安装
Linux 安装 Docker：`yum install docker`，执行启动 Docker 命令：`service docker start`。

查看 Docker 配置：`cat /usr/lib/systemd/system/docker.service`。

Mac 安装 Docker：[下载 dmg 安装包](https://www.docker.com/products/docker-desktop/) 之后进行安装。  

```
service docker start                #启动 docker
docker -v                           #查看 docker 版本
systemctl enable docker             #开机启动 docker
systemctl restart docker            #重启 docker
systemctl stop docker               #停止 docker
docker info                         #查看 docker 系统信息
rm -rf /var/lib/docker              #删除镜像/容器等
```

踩坑：Mac 安装 Docker，如果双击无法启动 Docker，可进入控制台，ps 查看 Docker 进程再 kill 掉，最后再双击 Docker，然后进入 Mac 终端，执行 docker -version 查看是否安装成功。

linux-ubuntu 安装 Docker

```
apt-get remove docker docker-engine docker.io containerd runc

apt update

apt install docker.io
snap install docker

docker run hello-world
```

2、配置镜像源

- 方式一：vim /etc/docker/daemon.json(Linux) / vim ~/.docker/daemon.json(Mac)
- 方式二：在 Docker 客户端，点击设置按钮，在 Docker Enging 设置。

中科院的镜像
```
{
 "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"]
}
```

阿里云的镜像
```
{
 "registry-mirrors":["https://6kx4zyno.mirror.aliyuncs.com"]
}
```

3、开放端口
1. 修改/usr/lib/systemd/system/docker.service，在[service]的 ExecStart ，添加 -H tcp://0.0.0.0:2375
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H fd:// --containerd=/run/containerd/containerd.sock
2. 刷新配置文件，重启 docker
systemctl daemon-reload
systemctl restart docker
3. 添加防火墙2375/tcp ，并重载防火墙
firewall-cmd --zone=public --add-port=2375/tcp --permanent
firewall-cmd --reload
4. 查看系统网络端口2375是否被 docker 所监听
netstat -tulp

```
mkdir -vp /etc/docker
tee /etc/docker/daemon.json <<EOF
{
    "dns": ["8.8.8.8", "8.8.4.4"],
    "registry-mirrors": ["https://registry.cn-hangzhou.aliyuncs.com"]
}
EOF
systemctl daemon-reload
systemctl restart docker
docker info
```

踩坑：设置镜像源无效，可以直接在镜像仓库前指定镜像地址



## 2. Docker 镜像
### 2.1 常用命令

```
docker images                                           #列出本地镜像
docker images java                                      #列出本地镜像中 REPOSITORY 为 java 的镜像列表
docker search java                                      #从 Docker Hub 查找所有镜像名包含 java 的镜像
docker search -f stars=10 java                          #从 Docker Hub 查找所有镜像名包含 java,并且收藏数大于10的镜像
docker pull java                                        #从 Docker Hub 下载 java 最新版镜像
docker pull -a java                                     #从 Docker Hub 下载 REPOSITORY 为 java 的所有镜像
docker tag redis:alpine redis:v1                        #docker tag：标记本地镜像,将其归入某一仓库
docker push myapache:v1                                 #将本地的镜像上传到镜像仓库,要先登陆到镜像仓库 docker push
docker rmi -f nginx:latest                              #docker rmi:删除本地一个或多少镜像
docker history redis:alpine                             #docker history：查看指定镜像的创建历史
docker history redis:alpine  --no-trunc                 #docker history：查看指定镜像的创建历史，--no-trunc 查看全部信息
docker export <容器 ID> > redis_latest.tar               #docker export：将指定镜像保存成 tar 归档文件
docker save -o redis_latest.tar redis:alpine            #docker save：将指定镜像保存成 tar 归档文件
docker load < redis_latest.tar                          #docker load：导入使用 docker save 命令导出的镜像
docker load -i redis_latest.tar                         #docker load：导入使用 docker save 命令导出的镜像
```

### 2.2 常见问题

1. 为什么会生成悬空镜像镜像？

```
在 Docker 中，当构建一个镜像时，如果没有为镜像指定一个名称和标签，它将会被标记为 <none>。这通常发生在以下情况下：  

- 构建过程中出现错误：如果在构建镜像的过程中遇到错误，导致构建未能成功完成，那么生成的镜像将被标记为 <none>。这通常是因为在构建过程中某个步骤失败，例如找不到指定的文件、依赖项无法安装等。
- 未为镜像指定名称和标签：如果在构建镜像时没有为其指定名称和标签，例如没有使用 -t 选项指定标签，那么生成的镜像将被标记为 <none>。  
- 在同环境中两个镜像名称:tag都相同，image层数据内容不一致，覆盖后则会出现 <none> 标志。
- docker save 时镜像没有指定镜像名称:tag，而是使用的镜像ID。
- 正运行的容器所引用的镜像，将其强行删除镜像docker images会出现<none>标记。

要避免生成 <none> 标签的镜像，可以在构建镜像时明确指定名称和标签，例如：`docker build -t myimage:latest .`这将为镜像指定名称为 myimage，标签为 latest。
```

2. Docker 跨平台构建镜像

Docker buildx 为不同的平台和架构构建镜像

Dockerfile
```
# 使用一个轻量级的基础镜像
FROM nginx:alpine

# 定义容器启动时要执行的命令
CMD ["nginx", "-g", "daemon off;"]

# 定义容器启动时要执行的命令
CMD ["echo", "Hello, Docker!"]
```

3. Docker buildx

```
创建并启用 Docker Buildx 构建器
docker buildx create --use

使用 Buildx 构建器创建多平台镜像
docker buildx build --platform linux/amd64,linux/arm64 -t myimage:latest .
docker buildx build -f ./Dockerfile2 --platform linux/amd64,linux/arm64 -t wei/myimage:latest --push .

查看镜像平台
docker image inspect --format='{{.Os}}/{{.Architecture}}' myimage:latest
```

4. 从 Docker 镜像提取 Dockerfile

```
alias dfimage="docker run -v /var/run/docker.sock:/var/run/docker.sock --rm alpine/dfimage"
dfimage -sV=1.36 alpine/dfimage:latest

alias dive="docker run -ti --rm  -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive"
dive wagoodman/dive:latest
```

5. 磁盘空间

```
docker system df        #查看 Docker 占用磁盘空间
docker system prune     #一键清理 docker 空间
```

TYPE 使用磁盘的 4 种类型：       
Images：所有镜像占用的空间，包括拉取下来的镜像，和本地构建的。      
Containers：运行的容器占用的空间，表示每个容器的读写层的空间。        
Local Volumes：容器挂载本地数据卷的空间。     
Build Cache：镜像构建过程中产生的缓存空间（只有在使用 BuildKit 时才有，Docker 18.09 以后可用）。     

6. Slim和Alpine镜像
Slim和Alpine是两种不同的Docker镜像，用于构建和运行容器化应用程序。
- Slim镜像：Slim镜像是基于Debian发行版构建的精简版镜像。它的设计目标是提供一个轻量级的操作系统环境，适用于容器化应用程序。Slim镜像相对于完整的Debian镜像来说更小，因为它只包含了一些核心组件和必要的依赖项，以最小化镜像的大小。Slim镜像通常用于构建需要在Debian环境中运行的应用程序的容器。
- Alpine镜像：Alpine镜像是基于Alpine Linux发行版构建的镜像。Alpine Linux以其小巧、安全和高度可定制的特性而闻名。Alpine镜像非常小巧，基本镜像的大小通常只有几兆字节。它采用了BusyBox工具集和musl C库，这使得Alpine Linux能够在非常小的资源占用下运行。Alpine镜像通常被用作构建和部署容器化应用程序的轻量级解决方案。



## 3. Docker 容器

### 3.1 常用命令

```
docker run  #启动容器
docker run -d \
--name mysql \
-p 3306:3306 \
-v /usr/local/docker/mysql/config/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf \
-v /usr/local/docker/mysql/data/mysql:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=123456 \
mysql:5.7

当利用 docker run 来创建容器时，Docker 在后台运行的标准操作包括：
1、检查本地是否存在指定的镜像，不存在就从公有仓库下载
2、利用镜像创建并启动一个容器
3、分配一个文件系统，并在只读的镜像层外面挂载一层可读写层
4、从宿主主机配置的网桥接口中桥接一个虚拟接口到容器中去
5、从地址池配置一个 ip 地址给容器
6、执行用户指定的应用程序
7、执行完毕后容器被终止

创建容器时添加参数  --restart=always 后，当 docker 重启时，容器自动启动。
docker 应用容器 获取宿主机 root 权限（特殊权限-） --privileged=true 
解决 docker 容器时区不同步的方法：docker run -v /etc/localtime:/etc/localtime
```

```
docker start <容器名称>                             #docker start <容器名称>：启动容器
docker stop <容器名称>                              #docker stop <容器名称>：停止容器
docker restart <容器名称>                           #docker restart <容器名称>：重启容器
docker kill -s KILL <容器名称>                      #docker kill <容器名称>：杀掉运行中的容器
docker pause <容器名称>                             #docker pause：暂停<容器名称>提供服务
docker unpause <容器名称>                           #docker unpause：恢复<容器名称>提供服务
docker create --name <容器名称> <镜像名称>:<版本号>   #docker create：创建容器但是不启动
docker exec -it <容器 ID> /bin/bash                 #docker exec：在运行的容器中执行命令 (查看容器 ID：docker ps -a)
docker diff <容器名称>                              #docker diff：检查容器里文件结构的更改 
docker port <容器 ID>                                 #查看容器<容器 ID>端口
docker inspect mysql:5.7                              #获取镜像 mysql:5.7的元信息
docker inspect --format='{{json .Config}}' mysql:5.7  #获取镜像 mysql:5.7的元信息
docker top <容器名称>                                  #查看容器<容器名称>的进程信息
docker top <容器 ID>                                   #查看容器<容器 ID>的进程信息
docker stats		                                  #查看容器资源使用情况 																	#查看容器占用资源情况

docker exec -it <容器 ID> /bin/bash
docker exec -it $(docker ps |grep -v pause |grep 应用名称 |awk -F " " '{print $1}') /bin/bash

for i in  `docker ps |grep Up|awk '{print $1}'`;do echo \ &&docker top $i; done     #查看所有运行容器的进程信息。

docker export -o mysql-`date +%Y%m%d`.tar <容器 ID>  #docker export：将文件系统作为一个 tar 归档文件导出到 STDOUT 
```

```
docker commit -a "runoob.com" -m "my apache" a404c6c174a2  mymysql:v1  #从容器创建一个新的镜像，将容器 a404c6c174a2 保存为新的镜像,并添加提交人信息和说明信息
-a :提交的镜像作者；
-c :使用 Dockerfile 指令来创建镜像；
-m :提交时的说明文字；
-p :在 commit 时，将容器暂停。
```

Docker 重启策略

```
--restart=no 默认策略，在容器退出时不重启容器
--restart=on-failure 在容器非正常退出时（退出状态非0），才会重启容器
--restart=on-failure:3 指定启动的次数，在容器非正常退出时重启容器，最多重启3次
--restart=always 在容器退出时总是重启容器
--restart=unless-stopped 在容器退出时总是重启容器，但是不考虑在 Docker 守护进程启动时就已经停止了的容器
```

### 3.2 容器状态

```
docker ps                                    #查看正在运行的容器
docker ps -a                                 #查看所有容器
docker ps -n 5                               #列出最近创建的5个容器信息
docker ps -a -q                              #列出所有创建的容器 ID
docker ps --format "{{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}" #显示 Docker 容器的 ID、名称、镜像和端口信息

STATUS 容器状态,7种：
created                                     （已创建）
restarting                                  （重启中）
running                                     （运行中）
removing                                    （迁移中）
paused                                      （暂停）
exited                                      （停止）
dead                                        （死亡）
```

容器使用的最常见的退出码 参考资料：[Kubernetes 中容器的退出状态码参考指南](https://mp.weixin.qq.com/s/-nlrCZLBJZwrcUNIaQ_6UA)

| 退出码 |         名称         |                           含义                            |
| :----: | :------------------: | :-------------------------------------------------------: |
|   0    |       正常退出       |               开发者用来表明容器是正常退出                |
|   1    |       应用错误       |      容器因应用程序错误或镜像规范中的错误引用而停止       |
|  125   |     容器未能运行     |                docker run 命令没有执行成功                |
|  126   |     命令调用错误     |                 无法调用镜像中指定的命令                  |
|  127   |   找不到文件或目录   |               找不到镜像中指定的文件或目录                |
|  128   | 退出时使用的参数无效 | 退出是用无效的退出码触发的（有效代码是 0-255 之间的整数） |
|  134   |  异常终止 (SIGABRT)  |               容器使用 abort() 函数自行中止               |
|  137   |  立即终止 (SIGKILL)  |            容器被操作系统通过 SIGKILL 信号终止            |
|  139   |  分段错误 (SIGSEGV)  |           容器试图访问未分配给它的内存并被终止            |
|  143   |  优雅终止 (SIGTERM)  |             容器收到即将终止的警告，然后终止              |
|  255   |   退出状态超出范围   | 容器退出，返回可接受范围之外的退出代码，表示错误原因未知  |

### 3.3 查看日志

```
docker logs <容器名称>                         #获取<容器名称>的日志
docker logs -f --tail=10 <容器 ID>             #获取<容器 ID>的日志
docker logs -f --tail=10 $(docker ps |grep -v pause |grep 应用名称 |awk -F " " '{print $1}')
```

### 3.4 文件复制

```
docker cp /aaa/bbb <容器 ID>:/ccc/             #将主机/aaa/bbb 目录拷贝到容器<容器 ID>的/ccc 目录下
docker cp /aaa/bbb <容器 ID>:/ccc              #将主机/aaa/bbb 目录拷贝到容器<容器 ID>中，目录重命名为 ccc
docker cp <容器 ID>:/aaa /bbb/                 #将<容器 ID>的/aaa 目录拷贝到主机的/ccc 目录中
```

### 3.5 删除容器

```
docker rm -f <容器名称1> <容器名称2>                       #docker rm ：删除一个或多个容器 rm -f <容器名称> 
docker rm -v <容器名称>                                  #删除容器<容器名称>,并删除容器挂载的数据卷
docker rm $(docker ps -a -q)                            #删除所有已经停止的容器(-q：只展示容器 ID)
docker stop $(docker ps -a -q)                          #stop 停止所有容器
docker start e5ee4a252828                               #start 启动容器<容器 ID>
docker rm $(docker ps -a -q)                            #remove 删除所有容器
docker container prune                                  #删除所有停止的容器
docker rmi $(docker images -q)                          #删除所有的镜像
docker rmi -f $(docker images -f "dangling=true" -q)    #删除所有无名称的镜像（悬空镜像） -f：强制删除
docker rm $(sudo docker ps -qf status=exited)           #根据容器的状态,删除 Exited 状态的容器
docker rmi -f $(docker images MySQL -q)                 #通过 docker images MySQL -q 查询出 MySQL 的所有镜像 id，-q 表示仅查询 id，并将这些 id 作为参数传递给 docker rmi -f 指令，这样所有的 MySQL 镜像就都被删除了
docker volume rm $(docker volume ls -q)                 #删除不再使用的数据卷
docker volume prune                                     #删除不再使用的数据卷
docker builder prune                                    #删除 build cache
```

### 3.6 目录挂载

```
docker run -d -it --name demo --mount source=/tmp1, destination=/tmp2
```

### 3.7 知识碎片

在 Docker 中，`entrypoint` 是用于设置容器启动时要运行的默认命令或脚本的指令。它定义了一个可执行文件或脚本，并将其作为容器的入口点。当容器启动时，该脚本会被自动执行。
`entrypoint` 指令通常用于设置容器的主要进程或服务。例如，如果你创建了一个基于 NodeJS 的应用程序，可以使用 `entrypoint` 指定启动 Node 进程的命令和参数。当容器启动时，Node 进程将自动启动并开始提供你的应用程序服务。
另外，通过在 `docker run` 命令中指定参数，你可以覆盖 `entrypoint` 中定义的默认命令或脚本，从而在启动容器时运行不同的命令或脚本。



## 4. Docker 仓库

1. Harbor 仓库

启动
```
cd /usr/local/harbor && docker-compose up -d    #后台重启
cd /usr/local/harbor && docker-compose ps       #进入到有 docker-compose.yml 才能执行 docker-compose ps
```

登陆/登出
```
docker login -u 用户名 -p 密码                   #登陆
docker logout -u 用户名 -p 密码                  #登出
```

1. DockerHub 仓库

[Dockerhub 仓库](https://hub.docker.com/search?q=)：安装软件，在这里找！
[DockerHub-wwweeeiii 仓库](https://hub.docker.com/repository/docker/wwweeeiii/)

```
docker login -u 用户名 -p 密码                                 #登陆 执行：docker login -uwwweeeiii
docker logout -u 用户名 -p 密码                                #登出
docker tag images_demo:v1.0.0 wwweeeiii/images_demo:v1.0.0   #docker tag 本地镜像:本地镜像 tag 远程仓库/远程镜像:远程镜像 tag
docker push wwweeeiii/images_demo:v1.0.0                     #docker push 远程仓库/远程镜像:远程镜像 tag
```

2. 阿里云仓库

[阿里云仓库地址](https://cr.console.aliyun.com/cn-hangzhou/instance/repositories)
```
docker login --username=weimenghua123 --password=root registry.cn-hangzhou.aliyuncs.com
docker tag mongo registry.cn-hangzhou.aliyuncs.com/weimmmhhh/images_demo:v1.0.0
docker push registry.cn-hangzhou.aliyuncs.com/weimmmhhh/images_demo:v1.0.0
```

3. 百度云仓库

镜像地址：https://mirror.baidubce.com

```
docker login --username=20fe83c825d94766815bfeae696cb954 --password=root registry.baidubce.com
docker tag portainer/portainer registry.baidubce.com/wwweeeiii/images_demo:v1.0.0
docker push registry.baidubce.com/wwweeeiii/images_demo:v1.0.0
```

4. 腾讯云仓库

[腾讯云仓库地址](https://console.cloud.tencent.com/tcr/repository)

```
登录腾讯云容器镜像服务 Docker Registry
docker login ccr.ccs.tencentyun.com --username=100026920351

从 Registry 拉取镜像
docker pull ccr.ccs.tencentyun.com/weimmmhhh/demo:[tag]

向 Registry 中推送镜像
docker tag [imageId] ccr.ccs.tencentyun.com/weimmmhhh/demo:[tag]
docker push ccr.ccs.tencentyun.com/weimmmhhh/demo:[tag]
```

5. 华为云仓库

[华为云镜像地址](https://mirrors.huaweicloud.com/home)

6. 南京大学镜像

镜像地址：https://docker.nju.edu.cn

7. Gitlab 仓库

GitLab用户名和密码来进行身份认证
```
docker login registry.jihulab.com
docker build -t registry.jihulab.com/iewiewiew/learn-gitlab .
docker push registry.jihulab.com/iewiewiew/learn-gitlab
```



## 5. Dockerfile

[Dockerfile 仓库](https://github.com/dockerfile)

### 5.1 例子

```
FROM nginx
RUN echo '这是一个本地构建的 nginx 镜像'
  
docker build . -f Dockfile -t images_demo:v1.0.0 
```

### 5.2 说明

```
docker build -t redis:v2 .

docker build --pull centos:v2 -f Dockerfile 
加上 --pull 时，Dockerfile 文件中 的 From 基础镜像 可能不会使用本地已下载好的镜像，而是会去远程 docker 仓库检查 Dockerfile 中的基础镜像 是不是 latest 的，如果不是，就会下载 最新的镜像作为基础镜像。

FROM nginx
RUN echo '这是一个本地构建的 nginx 镜像' > /usr/share/nginx/html/index.html

. 上下文路径，是指 docker 在构建镜像，有时候想要使用到本机的文件（比如复制），docker build 命令得知这个路径后，会将路径下的所有内容打包。
docker build -t nginx:v3 .

#shell 格式：RUN <命令行命令>
#<命令行命令> 等同于在终端操作的 shell 命令

#exec 格式：RUN ["可执行文件", "参数1", "参数2"]
#RUN ["./test.php", "dev", "offline"] 等价于 RUN ./test.php dev offline

RUN
RUN 命令是创建 Docker 镜像（image）的步骤，RUN 命令对 Docker 容器（ container）造成的改变是会被反映到创建的 Docker 镜像上的。一个 Dockerfile 中可以有许多个 RUN 命令。

CMD
CMD 命令是当 Docker 镜像被启动后 Docker 容器将会默认执行的命令。一个 Dockerfile 中只能有一个 CMD 命令。通过执行 docker run imageother_command 启动镜像可以重载 CMD 命令。
```



## 6. Docker-Compose

### 6.1 安装

[下载地址](https://github.com/docker/compose/releases)

```
下载 docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose                          #添加执行权限

ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose     #设置软连接

docker-compose --version                                        #查看版本
```

### 6.2 命令

```
docker-compose ps                       #ps：列出所有运行容器
docker-compose logs                     #logs：查看服务日志输出
docker-compose port <容器名称> 8761      #port：打印绑定的公共端口，下面命令可以输出<容器名称> 服务8761端口所绑定的公共端口
docker-compose build                    #build：构建或者重新构建服务
docker-compose start <容器名称>          #start：启动指定服务已存在的容器
docker-compose stop <容器名称>           #stop：停止已运行的服务的容器
docker-compose stop                     #stop：停止容器
docker-compose up                       #up：构建、启动容器
docker-compose up -d                    #-d：后台运行
docker-compose rm <容器名称>             #rm：删除指定服务的容器
docker-compose kill <容器名称>           #kill：通过发送 SIGKILL 信号来停止指定服务的容器
docker-compose scale user=3 movie=3     #pull：下载服务镜像, scale：设置指定服务运行容器的个数，以 service=num 形式指定
docker-compose run web bash             #run：在一个服务上执行一个命令
docker-compose --version                #测试是否安装成功
```

指定文件启动容器
```
docker-compose -f <compose-file> <command>
docker-compose -f docker-compose-mysql.yml up -d
```

踩坑：
1、docker 挂载目录后无权限访问目录，原因是 docker 创建目录默认用户 id 是1000，需在宿主机创建一个用户 id 和组 id 为1000的用户才行。
2、MySQL 初始化数据后，中文数据乱码，在 yml 加上以下参数：
```
command: [
'--character-set-server=utf8mb4',
'--collation-server=utf8mb4_general_ci'
]
```

[docker-compose example](https://github.com/docker/awesome-compose)

例子 (注：未实践成功)
```
git clone https://github.com/docker/awesome-compose.git

cd awesome-compose/nginx-golang-mysql

docker-compose up -d
```

[docker-compose 可视化页面](https://github.com/louislam/dockge)

docker-compose 和 docker compose 的区别

[官方文档解释](https://docs.docker.com/compose/install/linux/)

"Docker Compose" 和 "docker-compose" 实际上是指同一个工具，用于定义和运行多个 Docker 容器的应用程序。

在较早的版本中，使用的是名为 "docker-compose" 的命令来操作 Docker Compose 工具。然而，从 Docker Compose 1.27 版本开始，官方将其命令更改为 "docker compose"，并将其作为 Docker CLI 的子命令。



## 7. 知识碎片

### 7.1 Docker 可视化

1. portainer

```
docker search portainer                         #搜索镜像
docker pull portainer/portainer                 #下载镜像

docker run -p 9000:9000 -p 8000:8000 --name portainer \
--restart=always \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /usr/local/docker/portainer/data:/data \
-d portainer/portainer

http://127.0.0.1:9000/#!/home                   #访问
```

2. DockerUI

```
docker run -d --name docker.ui --restart always -v /var/run/docker.sock:/var/run/docker.sock -p 8111:8999 joinsunsoft/docker.ui
```

http://127.0.0.1:8111/ ginghan 123456

### 7.2 踩坑

运行容器使报错
```
standard_init_linux.go:178: exec user process caused "exec format error"
WARNING: The requested image's platform (linux/arm64/v8) does not match the detected host platform (linux/amd64) and no specific platform was requested
```

原因：镜像系统架构和主机系统架构不一致
tips：查看系统架构命令 `uname -a`

