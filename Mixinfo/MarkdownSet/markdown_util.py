# !/usr/bin/env python
# -*- coding:utf-8 -*-

"""
@author       weimenghua
@time         2022/5/14 13:44
@description  生成 Markdown 文件目录
"""

import re
from urllib.parse import unquote


def replace_title_num(markdown_src, markdown_dst):
    """
    替换标题序号
    :param markdown_src: markdown源文件
    :param markdown_dst: markdown目标文件
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
        num_str = map(str, heading_level[1:level + 1])
        # 拼接并替换字符串
        title = f"{result.group(1)} {'.'.join(num_str)}."
        heading_level[level + 1:] = [0] * (7 - level)

        line = line.replace(result.group(1), title)
        new_markdown.append(line)

    new_content = "\n".join(new_markdown)

    with open(markdown_dst, "w", encoding='utf8') as f:
        f.write(new_content)
    print("生成新文件成功")


def decode_toc_file(file_path):
    """
    转换 URL 编码的目录为中文
    """
    # 读取文件内容
    with open(file_path, 'r', encoding='utf-8') as file:
        toc_content = file.read()

    # 正则表达式匹配 URL 编码的部分
    pattern = re.compile(r'\[(.*?)\]\((.*?)\)')

    def decode(match):
        text, url = match.groups()
        # 解码 URL 中的中文部分
        decoded_url = unquote(url)
        return f'[{text}]({decoded_url})'

    # 替换所有匹配的部分
    new_toc_content = pattern.sub(decode, toc_content)

    # 写回文件
    with open(file_path, 'w', encoding='utf-8') as file:
        file.write(new_toc_content)

    print("URL 编码的标题已替换为原文。")


if __name__ == '__main__':
    markdown_src = r"/Users/menghuawei/IdeaProjects/my-project/wei-notebook/Mixinfo/MarkdownSet/markdown-example.md"
    markdown_dst = r"/Users/menghuawei/IdeaProjects/my-project/wei-notebook/Mixinfo/MarkdownSet/markdown-example-catalog.md"

    # replace_title_num(markdown_src, markdown_dst)

    # decode_toc_file(markdown_dst)

