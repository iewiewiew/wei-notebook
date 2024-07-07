[TOC]

<h1 align="center">Typst</h1>

> By：weimenghua  
> Date：2026.11.23  
> Description：Typst 排版语言在 Markdown 中的写法示例，代码块使用 ```` ```typst ```` 标记

**参考资料**  
[Typst 官网](https://typst.app/)  
[Typst 文档](https://typst.app/docs/)  
[Typst GitHub](https://github.com/typst/typst)  
[Tinymist（LSP / 预览 / 调试）](https://myriad-dreamin.github.io/tinymist/)

<a href="README.en.md">English</a> | <span>中文</span>

- [1. 最小文档](#1-最小文档)
- [2. 页面与中文字体](#2-页面与中文字体)
- [3. 结构：标题、目录、脚注、引用](#3-结构标题目录脚注引用)
- [4. 数学公式](#4-数学公式)
- [5. 表格与图表](#5-表格与图表)
- [6. 代码块与编程能力](#6-代码块与编程能力)
- [7. 常用命令](#7-常用命令)
- [8. Markdown 渲染器支持](#8-markdown-渲染器支持)

## 1. 最小文档

正文是标记模式，`= 标题`、`*粗体*`、`_斜体_`、`- 列表`，代码以 `#` 开头。

```typst
= 你好，Typst
这是一段正文，*粗体* 与 _斜体_ 可以直接写。

- 列表项一
- 列表项二
```

编译：`typst compile hello.typ hello.pdf`。

## 2. 页面与中文字体

中文排版的关键是**字体名写对**，写错不会报错，只会静默回退。

```typst
#set page(paper: "a4", margin: 2.4cm, numbering: "1")
#set text(font: ("PingFang SC", "Heiti SC"), size: 11pt, lang: "zh")
#set par(justify: true, leading: 0.8em, first-line-indent: (amount: 2em, all: true))
```

查看本机可用字体：`typst fonts | grep -i "pingfang"`。

## 3. 结构：标题、目录、脚注、引用

```typst
#set heading(numbering: "1.1")
#outline(title: [目录])

= 第一章 <sec-1>

正文里引用编号：见 @sec-1。脚注紧随其后#footnote[脚注编号自动递增。]
```

## 4. 数学公式

行内用单 `$`，独立公式用双 `$`。

```typst
行内 $E = m c^2$。

$ integral_0^1 x^2 dif x = 1/3 $

$ mat(1, 2; 3, 4) quad cases(x > 0 & => 1, x <= 0 & => 0) $
```

## 5. 表格与图表

`table.header()` 生成表头，`#figure` 包一层即可获得题注与编号。

```typst
#figure(
  table(
    columns: (2fr, 1fr, 1fr),
    align: (left, center, center),
    stroke: none,
    table.header([特性], [Typst], [LaTeX]),
    [编译速度], [毫秒级], [秒到分钟],
    [包管理], [内置], [TeX Live],
  ),
  caption: [Typst 与 LaTeX 的粗略对比],
) <tab-cmp>
```

## 6. 代码块与编程能力

Typst 内部可以直接写函数、循环、条件。

```typst
#let badge(color, body) = box(
  fill: color,
  inset: (x: 6pt, y: 3pt),
  radius: 3pt,
)[#text(size: 9pt, fill: white)[#body]]

#for (name, c) in (("Typst", rgb("#1f6feb")), ("Rust", rgb("#d1495b"))) [
  #badge(c)[#name] #h(4pt)
]
```

## 7. 常用命令

| 命令 | 作用 |
|---|---|
| `typst compile a.typ` | 生成同名 PDF |
| `typst watch a.typ a.pdf` | 保存即重编译 |
| `typst init @preview/xxx` | 从 Typst Universe 拉模板 |
| `typst query a.typ "<label>"` | 取文档中的结构化数据 |
| `typst fonts` | 列出可用字体 |
| `tinymist preview a.typ` | 浏览器实时预览 |

本目录下的完整可编译示例：[typst-demo.typ](typst-demo.typ)（产物 [typst-demo.pdf](typst-demo.pdf)）。

## 8. Markdown 渲染器支持

写 ```` ```typst ```` 之后能不能高亮，取决于渲染器是否认识这个语言标识：

| 渲染器 | 支持 | 说明 |
|---|---|---|
| GitHub | ✅ | linguist 已收录 Typst，别名 `typ` 也可用 |
| Shiki（VitePress / Astro） | ✅ | 需加载 `@shikijs/langs/typst` |
| VS Code 预览 | ✅ | 安装 Tinymist 扩展后生效 |
| Prism | ❌ | 官方包无 `prism-typst`，需自定义语法 |
| highlight.js | ❌ | 核心语言列表里没有 |
| Pandoc | ❌ | skylighting 未收录，回退为纯文本 |

渲染器不认识时把语言标记写成 `text`，页面不会报错，只是不着色。
