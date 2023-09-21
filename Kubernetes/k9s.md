[TOC]

<h1 align="center">k9s</h1>

> By：weimenghua  
> Date：2023.10.29  
> Description：不太会用  

**参考资料**  
[k9s 官网](https://k9scli.io/)



### 一、安装
```
安装 k9s
curl -sS https://webinstall.dev/k9s | bash

启动 k9s
cd .local/bin/
./k9s
```



### 二、使用
```
（1）列出所有可用的CLI选项
k9s help

（2）获取有关K9s运行时间的信息（日志、配置等）。
k9s info

（3）在一个现有的kubeconfig上下文中启动k9s
k9s --context <your_context>

（4）在指定的命名空间中运行k9s
k9s -n <your_namespace>

（5）以只读模式启动K9s--禁用所有集群修改命令
k9s --readonly
```