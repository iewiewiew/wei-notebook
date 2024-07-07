[TOC]

<h1 align="center">CICD_Tool</h1>

> By：weimenghua  
> Date：2023.10.17  
> Description：  



## 1. GiteeGo

[示例代码库](https://gitee.com/gitee-go)

[测试 GiteeGo 仓库](https://gitee.com/iewiewiew/wei-test-giteego)

本地推送仓库到远程  
`git remote add test https://gitee.com/test/wei-test-giteego.git`

**镜像构建**  
- 仓库地址：docker.io 或者 docker.io/wwweeeiii
- 仓库用户名：wwweeeiii
- 仓库密码：******
- 镜像 Tag：wwweeeiii/images_demo:v1.${GITEE_PIPELINE_BUILD_NUMBER} 或者 images_demo:v1.${GITEE_PIPELINE_BUILD_NUMBER} 注：如果在仓库地址没有拼接用户名，则在镜像 Tag 进行拼接
- Dockerfile 路径：./Dockerfile
- [DockerHub-wwweeeiii 仓库](https://hub.docker.com/repository/docker/wwweeeiii/)

![](./img/image_build.png)

登录 Hub
`docker login -uwwweeeiii -ppassword docker.io`

Dockerfile 例子
```
FROM alpine:latest

RUN bash -c 'ls -l'

ARG TEST1=aaa
ARG TEST2=bbb

RUN echo "TEST1=${TEST1}"
RUN echo "TEST2=${TEST2}"
```

**K8S 部署**
- 添加 KubeConfig：cat ~/.kube/config
- 命名空间：自定义，默认 default
- YAML 路径：./deployment.yaml 或者 ./nginx-deployment/deployment.yaml
- 勾选使用Replace模式 / 有时候会出现错误，需要去掉勾选(原因未知)
- 勾选跳过 TLS 校验

![](./img/k8s_deploy.png)

deployment.yaml 例子
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```

**Helm Chart部署**
- 命名空间：自定义，默认 default
- 应用名：自定义，例如 nginx
- Chart 文件目录：[./nginx](../Kubernetes/Helm/nginx)
- 指定values.yaml：./nginx/values.yaml

![](./img/helm_deploy.png)



## 2. ZadigX

**参考资料**  
[Zadig 官网](https://koderover.com/)    
[Zadig 帮助文档](https://docs.koderover.com/?type=zadig)



[安装 ZadigX](https://koderover.com/trial)

```
helm repo add koderover-chart https://koderover.tencentcloudcr.com/chartrepo/chart \
&& helm repo update \
&& helm upgrade --install --create-namespace -n my-space --set global.extensions.extAuth.extauthzServerRef.namespace=my-space --set endpoint.type=IP --set endpoint.IP=127.0.0.1 --set gloo.gatewayProxies.gatewayProxy.service.type=NodePort --set gloo.gatewayProxies.gatewayProxy.service.httpNodePort=30000 --set dex.fullnameOverride=zadig-my-space-dex --set dex.config.issuer=http://zadig-my-space-dex:5556/dex --set "dex.config.staticClients[0].redirectURIs[0]=http://127.0.0.1:30000/api/v1/callback,dex.config.staticClients[0].id=zadig,dex.config.staticClients[0].name=zadig,dex.config.staticClients[0].secret=ZXhhbXBsZS1hcHAtc2VjcmV0"  --set init.adminPassword=Zadig123 --set init.adminEmail=1425615649@qq.com --set mysql.persistence.pv=true --set tags.mysql=true --set mysql.persistence.size=20Gi --set mongodb.persistence.pv=true --set connections.mongodb.db=zadig --set tags.mongodb=true --set mongodb.persistence.size=20Gi --set minio.persistence.pv=true  --set tags.minio=true --set minio.persistence.size=20Gi zadigx-my-space koderover-chart/zadigx
```

查看日志
```
kubectl logs -f aslan-7475f675bf-6vfmr -c aslan -n my-space
```

![](./img/zadigx.png)



## 3. TeamCity

注：未实践成功  
[TeamCity 下载](https://www.jetbrains.com/teamcity/)   
[TeamCity 教程](https://www.jetbrains.com/zh-cn/teamcity/learn/)

```
docker run --name teamcity-server-instance \
-v <path to data directory>:/data/teamcity_server/datadir \
-v <path to logs directory>:/opt/teamcity/logs \
-p <port on host>:8111 \
jetbrains/teamcity-server
```



## 4. Buddy

[Buddy](https://buddy.works/)

![](../Jenkins/img/Buddy.png)



## 5. Tekon

- [Tekton 官网](https://tekton.dev/)
- [Tekton 源码](https://github.com/tektoncd)

```
kubectl apply -f https://storage.googleapis.com/tekton-releases/operator/latest/release.yaml
```



## 6. Argo

- [Argo 官网](https://argoproj.github.io/)
- [Argo Github](https://github.com/argoproj)
- [Argo CD 使用指南](https://kubeoperator.io/docs/user_manual/argocd/)

Argo CD 是一个为 Kubernetes 而生的，遵循声明式 GitOps 理念的持续部署（CD）工具。Argo CD 可在 Git 存储库更改时自动同步和部署应用程序。

选择版本：https://github.com/argoproj/argo-workflows/releases
```
kubectl create namespace argo
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v<<ARGO_WORKFLOWS_VERSION>>/quick-start-minimal.yaml
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.5.5/quick-start-minimal.yaml

查看部署情况
kubectl -n argo get pod

通过 Service argocd-server 来访问可视化界面
kubectl -n argo get svc
kubectl port-forward svc/argocd-server -n argo 8080:443

获取密码
kubectl -n argo get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

修改密码
argo account update-password --account admin --current-password xxxx --new-password xxxx
```

```
kubectl apply -f argo_example.yml
```



## 7. 阿里云效

[阿里云效](https://flow.aliyun.com)

阿里云效流水线接入智能排查助手



## 8. 制品 Repo

### 1. 制品库简介

什么是制品库 制品库用以管理源代码编译后的构建产物，支持Docker、Maven、Helm、npm、PyPI 包等常见制品库类型。 制品库可以跟源代码协同进行版本化控制，可以与本地各构建工具和云上的持续集成、持续部署无缝结合，并支持漏洞扫描等特性，是一种企业处理软件开发过程中产生的所有包类型的标准化方式。

### 2. Jfrog

#### 2.1 Jfrog 搭建

**参考资料**
[Jfrog 官网](https://www.jfrogchina.com/)
[Jfrog 搭建教程](https://jfrog.com/help/r/jfrog-installation-setup-documentation/installing-artifactory)

```
运行容器
docker volume create --name artifactory_data
docker run -d --name artifactory -p 8081:8081 -p 8082:8082 -v artifactory_data:/var/opt/jfrog/artifactory docker.bintray.io/jfrog/artifactory-oss:latest

访问地址 原：admin/password 新：admin/Admin123
http://127.0.0.1:8082
```

#### 2.2 Jfrog 使用

上传
```
通用格式
curl -T <filename> http://admin:password@服务地址+仓库路径+文件名

范例
curl -T tmp.txt "http://admin:Admin123@127.0.0.1:8082/artifactory/example-repo-local/tmp.txt"
```

下载
```
通用格式
http://admin:password@服务地址+仓库路径+文件名

范例：
http://admin:Admin123@ip:8082/artifactory/tom-data1/example-repo-local/tmp.txt
```

![](../Mixinfo/img/jfrog-artifactory.png)

### 3. Coding Repo

[Coding Repo 帮助文档](https://coding.net/help/docs/artifacts/intro.html)

[测试仓库](https://gitee.com/iewiewiew/wei-test-giteego)

### 4. Gitee Repo

[Gitee Repo 简介](https://gitee.com/repo)  
[Gitee Repo 帮助文档](https://osc.gitee.work/help/#/repo/)