[TOC]

---

<h1 align="center">Markdown 教程</h1>

> By：weimenghua  
> Date：2023.05.25  
> Description：Markdown  

**参考资料**  
[Markdonw 官网](https://www.markdownguide.org/)  
[Markdown 官方教程](https://markdown.com.cn/)   
[Markdown 在线编辑器](https://markdown.com.cn/editor/)  
[markdownlint](https://github.com/DavidAnson/markdownlint/)

## 目录

* [目录1](#标题1（前面一个#号）)
  * [目录11](## 标题2（前面两个#号）)

# 标题1（前面一个#号）

注：标题和正文之间有空行

## 标题2（前面两个#号）

### 标题3（前面三个#号）

#### 标题4（前面四个#号）

一级标题
===
二级标题
---

**文本加粗**  [什么时候使用加粗和标题？](https://github.com/DavidAnson/markdownlint/blob/v0.31.1/doc/md036.md)
*斜体文本*  
_斜体文本_  
==高亮文本==  
<u>带下划线文本</u>  
~~删除文本~~  
> 引用文本

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

[百度链接](https://www.baidu.com)   
[本地链接](../../README.md)

https://www.baidu.com  
<https://www.baidu.com>

```
![avatar](../../docs/嘎嘎软件测试.png)
```

```
换行1<br>换行2<br>
行尾双空格换行1  
行尾双空格换行2 
```

***
---
___

| 标题1  | 标题2  | 标题3  |
| :--: | :--: | :--- |
| 文本1  | 文本2  | 文本3  |
| 文本4  | 文本5  | 文本6  |

-: 设置内容和标题栏居右对齐。  
:- 设置内容和标题栏居左对齐。  
:-: 设置内容和标题栏居中对齐。  

```bash 
多行代码 声明代码块语言环境：bash、python、java、javascript
```
行内代码`行内代码`

快捷键
1. 返回 Typora 顶部：Ctrl+Home
2. 返回 Typora 底部：Ctrl+End
3. 下划线：ctrl + u
4. 删除线：alt + shift +5
5. 字体倾斜：ctrl + i
6. 引用：> + space 或者 ctrl + shift + q
7. 插入链接：ctrl+k

Markdown 自动生成目录  
方法一：在文章的最顶端输入 [toc] 即可(在 Typora 可以, 在 IDEA 需使用方法二)  
方法二：npm install doctoc -g, 切换到对应目录执行：执行 doctoc Markdwon 教程.md 文件
方法三：python3 title_number.py
```
import re


def replace_title_num(markdown_src, markdown_dst):
    """
    替换标题序号
    :param markdown_src: markdown 源文件
    :param markdown_dst: markdown 目标文件
    :return:
    """
    with open(markdown_src, 'rb') as f:
        txt = f.read().decode()

    # 默认6个标题等级
    heading_level = [0] * 7

    # 正则表达式编译标题格式，必须是 1-6个#和空格开始
    head_pattern = re.compile("^(#{1,6}) ")
    new_markdown = []

    for line in txt.splitlines():
        result = re.search(head_pattern, line)
        if not result:
            new_markdown.append(line)
            continue

        level = len(result.group(1))
        heading_level[level] += 1

        # int 转 str
        num_str = map(str, heading_level[1:level+1])
        # 拼接并替换字符串
        title = f"{result.group(1)} {'.'.join(num_str)}."
        heading_level[level+1:] = [0]*(7-level)

        line = line.replace(result.group(1), title)
        new_markdown.append(line)

    new_content = "\n".join(new_markdown)

    with open(markdown_dst, "w", encoding='utf8') as f:
        f.write(new_content)


if __name__ == '__main__':
    markdown_src = r"./Markdown 教程.md"
    markdown_dst = r"Markdown 教程(序号目录).md"
    replace_title_num(markdown_src, markdown_dst)
```

<details>
  <summary>点击展开/折叠</summary>

这里是可折叠的内容。

</details>

[Markdown 语法校验](https://github.com/DavidAnson/markdownlint-cli2)

```
npm install markdownlint-cli2 --global

markdownlint-cli2 "**/*.md" "#node_modules"

markdownlint-cli2 --fix "**/*.md" "#node_modules"
```