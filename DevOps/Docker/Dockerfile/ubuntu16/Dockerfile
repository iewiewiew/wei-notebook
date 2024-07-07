# 基础镜像：Ubuntu 16.04
FROM ubuntu:16.04

# 维护者信息（可选）
MAINTAINER test <test@example.com>

# 安装 openssh-server 并配置
RUN apt update && \
    apt install -y openssh-server && \
    # 创建 SSH 运行目录
    mkdir -p /var/run/sshd && \
    # 允许 root 登录
    sed -i 's/^PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    # 禁用 DNS 反向解析（加速 SSH 连接）
    sed -i 's/#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config && \
    # 设置 root 密码为 123456
    echo 'root:123456' | chpasswd && \
    # 清理 apt 缓存（减小镜像体积）
    apt clean && rm -rf /var/lib/apt/lists/*

# 暴露 22 端口
EXPOSE 22

# 启动容器时启动 SSH 服务
CMD ["/usr/sbin/sshd", "-D"]