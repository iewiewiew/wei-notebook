#!/bin/bash
EXPONENT=3
SIZE=2048
# 生成 RSA 密钥对，并将私钥和公钥分别保存到文件中
openssl genpkey -algorithm RSA -out private_key.pem -pkeyopt rsa_keygen_bits:$SIZE -pkeyopt rsa_keygen_pubexp:$EXPONENT
openssl rsa -in private_key.pem -pubout -out public_key.pem
# 将私钥和公钥转换成 Base64 编码，并保存到文件中
base64 -w0 private_key.pem > private_key.base64
base64 -w0 public_key.pem > public_key.base64
echo ""
echo "-------------------------------------- Base64 公私钥------------------------------------------"
echo "Base64 Private key:"
cat private_key.base64
echo ""
echo "Base64 Public key:"
cat public_key.base64
echo ""
echo "---------------------------------------- 原始 公私钥 -----------------------------------------"
echo "Raw Public key:"
cat public_key.pem | sed -e '1d' -e '$d' | tr -d '\n'
echo ""
echo "Raw Private key:"
cat private_key.pem | sed -e '1d' -e '$d' | tr -d '\n'
echo ""