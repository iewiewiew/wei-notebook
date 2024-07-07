# !/usr/bin/env python
# -*- coding:utf-8 -*-

"""
@author       weimenghua
@time         2024/4/7 16:47
@description
"""
import os

import openpyxl
from flask import Flask, render_template

from utils.jmeter.generate_jmeter_report import get_most_recent_directory

app = Flask(__name__)


@app.route('/')
def display_excel():
    base_path = '/Users/menghuawei/PycharmProjects/my-project/Learn-Python/.gitee/tmp'
    base_path = get_most_recent_directory(base_path)

    for filename in os.listdir(base_path):
        if filename.startswith('负载测试报告') and filename.endswith('.xlsx'):
            excel_file = os.path.join(base_path, filename)
            #excel_file = base_path + '负载测试报告_20240407_20240406221159.xlsx'

    data = []

    workbook = openpyxl.load_workbook(excel_file)
    worksheet = workbook.active

    for row in worksheet.iter_rows(values_only=True):
        data.append(row)

    return render_template('display.html', data=data, filename=excel_file)


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8888)
