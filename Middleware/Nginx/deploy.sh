#!/bin/bash

set -e

CONTAINER_NAME="nginx-upload"
IMAGE_NAME="nginx-upload:latest"
PORT="8888"
DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$DIR/html"
if [ ! -d "$DIR/uploads" ]; then
    mkdir -p "$DIR/uploads"
fi

docker stop "$CONTAINER_NAME" 2>/dev/null || true
docker rm "$CONTAINER_NAME" 2>/dev/null || true

docker build -t "$IMAGE_NAME" "$DIR"

docker run -d \
    --name "$CONTAINER_NAME" \
    -p "$PORT:80" \
    -v "$DIR/uploads:/usr/share/nginx/html/uploads" \
    --restart unless-stopped \
    "$IMAGE_NAME"

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
echo "访问地址: http://localhost:${PORT}"
if [ -n "$PUBLIC_IP" ]; then
    echo "公网 IP: http://${PUBLIC_IP}:${PORT}"
fi
