[TOC]

<h1 align="">kubeval yaml 检查工具</h1>

> By：weimenghua
> Date：2024.01.08
> Description：

**参考资料**  
[kubeval](https://kubeval.instrumenta.dev/)



## 安装
```
wget https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz
tar xf kubeval-linux-amd64.tar.gz
sudo cp kubeval /usr/local/bin
```

```
docker run -it -v `pwd`/fixtures:/fixtures garethr/kubeval fixtures/*

fixtures/* 为 yaml 文件路径
```
