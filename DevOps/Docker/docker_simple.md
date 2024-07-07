# Docker 容器常用命令

## 容器管理

### 查看容器
```bash
# 查看运行中的容器
docker ps

# 查看所有容器（包括已停止的）
docker ps -a

# 查看容器详细信息
docker inspect <container_id>
```

### 创建和启动容器
```bash
# 创建并启动容器
docker run -d --name <container_name> <image_name>

# 创建并启动容器（映射端口）
docker run -d -p <host_port>:<container_port> --name <container_name> <image_name>

# 创建并启动容器（挂载数据卷）
docker run -d -v <host_path>:<container_path> --name <container_name> <image_name>
```

### 停止和删除容器
```bash
# 停止容器
docker stop <container_id>

# 启动已停止的容器
docker start <container_id>

# 重启容器
docker restart <container_id>

# 删除容器
docker rm <container_id>

# 强制删除运行中的容器
docker rm -f <container_id>
```

## 镜像管理

### 查看镜像
```bash
# 查看本地镜像
docker images

# 查看镜像详细信息
docker inspect <image_name>
```

### 拉取和推送镜像
```bash
# 拉取镜像
docker pull <image_name>:<tag>

# 推送镜像到仓库
docker push <image_name>:<tag>
```

### 构建镜像
```bash
# 使用 Dockerfile 构建镜像
docker build -t <image_name>:<tag> .

# 指定 Dockerfile 路径
docker build -f <dockerfile_path> -t <image_name>:<tag> .
```

## 日志和调试

### 查看日志
```bash
# 查看容器日志
docker logs <container_id>

# 实时查看日志
docker logs -f <container_id>

# 查看最近100行日志
docker logs --tail 100 <container_id>
```

### 进入容器
```bash
# 进入运行中的容器
docker exec -it <container_id> /bin/bash

# 进入容器（使用 sh）
docker exec -it <container_id> /bin/sh
```

## 数据卷管理

### 创建和管理数据卷
```bash
# 创建数据卷
docker volume create <volume_name>

# 查看数据卷列表
docker volume ls

# 查看数据卷详细信息
docker volume inspect <volume_name>

# 删除数据卷
docker volume rm <volume_name>
```

## 网络管理

### 查看网络
```bash
# 查看网络列表
docker network ls

# 查看网络详细信息
docker network inspect <network_name>
```

### 创建网络
```bash
# 创建网络
docker network create <network_name>

# 创建网络（指定驱动）
docker network create --driver bridge <network_name>
```

### 连接容器到网络
```bash
# 将容器连接到网络
docker network connect <network_name> <container_id>

# 断开容器与网络的连接
docker network disconnect <network_name> <container_id>
```

## Docker Compose

### 常用命令
```bash
# 启动服务
docker-compose up -d

# 停止服务
docker-compose down

# 查看服务状态
docker-compose ps

# 查看日志
docker-compose logs -f

# 重新构建并启动
docker-compose up -d --build
```

## 清理资源

### 清理未使用的资源
```bash
# 清理未使用的镜像、容器、网络和数据卷
docker system prune

# 清理所有未使用的资源（包括未使用的镜像）
docker system prune -a

# 清理未使用的数据卷
docker volume prune
```

## 常用技巧

### 导出和导入镜像
```bash
# 导出镜像为 tar 文件
docker save -o <file.tar> <image_name>

# 从 tar 文件导入镜像
docker load -i <file.tar>
```

### 导出和导入容器
```bash
# 导出容器为 tar 文件
docker export -o <file.tar> <container_id>

# 从 tar 文件导入为镜像
docker import <file.tar> <image_name>:<tag>
```

### 查看资源使用情况
```bash
# 查看容器资源使用情况
docker stats

# 查看指定容器的资源使用情况
docker stats <container_id>
```

