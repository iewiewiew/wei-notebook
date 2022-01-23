# !/usr/bin/env python
# -*- coding:utf-8 -*-

"""
@author       weimenghua
@time         2023/8/12 22:02
@description  xlsx 转 markdown
"""

import pandas as pd
from tabulate import tabulate


# 换行处理单元格
def xlsx_to_markdown(xlsx_file, markdown_file):
    # 读取XLSX文件中的所有工作表
    xls = pd.read_excel(xlsx_file, sheet_name=None)

    # 构建Markdown内容
    markdown_content = ""
    first_sheet = True
    for sheet_name, df in xls.items():
        if first_sheet:
            first_sheet = False
            continue
        # 添加工作表标题
        markdown_content += f"## {sheet_name}\n\n"

        # 将DataFrame转换为Markdown表格
        markdown_content += tabulate(df, headers='keys', tablefmt='pipe', disable_numparse=True,
                                     showindex=False) + "\n\n"

    # 将Markdown内容写入文件
    with open(markdown_file, 'w') as f:
        f.write(markdown_content)


# 保持源样式，推荐使用
def xlsx_to_markdown2(xlsx_file, markdown_file):
    # 创建 ExcelFile 对象
    xls = pd.ExcelFile(xlsx_file)

    # 保存所有 sheet 的 Markdown 表格
    markdown_tables = []

    first_sheet = True
    # 循环读取每个 sheet
    for sheet_name in xls.sheet_names:
        if first_sheet:
            first_sheet = False
            continue

        # 读取当前 sheet 的数据
        df = pd.read_excel(xls, sheet_name)

        # 将换行符替换为空格
        df = df.replace('\n', ' ', regex=True)

        markdown_table = ''
        # 添加工作表标题
        markdown_table += f"## {sheet_name}\n\n"

        # 转换为 Markdown 表格
        # markdown_table = tabulate(df, headers='keys', tablefmt='pipe')
        markdown_table += tabulate(df, headers='keys', tablefmt='pipe', disable_numparse=True,
                                     showindex=False) + "\n\n"

        # 添加到列表中
        markdown_tables.append(markdown_table)

    # 写入 Markdown 文件
    with open(markdown_file, 'w') as file:
        for markdown_table in markdown_tables:
            file.write(markdown_table)
            # file.write('\n---\n')  # 在每个表格之间添加水平分隔线

    print(f"Markdown 文件 '{markdown_file}' 转换成功！")


if __name__ == '__main__':
    # 指定要转换的XLSX文件路径
    xlsx_file = '/Users/menghuawei/IdeaProjects/my-project/wei-notebook/Chaos/高可用测试用例模板.xlsx'

    # 指定要保存的Markdown文件路径
    markdown_file = '/Users/menghuawei/IdeaProjects/my-project/wei-notebook/Chaos/高可用测试用例模板.md'

    # 生成对应的 Markdown 文件名，xlsx_to_markdown() 需要此变量
    # markdown_file = xlsx_file.replace('.xlsx', '.md')

    # 转换 XLSX 到 Markdown
    xlsx_to_markdown2(xlsx_file, markdown_file)
