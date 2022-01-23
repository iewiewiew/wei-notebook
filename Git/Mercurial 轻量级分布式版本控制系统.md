[TOC]

---

<h1 align = "center">Mercurial 轻量级分布式版本控制系统</h1>

> By: weimenghua  
> Date: 2023.04.23  
> Description: Mercurial  

**参考资料**  
[Mercurial 官网](https://www.mercurial-scm.org/)  
[Mercurial 使用教程](https://wiki.mercurial-scm.org/ChineseTutorial)  



### 一、Mercurial 简介

Mercurial 是轻量级分布式版本控制系统，与 Git 类似。  



### 二、Mercurial 搭建

[Mercurial 下载](https://www.mercurial-scm.org/downloads)
```
Mac 安装 Mercurial
brew install mercurial

查看 Mercurial 帮助文档
hg help

查看 Mercurial 版本
hg version
```

Clone a project and push changes
```
hg clone https://www.mercurial-scm.org/repo/hello
$ cd hello
$ (edit files)
$ hg add (new files)
$ hg commit -m 'My changes'
$ hg push
```

Create a project and commit
```
$ hg init (project-directory)
$ cd (project-directory)
$ (add some files)
$ hg add
$ hg commit -m 'Initial commit'
```

Mercurial 基本命令
```
查看日志
hg log -v

查看状态
hg status

查看差异
hg diff
```