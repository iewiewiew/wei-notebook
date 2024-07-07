// Typst 示例文档
// 编译：typst compile typst-demo.typ typst-demo.pdf
// 实时预览：typst watch typst-demo.typ typst-demo.pdf

#set document(title: "Typst 示例", author: "menghuawei")
#set page(
  paper: "a4",
  margin: (x: 2.4cm, y: 2.6cm),
  numbering: "1",
  header: align(right)[#text(size: 9pt, fill: luma(120))[Typst 0.15 示例]],
)

#set text(font: ("PingFang SC", "Heiti SC", "New Computer Modern"), size: 11pt, lang: "zh")
#set par(justify: true, leading: 0.8em, first-line-indent: (amount: 2em, all: true))
#set heading(numbering: "1.1")

#align(center)[
  #text(size: 20pt, weight: "bold")[Typst 排版的几个基本能力] \
  #text(size: 10pt, fill: luma(100))[中文 + 公式 + 表格 + 代码 + 图表]
]

#outline(title: [目录], indent: auto)

= 正文与中文排版 <sec-text>

Typst 的标记语法接近 Markdown：`= 标题`、`*粗体*`、`_斜体_`、`- 列表`。
它比 Markdown 多的是排版控制——页面、页眉页脚、首行缩进、断行都能用函数声明。
中文段落默认不缩进，上面的 `#set par(first-line-indent: ...)` 打开了首行缩进，
`all: true` 让每一段都缩进，而不只是分段后的第一段。

混排一段英文 *Typesetting with a markup language that compiles in milliseconds*，用来观察基线与行距。

#footnote[脚注也支持，编号自动递增。]

= 数学公式 <sec-math>

行内公式 $E = m c^2$，独立公式：

$ integral_0^1 x^2 dif x = 1/3 $

矩阵、分段函数与对齐：

$ mat(1, 2; 3, 4) quad "与" quad cases(x > 0 & => 1, x <= 0 & => 0) $

= 表格 <sec-table>

#figure(
  table(
    columns: (2fr, 1fr, 1fr),
    align: (left, center, center),
    stroke: none,
    table.header([特性], [Typst], [LaTeX]),
    [编译速度], [毫秒级], [秒到分钟],
    [语法], [标记 + 函数], [宏命令],
    [包管理], [内置], [TeX Live],
  ),
  caption: [Typst 与 LaTeX 的粗略对比],
) <tab-cmp>

见表 @tab-cmp，公式见 @sec-math。

= 代码与图表 <sec-code>

```python
def hello(name: str) -> str:
    return f"hello, {name}"
```

#figure(
  rect(
    width: 60%,
    height: 3.2cm,
    radius: 6pt,
    stroke: 0.6pt + luma(180),
    fill: luma(245),
  )[
    #align(center + horizon)[矢量图形由 `rect` / `circle` / `curve` 直接绘制，不依赖外部图片]
  ],
  caption: [用内置绘图函数画的示意图],
)

= 编程能力 <sec-prog>

#let badge(color, body) = box(
  fill: color,
  inset: (x: 6pt, y: 3pt),
  radius: 3pt,
)[#text(size: 9pt, fill: white)[#body]]

循环与自定义函数可以直接写在文档里：

#for (name, c) in (
  ("Typst", rgb("#1f6feb")),
  ("Rust", rgb("#d1495b")),
  ("PDF", rgb("#3a7d44")),
) [
  #badge(c)[#name] #h(4pt)
]

#v(1em)
#align(right)[—— 完 ——]
