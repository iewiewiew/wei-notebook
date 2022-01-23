[TOC]

---

<h1 align = "center">Github + Gitee 代码托管</h1>

> By: weimenghua  
> Date: 2022.07.04  
> Description: Github + Gitee



1. 在项目页面，按 `。` 进入在线编辑器，举例：https://github.dev/iewiewiew/Learn-Java
2. 在 github 后加1s，举例：https://github1s.com/iewiewiew/wei-notebook
3. 在具体页面，按 `L` 输入行号跳转到对应行
4. 按 `ctrl + k` 快速查看内容
5. 在项目地址前加上 `gitpod.io` 可在线运行项目，举例：https://gitpod.io/github.com/iewiewiew/Learn-Java
6. 树状查看 github 插件：Octotree
7. 树状查看 gitee 插件：GitCodeTree
8. 查看 github 仓库大小：https://github.com/settings/repositories



### github
[github packages](https://docs.github.com/en/packages)  
[github 的镜像仓库地址](https://ghcr.io)

```
docker login ghcr.io -u USERNAME -p TOKEN

docker tag IMAGE_NAME:TAG ghcr.io/USERNAME/REPO_NAME:TAG

docker push ghcr.io/USERNAME/REPO_NAME:TAG

docker pull ghcr.io/USERNAME/REPO_NAME:TAG
```