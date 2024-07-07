#!/bin/bash
# 测试Shell脚本文件
# 这是一个用于知识库测试的Shell示例文件

function hello_world() {
    echo "Hello, World!"
}

function greet() {
    local name=$1
    echo "Hello, $name!"
}

# 使用示例
hello_world
greet "Gitee"

