# Nginx 图片浏览服务

简单的 Docker 部署，支持浏览器浏览图片。

## 快速开始

```bash
chmod +x deploy.sh
./deploy.sh
```

访问: http://localhost:8888

## 上传图片

```bash
# 复制文件到本地目录
cp 图片.jpg uploads/

# 或复制到容器
docker cp 图片.jpg nginx-upload:/usr/share/nginx/html/uploads/
```

## 文件结构

```
├── Dockerfile      # 镜像构建
├── nginx.conf      # Nginx 配置
├── deploy.sh       # 部署脚本
├── html/           # HTML 文件
└── uploads/        # 图片目录
```
