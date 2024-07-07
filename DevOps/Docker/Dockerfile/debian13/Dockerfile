FROM swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/library/debian:12

LABEL maintainer="test <test@example.com>"

RUN set -eux; \
    touch /etc/apt/sources.list; \
    cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    > /etc/apt/sources.list; \
    echo "deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware" >> /etc/apt/sources.list; \
    echo "deb http://deb.debian.org/debian bookworm-backports main contrib non-free" >> /etc/apt/sources.list; \
    apt update -o Acquire::CompressionTypes::Order::=gz -y; \
    apt install -t bookworm-backports openssh-client=10.2p1-2~bpo12+1 -y; \
    apt clean; \
    rm -rf /var/lib/apt/lists/*; \
    ssh -V 2>&1 | grep -q "OpenSSH"

CMD ["sh", "-c", "ssh -V 2>&1 && echo '=== OpenSSH 安装成功 ==='"]