[TOC]

<h1 align="center">Nexus</h1>

> By：weimenghua  
> Date：2023.05.29  
> Description：Nexus 代理仓库


找依赖包的流程： 首先在本地仓库中找，如果没命中，那么就找远程私服；远程私服的查找规则同样是先找 host 属性的私有库，然后再去找 proxy 属性的远程仓库；可以配置多个 proxy

Nexus 仓库类型介绍：  
默认安装有以下这几个仓库，在控制台也可以修改远程仓库的地址，第三方仓库等  
hosted（宿主仓库） ：存放本公司开发的 jar 包（正式版本、测试版本） 
proxy（代理仓库）：代理中央仓库、Apache 下测试版本的 jar 包  
group（组仓库）：使用时连接组仓库，包含 Hosted（宿主仓库）和 Proxy（代理仓库）  