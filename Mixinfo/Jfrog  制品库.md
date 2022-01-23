[TOC]

<h1 align="center">Jfrog 制品库</h1>

> By：weimenghua  
> Date：2023.07.02  
> Description：  


**参考资料**  
[Jfrog 官网](https://www.jfrogchina.com/)



## 一、Jfrog 搭建

[Jfrog 搭建教程](https://jfrog.com/help/r/jfrog-installation-setup-documentation/installing-artifactory)

```
运行容器
docker volume create --name artifactory_data
docker run -d --name artifactory -p 8081:8081 -p 8082:8082 -v artifactory_data:/var/opt/jfrog/artifactory docker.bintray.io/jfrog/artifactory-oss:latest

访问地址 原：admin/password 新：admin/Admin123
http://127.0.0.1:8082
```



## 二、Jfrog 使用

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

![](./img/jfrog_artifactory.png)
