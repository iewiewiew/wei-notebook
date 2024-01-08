# !/usr/bin/env python
# -*- coding:utf-8 -*-

"""
@author       weimenghua
@time         2023/7/28 18:35
@description  批量在段落中英文之间加空格
"""
import os
import re


def demo():
    file_path = '/Users/menghuawei/IdeaProjects/my-project/wei-notebook'

    for root, dirs, files in os.walk(file_path):
        for _file_path in files:
            path = os.path.join(root, _file_path)

            if path.__contains__('.idea') or path.__contains__('.git') or path.__contains__('lib') or path.__contains__('tmp'):
                return
            else:
                try:
                    print(path)
                    # 读取文件内容
                    # with open('../file/input.txt') as f:
                    with open(path, encoding='utf-8') as f:
                        content = f.read()

                        # 定义正则表达式
                        pattern = re.compile(r'([\u4e00-\u9fa5])([a-zA-Z])|([a-zA-Z])([\u4e00-\u9fa5])')

                        # 将匹配到的内容替换为加空格的字符串
                        # result = re.sub(pattern, r'\1\3 \2\4', content)

                        # # 将处理后的内容保存到文件中
                        # with open(path, 'w') as f:
                        #     f.write(result)
                except UnicodeDecodeError:
                    print('')


if __name__ == '__main__':
    demo()
