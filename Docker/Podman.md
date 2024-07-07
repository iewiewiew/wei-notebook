[TOC]

<h1 align="center">Podman</h1>

> By：weimenghua  
> Date：2023.12.01  
> Description：  

**参考资料**  
[Podman 官网](https://podman.io/)



### 1. 安装

```
yum -y install podman

podman version
```

默认情况下，Podman 配置有两个容器注册表： quay.io、docker.io

默认的 Podman 容器注册表配置：cat /etc/containers/registries.conf



### 2. 使用

常用命令
```
podman pull docker.io/nginx
podman pull quay.io/quay/busybox

podman run -dt -p 8080:80/tcp docker.io/library/httpd

podman ps

podman container checkpoint <container_id>

podman container restore <container_id>

curl http://<IP_address>:8080
curl http://127.0.0.1:8080

podman inspect <container_name>

podman rm <container_id>

podman login docker.io
```

常用命令
```
podman inspect -l

podman logs -l

podman top -l

podman port -l
```


Podman 容器存储
1. 对于root 用户，容器存储在 /var/lib/containers/storage目录中
2. 对于其他用户，容器存储在 $HOME/.local/share/containers/storage/目录中