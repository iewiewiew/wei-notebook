[TOC]

---

<h1 align = "center">Bazaar 分布式版本控制系统</h1>

> By: weimenghua  
> Date: 2023.05.16  
> Description: Bazaar



### 一、Bazaar 简介

Bazaar 是一种分布式版本控制系统，类似于 Git 和 Mercurial。



### 二、Bazaar 安装

```
安装 bazaar （已废弃：brew install bazaar？）
brew install breezy

查看 bazaar 版本
bzr version

bzr whoami "wmh <1425615649@qq.com>"

cat ~/.config/breezy/breezy.conf
```



### 三、Bazaar 使用

```
创建仓库
bzr init bzr-repo

echo 123 > README.md

bzr add README.md

bzr commit -m "test"

推送到远程仓库
bzr push https://github.com/<username>/<repo-name>.git
bzr push https://<username>:<password>@github.com/<username>/<repo-name>.git
```
