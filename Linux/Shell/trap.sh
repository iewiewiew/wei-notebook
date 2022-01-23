#!/bin/bash

# 常见的信号名称及其对应的含义：
# SIGHUP：挂起信号，通常在终端连接断开时发送给进程。
# SIGINT：中断信号，通常由用户按下Ctrl+C发送给前台进程。
# SIGQUIT：退出信号，通常由用户按下Ctrl+\发送给前台进程。
# SIGTERM：终止信号，通常用于请求进程正常终止。
# SIGKILL：强制终止信号，无法被阻塞或处理，可用于强制终止进程。
# SIGUSR1、SIGUSR2：用户自定义信号。

# 定义一个函数，用于处理 SIGINT 信号
cleanup() {
    echo "收到 SIGINT 信号，执行清理操作..."
    # 在这里添加你的清理逻辑，比如关闭文件、释放资源等
    exit 0
}

# 使用 trap 命令捕捉 SIGINT 信号，并指定处理函数为 cleanup
trap cleanup SIGINT

echo "运行中，请按下 Ctrl+C 组合键退出..."

# 模拟一个长时间运行的操作
sleep 10

# 如果没有收到 SIGINT 信号，则继续执行下面的逻辑
echo "长时间运行的操作完成。"