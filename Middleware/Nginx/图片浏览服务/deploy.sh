#!/bin/bash

set -e

DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$DIR/html"
if [ ! -d "$DIR/uploads" ]; then
    mkdir -p "$DIR/uploads"
fi

docker stop "nginx-upload" 2>/dev/null || true
docker rm "nginx-upload" 2>/dev/null || true

docker build -t "nginx-upload:latest" "$DIR"

docker run -d \
    --name "nginx-upload" \
    -p "8888:80" \
    -v "$DIR/uploads:/usr/share/nginx/html/uploads" \
    --restart unless-stopped \
    "ginx-upload:latest"

# 获取公网 IP
get_public_ip() {
    for service in "ifconfig.me" "ipinfo.io/ip" "icanhazip.com" "api.ipify.org"; do
        ip=$(curl -s --connect-timeout 2 --max-time 5 "https://$service" 2>/dev/null || curl -s --connect-timeout 2 --max-time 5 "http://$service" 2>/dev/null || true)
        if [ -n "$ip" ] && echo "$ip" | grep -qE '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$'; then
            echo "$ip"
            return 0
        fi
    done
    echo ""
}

PUBLIC_IP=$(get_public_ip)

echo "部署完成！"
echo "访问地址: http://localhost:8888"
if [ -n "$PUBLIC_IP" ]; then
    echo "公网 IP: http://${PUBLIC_IP}:8888
fi
