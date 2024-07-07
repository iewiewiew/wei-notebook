[TOC]

---

<h1 align="center">Hexo 博客主题</h1>

> By：weimenghua  
> Date：2023.02.12
> Description：Hexo

**参考资料**  
[Hexo 官网](https://hexo.io/zh-cn/)



**Hexo 搭建教程**

1. 安装 Git
2. 安装 Node.js
3. 安装 Hexo
4. GitHub 创建个人仓库
5. 将 Hexo 部署到 GitHub
6. 更改主题
7. 发布文章



**安装 Hexo**

```
1、安装 Hexo
npm install -g hexo-cli
npm install hexo
hexo -v


2、初始化 Hexo
hexo init <dirName>
cd <dirName>
npm install

生成文件夹
node_modules: 依赖包
public：存放生成的页面
scaffolds：生成文章的一些模板
source：用来存放你的文章
themes：主题
_config.yml: 博客的配置文件


3、启动 Hexo
hexo clean
hexo generate
hexo server


4、访问 Hexo
http://localhost:4000/
```



**将 Hexo 部署到 GitHub**

```
1、在 Github 新建一个和用户名同名的仓库


2、在_config.yml 配置
language: zh-CN

deploy:
  type: git
  repo: git@github.com:iewiewiew/iewiewiew.github.io.git
  branch: main
  
  
3、安装依赖
npm install hexo-deployer-git --save


4、部署 Hexo
hexo clean
hexo generate
hexo deploy


5、访问 Hexo
https://iewiewiew.github.io/
```



**更改主题**

```
1、https://github.com/cofess/hexo-theme-pure
在 themes 目录外执行：git clone https://github.com/cofess/hexo-theme-pure.git themes/pure
修改外层目录下的_config.yml：theme: pure
把 hexo/themes/pure/_sure 下的目录复制到 hexo/soure 下
在 hexo/themes/pure/_config.yml 下修改各种配置


2、https://hexo.fluid-dev.com/docs/
```



**发布文章**

```
1、发布新文章（注：后缀无需加 md，建议中中划线做分割）
新建文章
hexo new <postName>

新建页面
hexo new page <pageName>


2、在 source/_post 中打开 markdown 文件进行编辑
```



**主题**
Hux Blog

