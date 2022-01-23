[TOC]

<h1 align="center">Gitaly</h1>

> By：weimenghua  
> Date：2023.06.03  
> Description：

**参考资料**  
[Gitaly 文档](https://docs.gitlab.com/ee/administration/gitaly/)



## Gitaly 简介
Gitaly 提供对 Git 存储库的高级 RPC 访问。 GitLab 使用它来读取和写入 Git 数据。 Gitaly 存在于每个 GitLab 安装中，并协调 Git 存储库的存储和检索。 Gitaly 可以是：在单个实例上运行的后台服务 Omnibus GitLab（一台机器上的所有 GitLab）。 根据扩展和可用性要求，分离到自己的实例并配置为完整的集群配置。
在 Gitaly 文档中：
- Gitaly 服务器是指任何本身运行 Gitaly 的节点.
- Gitaly 客户端指的是任何运行向 Gitaly 服务器发出请求的进程的节点. 流程包括但不限于：
- - GitLab Rails 应用程序 .
  - GitLab 外壳 .
  - 亚搏体育 app Labhorse .
GitLab 最终用户无法直接访问 Gitaly. Gitaly 仅管理 GitLab 的 Git 存储库访问. 其他类型的 GitLab 数据无法使用 Gitaly 访问.