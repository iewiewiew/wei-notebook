[TOC]

<h1 align="center">Drawio</h1>

> By：weimenghua  
> Date：2025.06.06   
> Description：


[Drawio 开源免费的流程图绘制软件](https://app.diagrams.net/)  
[drawio-desktop](https://github.com/jgraph/drawio-desktop) 是一个基于 Electron 的 diagrams.net 桌面画图应用程序

嵌入 drawio 页面

```
from flask import Flask, render_template_string

app = Flask(__name__)


@app.route('/')
def index():
    html_content = '''
    <!DOCTYPE html>
    <html lang="zh">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>嵌入 IFrame 示例</title>
    </head>
    <body>
        <h1>欢迎来到 IFrame 示例页面</h1>
        <iframe frameborder='0' style='width:100%;height:400px;'
                src='https://diagram-viewer.giteeusercontent.com/?repo=hightest/test_repo_005&ref=master&file=test.drawio'>
        </iframe>
    </body>
    </html>
    '''
    return render_template_string(html_content)


if __name__ == '__main__':
    app.run(debug=True)
```