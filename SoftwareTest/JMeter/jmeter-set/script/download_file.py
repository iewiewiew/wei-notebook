# !/usr/bin/env python
# -*- coding:utf-8 -*-

"""
@author       weimenghua
@time         2024/1/5 16:24
@description
"""

import os
from flask import Flask, send_from_directory, render_template

app = Flask(__name__)

@app.route('/')
def show_files():
    directory = '/root/jmeter-test/result/'                               # 服务器路径

    # files = os.listdir(directory)  # 获取目录及文件文件

    files = sorted(get_files(directory))   # 获取目录下的文件

    # files = get_all_files(directory)   # 获取目录所有文件

    return render_template('index.html', files=files)


@app.route('/download/<path:filepath>')
def download_file(filepath):
    directory = '/root/jmeter-test/result/'                               # 服务器路径

    return send_from_directory(directory, filepath, as_attachment=True)


def get_files(directory):
    """获取目录下的文件"""

    files = []
    for filename in os.listdir(directory):
        file_path = os.path.join(directory, filename)
        if not os.path.isdir(file_path):
            files.append(filename)
    return files


def get_all_files(directory):
    """获取目录下所有文件"""

    files = []
    for root, _, filenames in os.walk(directory):
        for filename in filenames:
            file_path = os.path.join(root, filename)
            relative_path = os.path.relpath(file_path, directory)
            files.append(relative_path)
    return files

