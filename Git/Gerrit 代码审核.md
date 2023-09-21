[TOC]

<h1 align="center">Gerrit 代码审核</h1>

> By：weimenghua   
> Date：2023.04.18  
> Description：Gerrit  

**参考资料**  
[Gerrit 官网](https://www.gerritcodereview.com/)



### 一、Gerrit 简介

Gerrit，一种免费、开放源代码的代码审查软件，使用网页界面。利用网页浏览器，同一个团队的软件程序员，可以相互审阅彼此修改后的程序代码，决定是否能够提交，退回或者继续修改。



### 二、Gerrit 安装

```
brew install git-gerrit

在 IDEA 插件搜索 Gerrit 插件进行安装
```

[Gerrit 快速开始](https://gerrit-documentation.storage.googleapis.com/Documentation/3.7.2/linux-quickstart.html)

```
wget https://gerrit-releases.storage.googleapis.com/gerrit-3.7.2.war

export GERRIT_SITE=~/gerrit_testsite
java -jar gerrit*.war init --batch --dev -d $GERRIT_SITE
```

