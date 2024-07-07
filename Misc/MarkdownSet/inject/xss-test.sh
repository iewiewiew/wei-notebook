#!/usr/bin/env bash
# XSS payload 测试辅助脚本
# 用法:
#   ./xss-test.sh list              # 列出所有 payload
#   ./xss-test.sh curl <url>        # 将 payload 作为 query 参数发送 GET 请求
#   ./xss-test.sh post <url> <field> # 将 payload 作为 POST 表单字段发送

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PAYLOAD_FILE="${SCRIPT_DIR}/xss-payloads.txt"

read_payloads() {
  grep -v '^#' "$PAYLOAD_FILE" | grep -v '^[[:space:]]*$' || true
}

cmd_list() {
  echo "=== XSS Payloads (${PAYLOAD_FILE}) ==="
  local i=1
  while IFS= read -r line; do
    printf '%3d  %s\n' "$i" "$line"
    i=$((i + 1))
  done < <(read_payloads)
}

cmd_curl() {
  local url="${1:?用法: $0 curl <url>}"
  echo "目标: $url"
  echo "---"
  while IFS= read -r payload; do
    echo "[GET] q=$(printf '%s' "$payload" | head -c 60)..."
    curl -sS -o /dev/null -w "  status=%{http_code}\n" \
      --get "$url" --data-urlencode "q=$payload" || true
  done < <(read_payloads)
}

cmd_post() {
  local url="${1:?用法: $0 post <url> <field>}"
  local field="${2:-content}"
  echo "目标: $url  字段: $field"
  echo "---"
  while IFS= read -r payload; do
    echo "[POST] $field=$(printf '%s' "$payload" | head -c 60)..."
    curl -sS -o /dev/null -w "  status=%{http_code}\n" \
      -X POST "$url" --data-urlencode "${field}=${payload}" || true
  done < <(read_payloads)
}

usage() {
  cat <<EOF
用法:
  $0 list
  $0 curl  <url>
  $0 post  <url> [field_name]

示例:
  $0 list
  $0 curl  'http://localhost:3000/search'
  $0 post  'http://localhost:3000/api/comment' content
EOF
}

case "${1:-}" in
  list) cmd_list ;;
  curl) cmd_curl "${2:-}" ;;
  post) cmd_post "${2:-}" "${3:-content}" ;;
  *) usage; exit 1 ;;
esac
