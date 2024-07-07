[TOC]

<h1 align="center">markdown-example</h1>

> By：weimenghua  
> Date：2023.03.02  
> Description：Markdown 使用示例

**参考资料**  
[Markdonw 官网](https://www.markdownguide.org/)  
[Markdown 官方教程](https://markdown.com.cn/)

<a href="README.en.md">English</a> | <span>中文</span>



- [Markdown 标题语法](#markdown-标题语法)
- [Heading level 1](#heading-level-1)
  - [Heading level 2](#heading-level-2)
    - [Heading level 3](#heading-level-3)
      - [Heading level 4](#heading-level-4)
        - [Heading level 5](#heading-level-5)
          - [Heading level 6](#heading-level-6)
          - [123](#123)
          - [中文](#中文)
          - [中文 English](#中文-english)
          - [1.2.3 中文 English](#123-中文-english)
        - [重复标题](#重复标题)
          - [重复标题](#重复标题-1)
          - [重复标题](#重复标题-2)
- [Markdown 段落语法](#markdown-段落语法)
- [Markdown 换行语法](#markdown-换行语法)
- [Markdown 强调语法](#markdown-强调语法)
- [Markdown 引用语法](#markdown-引用语法)
- [Markdown 列表语法](#markdown-列表语法)
- [Markdown 代码语法](#markdown-代码语法)
- [Markdown 分隔线语法](#markdown-分隔线语法)
- [Markdown 链接语法](#markdown-链接语法)
- [Markdown 图片语法](#markdown-图片语法)
- [Markdown 转义字符语法](#markdown-转义字符语法)
- [Markdown 内嵌 HTML 标签](#markdown-内嵌-html-标签)
- [Markdown 表格](#markdown-表格)
- [Markdown 围栏代码块](#markdown-围栏代码块)
- [Markdown 脚注](#markdown-脚注)
- [Markdown 标题编号](#markdown-标题编号)
    - [My Great Heading {#my-great-heading}](#my-great-heading-my-great-heading)
- [Markdown 定义列表](#markdown-定义列表)
- [Markdown 删除线](#markdown-删除线)
- [Markdown 任务列表语法](#markdown-任务列表语法)
- [Markdown 使用 Emoji 表情](#markdown-使用-emoji-表情)
- [Markdown 自动网址链接](#markdown-自动网址链接)
- [Markdown 下划线](#markdown-下划线)
- [Markdown 上划线](#markdown-上划线)
- [Markdown 数据公式](#markdown-数据公式)
- [Markdown markups](#markdown-markups)
- [Markdown 标签](#markdown-标签)
- [Markdown Front Matter](#markdown-front-matter)
- [Markdown 拓展语法](#markdown-拓展语法)
  - [折叠](#折叠)
  - [提示](#提示)
  - [颜色](#颜色)
  - [隐藏有评论的内容](#隐藏有评论的内容)
  - [指定图像显示的主题](#指定图像显示的主题)
- [知识碎片](#知识碎片)
  - [Markdown 自动生成目录](#markdown-自动生成目录)
  - [Markdown 在线编辑器](#markdown-在线编辑器)
  - [Markdown 文档集合](#markdown-文档集合)
  - [Markdown 编写规范](#markdown-编写规范)
  - [其它](#其它)



# Markdown 标题语法

# Heading level 1
## Heading level 2
### Heading level 3
#### Heading level 4	
##### Heading level 5
###### Heading level 6
###### 123
###### 中文
###### 中文 English
###### 1.2.3 中文 English 
##### 重复标题
###### 重复标题
###### 重复标题



# Markdown 段落语法

I really like using Markdown.

I think I'll use it to format all of my documents from now on.



# Markdown 换行语法

This is the first line.    
And this is the second line.

注：因 docusaurus 不支持特殊字符，所以用代码块注释
```
换行1<br>换行2<br>
```
行尾双空格换行1  
行尾双空格换行2



# Markdown 强调语法

粗体（Bold）

I just love **bold text**.  
I just love __bold text__.  
Love**is**bold  

斜体（Italic）

Italicized text is the *cat's meow*.  
Italicized text is the _cat's meow_.  
A*cat*meow

粗体（Bold）和斜体（Italic）

This text is ***really important***.  
This text is ___really important___.  
This text is __*really important*__.  
This text is **_really important_**.  
This is really***very***important text.  

下标文本

This is a <sub>subscript</sub> text

上标文本

This is a <sup>superscript</sup> text



# Markdown 引用语法

要创建块引用，请在段落前添加一个 > 符号
> Dorothy followed her through many of the beautiful rooms in her castle.

多个段落的块引用
> Dorothy followed her through many of the beautiful rooms in her castle.
>
> The Witch bade her clean the pots and kettles and sweep the floor and keep the fire fed with wood.

嵌套块引用
> Dorothy followed her through many of the beautiful rooms in her castle.
>
>> The Witch bade her clean the pots and kettles and sweep the floor and keep the fire fed with wood.

带有其它元素的块引用
> #### The quarterly results look great!
>
> - Revenue was off the chart.
> - Profits were higher than ever.
>
>  *Everything* is going according to **plan**.



# Markdown 列表语法

1. 第一项
2. 第二项
3. 第三项

* 第一项
* 第二项
* 第三项

+ 第一项
+ 第二项
+ 第三项

- 第一项
- 第二项
- 第三项

1. 第一项：
    - 第一项嵌套的第一个元素
    - 第一项嵌套的第二个元素
2. 第二项：
    - 第二项嵌套的第一个元素
    - 第二项嵌套的第二个元素



# Markdown 代码语法

At the command prompt, type `nano`.  
``Use `code` in your Markdown file.``



# Markdown 分隔线语法

***

---

_________________



# Markdown 链接语法

这是一个链接 [Markdown 语法](https://markdown.com.cn)。  
这是一个链接 [Markdown 语法](https://markdown.com.cn "最好的 markdown 教程")。  

<https://markdown.com.cn>  
<fake@example.com>  
<a href="http://https://gitee.com">https://gitee.com</a>

I love supporting the **[EFF](https://eff.org)**.  
This is the *[Markdown Guide](https://www.markdownguide.org)*.  
See the section on [`code`](#code).  

[相对路径的 md](mix/markdown-inject.md)  
[相对路径的 png](./images/images1.png)



# Markdown 图片语法

`img/images1.png`

![这是图片 png](images/images1.png)

`./images/images2.png`

![这是图片 png](./images/images2.png)

`img/图片.png`

![这是图片 png](images/中文.png)

`img/gif1.gif`

![这是图片 gif](images/gif1.gif) 

`img/image.webp`

![这是图片 webp](./images/image.webp)

`<img src="https://foruda.gitee.com/images/1725948355263369051/6bac94d7_14744567.png" alt="示例图片" width="300" height="200">`

<img src="https://foruda.gitee.com/images/1725948355263369051/6bac94d7_14744567.png" alt="示例图片" width="300" height="200">

`<img src="https://example.com/images/123/456.png" alt="示例图片" width="300" height="200">`

<img src="https://example.com/images/123/456.png" alt="示例图片" width="300" height="200">

```
| 第一列                 | 第二列                 | 第三列                 |
|---------------------|---------------------|---------------------|
| ![](./images/images1.png) | ![](./images/images1.png) | ![](./images/images1.png) |
| ![](./images/gif1.gif) | ![](./images/gif1.gif) | ![](./images/gif1.gif) |
```

| 第一列                 | 第二列                 | 第三列                 |
|---------------------|---------------------|---------------------|
| ![](./images/images1.png) | ![](./images/images1.png) | ![](./images/images1.png) |
| ![](./images/gif1.gif) | ![](./images/gif1.gif) | ![](./images/gif1.gif) |

`![](./images/video.mp4)`

![](./images/video.mp4)

`![](https://gitee.com/hightest/test_repo_002/raw/master/images/video.mp4)`

![](https://gitee.com/hightest/test_repo_002/raw/master/images/video.mp4)

```
<video controls>
    <source src="./images/video.mp4" type="video/mp4">
    您的浏览器不支持视频标签。
</video>
```

注：因 docusaurus 不支持特殊字符，所以用代码块注释
```
<video controls>
    <source src="./images/video.mp4" type="video/mp4">
    您的浏览器不支持视频标签。
</video>
```

附：[图片转换工具](https://www.logosc.cn/design/tools/image-convert)



# Markdown 转义字符语法

\* Without the backslash, this would be a bullet in an unordered list.  
http://images.google.com/images?num=30&amp;q=larry+bird  
&copy;  



# Markdown 内嵌 HTML 标签

This **word** is bold. This <em>word</em> is italic.  

This is a regular paragraph.

<table>
    <tr>
        <td>Foo</td>
    </tr>
</table>

This is another regular paragraph.



# Markdown 表格

| Syntax      | Description |
| ----------- | ----------- |
| Header      | Title       |
| Paragraph   | Text        |

对齐

| Syntax      | Description | Test Text     |
| :---        |    :----:   |          ---: |
| Header      | Title       | Here's this   |
| Paragraph   | Text        | And more      |

格式化表格中的内容

| Command | Description |
| --- | --- |
| `git status` | List all *new or modified* files |
| `git diff` | Show file differences that **haven't been** staged |

表格+链接

| 框架                                                                                          | 说明               | 版本             | 学习指南                                                           |
|---------------------------------------------------------------------------------------------|------------------|----------------|----------------------------------------------------------------|
| [Spring Boot](https://spring.io/projects/spring-boot)                                       | 应用开发框架           | 2.7.18         | [文档](https://github.com/YunaiV/SpringBoot-Labs)                |
| [MySQL](https://www.mysql.com/cn/)                                                          | 数据库服务器           | 5.7 / 8.0+     |                                                                |

简单表格

| 时间类型 | 示例时间                       | 说明                                                         |
| :------- | :----------------------------- | :----------------------------------------------------------- |
| UTC      | `Tue Jan 01 12:00:00 UTC 2024` | 协调世界时（Coordinated Universal Time），即 2024 年 1 月 1 日中午 12 点 |
| GMT      | `Tue Jan 01 12:00:00 GMT 2024` | 格林威治标准时间（Greenwich Mean Time），通常与 UTC 相同     |
| CST      | `Tue Jan 01 20:00:00 CST 2024` | 中国标准时间（China Standard Time），即 2024 年 1 月 1 日晚上 8 点 |



# Markdown 围栏代码块

示例代码块

```
{
  "firstName": "John",
  "lastName": "Smith",
  "age": 25
}
```

含有 html 标签的代码块

```tsx
<Text style={{ color: "red" }}>123456</Text>

<Button
    onPress={() => {
        example.sendInfo('10086', false);
    }}
    title=""
    color="#841584"
/>
```

解释器

```bash
$ ls *.sh
$ mv *.sh ~/tmp
```

Mermaid 代码块

```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```

```mermaid
  info
```

超长代码块

```
longlonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglonglong
```

在围栏代码块中显示三重倒引号，请将其包在四个倒引号内

````
```
Look! You can see my backticks.
```
````



# Markdown 脚注

Here's a simple footnote,[^1] and here's a longer one.[^bignote]

[^1]: This is the first footnote.

[^bignote]: Here's one with multiple paragraphs and code.

    Indent paragraphs to include them in the footnote.
    
    `{ my code }`
    
    Add as many paragraphs as you like.

Indent paragraphs to include them in the footnote.

`{ my code }`

Add as many paragraphs as you like.



# Markdown 标题编号

### My Great Heading {#my-great-heading}

[Heading IDs](#my-great-heading)

[Heading IDs](https://markdown.com.cn/extended-syntax/heading-ids.html#headid)



# Markdown 定义列表

First Term
: This is the definition of the first term.

Second Term
: This is one definition of the second term.
: This is another definition of the second term.



# Markdown 删除线

~~世界是平坦的。~~ 我们现在知道世界是圆的。



# Markdown 任务列表语法

- [x] Write the press release
- [ ] Update the website
- [ ] Contact the media



# Markdown 使用 Emoji 表情

去露营了！ :tent: 很快回来。

真好笑！ :joy:



# Markdown 自动网址链接

自动将 URL 转换为链接
http://www.example.com

禁用自动 URL 链接
`http://www.example.com`



# Markdown 下划线

注：因 docusaurus 不支持特殊字符，所以用代码块注释
```
<u>下划线</u>  
$\underline{\text{下划线}}$
```


# Markdown 上划线

$\overline{\text{上划线}}$



# Markdown 数据公式

行内公式  
$E = mc^2$


块级公式  
$$
a^2 + b^2 = c^2
$$


分数形式  
$\frac{a}{b}$


平方根形式  
$\sqrt{x}$


积分公式  
$$ \int_0^1 x^2 \, dx $$


求和公式 
$$ \sum_{i=1}^{n} i = \frac{n(n+1)}{2} $$


行列式
$$
\begin{vmatrix}
a & b \\
c & d
\end{vmatrix}
$$


块级矩阵
$$
\begin{pmatrix}
a & b \\
c & d
\end{pmatrix}
$$


分块矩阵
$$
\begin{pmatrix}
A & B \\
C & D
\end{pmatrix}
=
\begin{pmatrix}
1 & 2 & 3 & 4 \\
5 & 6 & 7 & 8 \\
\end{pmatrix}
$$


2x2 矩阵
$$
\begin{pmatrix}
1 & 2 \\
3 & 4
\end{pmatrix}
$$


3x3 矩阵  
$$
\begin{pmatrix}
1 & 2 & 3 \\
4 & 5 & 6 \\
7 & 8 & 9
\end{pmatrix}
$$


4x4 矩阵
$$
\begin{pmatrix}
a_{11} & a_{12} & a_{13} & a_{14} \\
a_{21} & a_{22} & a_{23} & a_{24} \\
a_{31} & a_{32} & a_{33} & a_{34} \\
a_{41} & a_{42} & a_{43} & a_{44}
\end{pmatrix}
$$


带有列标题的矩阵1
$$
\begin{array}{|c|c|c|}
\hline
\text{列1} & \text{列2} & \text{列3} \\
\hline
1 & 2 & 3 \\
4 & 5 & 6 \\
\hline
\end{array}
$$


带有列标题的矩阵2
$$
\begin{array}{|c|c|c|}
\hline
\text{行/列} & \text{列1} & \text{列2} \\
\hline
\text{行1} & 1 & 2 \\
\hline
\text{行2} & 3 & 4 \\
\hline
\end{array}
$$


带有颜色的 2x2 矩阵
$$
\begin{bmatrix}
\textcolor{red}{A} & \textcolor{green}{B} \\
\textcolor{blue}{C} & \textcolor{yellow}{D}
\end{bmatrix}
$$


带有标签的 2x2 矩阵
$$
\begin{pmatrix}
\text{速度} & v \\
\text{加速度} & a
\end{pmatrix}
=
\begin{pmatrix}
\frac{d x}{d t} & \frac{d v}{d t} \\
\end{pmatrix}
$$


带有公式的 2x2 矩阵
$$
\begin{pmatrix}
x_1 + y_1 & x_2 + y_2 \\
x_3 + y_3 & x_4 + y_4
\end{pmatrix}
$$


带有符号的 3x3 矩阵
$$
\begin{pmatrix}
\sin(x) & \cos(x) & \tan(x) \\
\log(y) & e^{z} & \sqrt{x} \\
\frac{1}{x} & x^2 & x^3
\end{pmatrix}
$$


带方括号的 3x3 矩阵  
$$
\begin{bmatrix}
1 & 2 & 3 \\
4 & 5 & 6 \\
7 & 8 & 9
\end{bmatrix}
$$

$x + y = 10$  
分数$\frac{1}{3} \frac{2}{3}$
分数$\frac{1}{3} \frac{2}{3}$

上下标 $x^2$ $x_2$  
开根 $\sqrt[3]{\{[(5+6)]\}}$  
不等于号 $ x \not= b $  
约等于 $ c \approx d$  
小于等于 $ e \leq f $  
大于等于 $ \geq $  
乘号 $ \times $  
除号 $ \div $
正负号 $ \pm $  
求和 $ \sum $  
累乘 $ \prod $  
极限 $ \lim $  
对数 $ \log $  
累除 $ \overline{1+2+3+4 = 4} $



# Markdown markups

[markups 示例](https://github.com/github/markup/tree/master/test/markups)  
[markups 示例](https://gitee.com/mirrors_github/markup/tree/master/test/markups)


= Document Title
// sectanchors will be ignored
:sectanchors:

== First Section

* One
* Two

注：因 docusaurus 不支持特殊字符，所以用代码块注释
```
Refer to <<another-section>> or <<another-section-1>>.

Navigate from {docname}{outfilesuffix} to xref:another-document.asciidoc[another document].

== Another Section

NOTE: Here is some source code.
```

```ruby
puts "Hello, World!"
```

* [ ] todo
* [x] done

== Another Section

content



# Markdown 标签

<div align="center">
<h2>A set of enterprise-class UI components based on Bootstrap and Blazor.</h2>

[![Security Status](https://www.murphysec.com/platform3/v3/badge/1619783039836532736.svg)](https://github.com/dotnetcore/BootstrapBlazor/blob/main/LICENSE)

[![oscs](https://www.oscs1024.com/platform/badge/murphysecurity/murphysec.svg)](https://github.com/dotnetcore/BootstrapBlazor/blob/main/LICENSE)
[![License](https://img.shields.io/github/license/dotnetcore/BootstrapBlazor.svg?logo=git&logoColor=red)](https://github.com/dotnetcore/BootstrapBlazor/blob/main/LICENSE)
[![Nuget](https://img.shields.io/nuget/v/BootstrapBlazor.svg?color=red&logo=nuget&logoColor=green)](https://www.nuget.org/packages/BootstrapBlazor/)
[![Nuget](https://img.shields.io/nuget/dt/BootstrapBlazor.svg?logo=nuget&logoColor=green)](https://www.nuget.org/packages/BootstrapBlazor/)
[![Repo Size](https://img.shields.io/github/repo-size/dotnetcore/BootstrapBlazor.svg?logo=github&logoColor=green&label=repo)](https://github.com/dotnetcore/BootstrapBlazor)
[![Commit Date](https://img.shields.io/github/last-commit/dotnetcore/BootstrapBlazor/main.svg?logo=github&logoColor=green&label=commit)](https://github.com/dotnetcore/BootstrapBlazor)
[![Github build](https://img.shields.io/github/actions/workflow/status/dotnetcore/BootstrapBlazor/build.yml?branch=main&?label=main&logo=github)](https://github.com/dotnetcore/BootstrapBlazor/actions?query=workflow%3A%22Build+Project%22+branch%3Amain)
[![codecov](https://codecov.io/gh/dotnetcore/BootstrapBlazor/branch/main/graph/badge.svg?token=5SXIWHXZC3)](https://codecov.io/gh/dotnetcore/BootstrapBlazor)
</div>

[![](https://img.shields.io/travis/antvis/f2.svg)](https://travis-ci.org/antvis/f2) 
![](https://img.shields.io/badge/language-javascript-red.svg) 
![](https://img.shields.io/badge/license-MIT-000000.svg) 
[![npm package](https://img.shields.io/npm/v/@antv/f2.svg)](https://www.npmjs.com/package/@antv/f2) 
[![NPM downloads](http://img.shields.io/npm/dm/@antv/f2.svg)](https://npmjs.org/package/@antv/f2) 
[![Percentage of issues still open](http://isitmaintained.com/badge/open/antvis/f2.svg)](http://isitmaintained.com/project/antvis/f2 'Percentage of issues still open')

[![npm Version](https://img.shields.io/npm/v/@antv/g6.svg)](https://www.npmjs.com/package/@antv/g6)
[![Build Status](https://github.com/antvis/g6/workflows/build/badge.svg?branch=v5)](https://github.com/antvis/g6/actions)
[![Coverage Status](https://coveralls.io/repos/github/antvis/G6/badge.svg)](https://coveralls.io/github/antvis/G6)
[![npm Download](https://img.shields.io/npm/dm/@antv/g6.svg)](https://www.npmjs.com/package/@antv/g6)
![typescript](https://img.shields.io/badge/language-typescript-blue.svg)
[![npm License](https://img.shields.io/npm/l/@antv/g6.svg)](https://www.npmjs.com/package/@antv/g6)

![GitHub](https://img.shields.io/github/license/XuanchenLin/NanUI)
![Nuget](https://img.shields.io/nuget/v/NetDimension.NanUI)
![Nuget](https://img.shields.io/nuget/dt/NetDimension.NanUI)

[![Star History Chart](https://api.star-history.com/svg?repos=viarotel-org/escrcpy&type=Date)](https://star-history.com/#viarotel-org/escrcpy&Date)



# Markdown Front Matter

注：一般是放在文件顶部，[参考资料](https://v1.vuepress.vuejs.org/zh/guide/frontmatter.html)  
任何包含 YAML front matter 的 Markdown 文件都将由 gray-matter (opens new window)处理。front matter 必须是 markdown 文件中的第一部分，并且必须采用在三点划线之间书写的有效的 YAML。 这是一个基本的例子：
```
---
title: Blogging with VuePress
lang: zh-CN
---

# {{ $frontmatter.title }}

My blog post is written in {{ $frontmatter.lang }}.
```



# Markdown 拓展语法

## 折叠

<details>
  <summary>点击展开/折叠</summary>

这里是可折叠的内容。

</details>

## 提示

> [!NOTE]  
> Useful information that users should know, even when skimming content.

> [!TIP]  
> Helpful advice for doing things better or more easily.

> [!IMPORTANT]  
> Key information users need to know to achieve their goal.

> [!WARNING]  
> Urgent info that needs immediate user attention to avoid problems.

> [!CAUTION]  
> Advises about risks or negative outcomes of certain actions.

## 颜色

`The background color is `#ffffff` for light mode and `#000000` for dark mode.`  
The background color is `#ffffff` for light mode and `#000000` for dark mode.

## 隐藏有评论的内容

<!-- This content will not appear in the rendered Markdown -->

## 指定图像显示的主题

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://user-images.githubusercontent.com/25423296/163456776-7f95b81a-f1ed-45f7-b7ab-8fa810d529fa.png">
  <source media="(prefers-color-scheme: light)" srcset="https://user-images.githubusercontent.com/25423296/163456779-a8556205-d0a5-45e2-ac17-42d089e3c3f8.png">
  <img alt="Shows an illustrated sun in light mode and a moon with stars in dark mode." src="https://user-images.githubusercontent.com/25423296/163456779-a8556205-d0a5-45e2-ac17-42d089e3c3f8.png">
</picture>



# 知识碎片

## Markdown 自动生成目录

方法一：  
在文章的最顶端输入 [toc] 即可(在 Typora/VScode 支持, 在 IDEA 需使用方法二)。

方法二：  
安装 doctoc：`npm install doctoc -g`.
切换到对应目录执行：doctoc Markdown.md | doctoc MarkdownTutorial.md  
（可不执行）替换标题序号：python3 markdown_util.py replace_title_num(markdown_src, markdown_dst)  
（可不执行）切换到对应目录执行：doctoc MarkdownCatalog.md | doctoc MarkdownTutorialCatalog.md  
转换 URL 编码的目录为中文：python3 markdown_util.py decode_toc_file(file_path)

[Markdown 语法校验](https://github.com/DavidAnson/markdownlint-cli2)  
[markdownlint](https://github.com/DavidAnson/markdownlint)

```
npm install markdownlint-cli2 --global

markdownlint-cli2 文件名.md

markdownlint-cli2 "**/*.md" "#node_modules"

markdownlint-cli2 --fix "**/*.md" "#node_modules"
```

## Markdown 在线编辑器

[Markdown 在线编辑器1](https://markdown.com.cn/editor/)  
[Markdown 在线编辑器2](https://dillinger.io/)  
[Markdown 在线编辑器3](https://stackedit.io/app#)

## Markdown 文档集合

[harmonyos docs1](https://gitee.com/openharmony/docs)  
[harmonyos docs2](https://gitee.com/harmonyos-cases/cases)

## Markdown 编写规范

标题和正文直接需要有空行

## 其它

- Typora 快捷键
1. 返回 Typora 顶部：Ctrl+Home
2. 返回 Typora 底部：Ctrl+End
3. 下划线：ctrl + u
4. 删除线：alt + shift +5
5. 字体倾斜：ctrl + i
6. 引用：> + space 或者 ctrl + shift + q
7. 插入链接：ctrl+k

![Github Start](https://img.shields.io/github/stars/iewiewiew/wei-notebook.svg?style=social&label=Stars)  
![Gitee Start](https://gitee.com/iewiewiew/wei-notebook/badge/star.svg?theme=white)

- [Typora 自定义样式](https://theme.typora.io/)

把自定义的 css 放到主题文件夹，重启 Typora，Typora > 设置 > 外观，选择自定义主题。

- 删除部分标签
<Text>
<Button>
<img>

- 特殊路径
[~/passwd](~/passwd)  
[/etc/passwd](/etc/passwd)  
[../etc/passwd](../etc/passwd)  