[TOC]

<h1 align="center">Repo</h1>

> By：weimenghua  
> Date：2023.07.02  
> Description：Repo 制品库 



## 一、制品库简介
什么是制品库 制品库用以管理源代码编译后的构建产物，支持Docker、Maven、Helm、npm、PyPI 包等常见制品库类型。 制品库可以跟源代码协同进行版本化控制，可以与本地各构建工具和云上的持续集成、持续部署无缝结合，并支持漏洞扫描等特性，是一种企业处理软件开发过程中产生的所有包类型的标准化方式。



## 二、Jfrog
### 1. Jfrog 搭建

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

### 2. Jfrog 使用

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

![](../Mixinfo/img/jfrog_artifactory.png)



## 三、Coding Repo

[Coding Repo 帮助文档](https://coding.net/help/docs/artifacts/intro.html)

[测试仓库](https://gitee.com/iewiewiew/wei-test-giteego)



## 四、Gitee Repo

[Gitee Repo 简介](https://gitee.com/repo)

[Gitee Repo 帮助文档](https://osc.gitee.work/help/#/repo/)