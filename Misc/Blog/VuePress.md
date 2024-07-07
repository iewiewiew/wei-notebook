[TOC]

<h1 align="center">VuePress 博客主题</h1>

> By：weimenghua  
> Date：2023.04.15  
> Description：VuePress  

**参考资料**  
[VuePress 官网](https://vuepress.vuejs.org/zh/)  
[VuePress2 官网](https://v2.vuepress.vuejs.org/zh/)  
注: 以下使用 VuePress2



### 环境搭建

#### VuePress
```
# 在项目中安装
npm install -D vuepress@next

# 新建一个 markdown 文件
echo '# Hello VuePress' > README.md

# 开始写作
cd blog/docs
npx vuepress dev

# 构建静态文件
npx vuepress build
```

#### VuePress2
```
在 package.json 中添加一些 scripts
{
  "scripts": {
    "docs:dev": "vuepress dev docs",
    "docs:build": "vuepress build docs",
}

说明
"scripts": {
  "docs:dev": "vitepress dev docs",     // 本地运行调试
  "docs:build": "vitepress build docs", // 项目打包：最终结果会在 .vitepress/dist 中
},
```

```
创建第一篇文档
mkdir docs
echo '# Hello VuePress' > docs/README.md

启动
npm run docs:dev
```

#### 安装依赖
```
npm install -D vuepress
npm install -D vuepress-webpack@next
npm install -D vuepress-plugin-auto-sidebar
npm install -D vuepress-plugin-baidu-autopush
npm install -D vuepress-plugin-clean-urls
npm install -D vuepress-plugin-seo
npm install -D vuepress-plugin-sitemap
npm install -D vuepress-plugin-smooth-scroll

npm install -D vue-template-compiler
npm install -D moment
npm install -D moment-timezone
```

### 其它
热加载 --temp .temp  
"docs:dev": "vuepress dev docs --temp .temp",

