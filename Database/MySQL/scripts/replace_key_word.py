# !/usr/bin/env python
# -*- coding:utf-8 -*-

"""
@author       weimenghua
@time         2024/9/3 16:17
@description  替换关键字

Python 读取 sql 文件里的关键字并替换为大写的，重新写入新的 sql 文件
"""

# 定义所有 MySQL 关键字
keywords = [
    'select', 'from', 'where', 'insert', 'update', 'delete',
    'create', 'drop', 'alter', 'table', 'index', 'view',
    'procedure', 'function', 'trigger', 'database', 'grant',
    'revoke', 'commit', 'rollback', 'join', 'inner', 'outer',
    'left', 'right', 'full', 'cross', 'union', 'having',
    'distinct', 'order', 'by', 'group', 'limit', 'offset',
    'set', 'values', 'as', 'like', 'in', 'between', 'case',
    'when', 'then', 'else', 'end', 'exists', 'not', 'null',
    'true', 'false', 'and', 'or', 'xor', 'if', 'else',
    'return', 'call', 'using', 'on', 'as', 'with'
]


def replace_keywords(input_file, output_file):
    try:
        # 读取输入 SQL 文件的内容
        with open(input_file, 'r', encoding='utf-8') as file:
            sql_content = file.read()

        # 替换每个关键字为大写形式
        for keyword in keywords:
            sql_content = sql_content.replace(keyword, keyword.upper())

        # 将修改后的内容写入输出 SQL 文件
        with open(output_file, 'w', encoding='utf-8') as file:
            file.write(sql_content)

        print(f"成功替换关键字并写入 {output_file}")

    except Exception as e:
        print(f"发生错误: {e}")


if __name__ == "__main__":
    input_sql_file = '/Users/menghuawei/IdeaProjects/my-project/wei-notebook/Database/MySQL/sql大集合v3.sql'
    output_sql_file = '/wei-notebook/Database/MySQL/sql大集合v3_keywords_capital.sql'
    replace_keywords(input_sql_file, output_sql_file)
