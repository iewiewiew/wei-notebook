# !/usr/bin/env python
# -*- coding:utf-8 -*-

"""
@author       weimenghua
@time         2023/12/20 21:52
@description  处理 JMeter 测试报告
"""

import json
import time
import pandas as pd
import csv
import xml.etree.ElementTree as ET


def json_to_excel(base_path, array):
    """statistics.json 转换成 statistics.xlsx"""

    for jmx_path in array:
        # jmx_path = ''  # 生成单个文件
        file_path = base_path + 'result/' + jmx_path + '/'
        with open(file_path + 'statistics.json', 'r') as file:
            json_data = json.load(file)
            index = list(json_data.keys()).index("Total")

        # 转换为 DataFrame
        df = pd.DataFrame.from_dict(json_data, orient='index')

        # 将小数四舍五入
        df = df.round(2)

        custom_header = ['事务', '样本计数', '错误计数', '错误百分比', '平均响应时间', '最小响应时间', '最大响应时间', '中位数响应时间', '百分之九十响应时间',
                         '百分之九十五响应时间',
                         '百分九十九响应时间', '吞吐量', '接收字节速率', '发送字节速率']

        # 指定字段顺序
        desired_columns = ['transaction', 'sampleCount', 'errorCount', 'errorPct', 'meanResTime', 'minResTime',
                           'maxResTime', 'medianResTime', 'pct1ResTime', 'pct2ResTime', 'pct3ResTime', 'throughput',
                           'receivedKBytesPerSec', 'sentKBytesPerSec']

        # 重新排序列顺序
        df = df.reindex(columns=desired_columns)

        # 将 "Total" 移动到第二行
        df = df.reindex(['Total'] + [col for col in df.index if col != 'Total'])

        file_path = base_path + 'result/' + jmx_path + '/' + 'statistics.xlsx'
        # 将 DataFrame 写入 Excel 文件
        try:
            df.to_excel(file_path, index=False, header=custom_header)
            print("生成原始测试报告: " + file_path)
        except Exception as e:
            print("生成原始测试报告: " + e)


def extract_data_from_jmx(base_path, array):
    """读取 JMX 获取交易、URL、线程数写入 CSV"""

    fieldnames = ['label', 'URL', 'num_threads']  # Updated fieldnames

    for jmx_path in array:
        jmx_file = base_path + 'testcase/jmeter-test-' + jmx_path + '.jmx'
        tree = ET.parse(jmx_file)
        root = tree.getroot()

        data = []
        for sampler in root.iter('HTTPSamplerProxy'):
            if 'testclass' in sampler.attrib and sampler.attrib['testclass'] == 'HTTPSamplerProxy':
                testname = sampler.attrib.get('testname', '')
                path_element = sampler.find('.//stringProp[@name="HTTPSampler.path"]')
                path = path_element.text if path_element is not None else ''

                # Extract num_threads value from ThreadGroup element
                num_threads_element = root.find('.//ThreadGroup/stringProp[@name="ThreadGroup.num_threads"]')
                num_threads = num_threads_element.text if num_threads_element is not None else ''

                data.append({'label': testname, 'URL': path, 'num_threads': num_threads})

        csv_file = base_path + 'result/' + jmx_path + '/jmx_url.csv'
        with open(csv_file, mode='w', newline='') as file:
            writer = csv.DictWriter(file, fieldnames=fieldnames)  # Updated writer
            writer.writeheader()
            writer.writerows(data)  # Updated writerows
        print("读取JMX获取获取交易、URL、线程数: " + csv_file)


def save_report(base_path, array):
    """合并 Excel 和 CSV 生成单个报告"""

    unique_urls = set()  # 用于存储唯一的 URL 名称

    for jmx_path in array:
        excel_path = base_path + 'result/' + jmx_path + '/' + 'statistics.xlsx'
        df_excel = pd.read_excel(excel_path)

        # csv_path = base_path + jmx_path + '/' + 'result.csv'
        csv_path = base_path + 'result/' + jmx_path + '/' + 'jmx_url.csv'
        columns_to_keep = ['label', 'URL', 'num_threads']
        df_csv = pd.read_csv(csv_path, usecols=columns_to_keep)

        excel_column = '事务'
        csv_column = 'label'

        merged_df = pd.merge(df_excel, df_csv, left_on=excel_column, right_on=csv_column)

        sorted_df = merged_df.sort_values(by='事务')

        output_path = base_path + 'result/' + jmx_path + '/' + 'jmeter_test_report_{}_{}.xlsx'.format(jmx_path,
                                                                                                        time.strftime("%Y%m%d",
                                                                                                                      time.localtime()))

        # 去重处理
        # sorted_df.drop_duplicates(subset='URL', inplace=True)
        # sorted_df.reset_index(drop=True, inplace=True)

        # 将合并后的结果保存到新的 Excel 文件
        sorted_df.to_excel(output_path, index=False)

        df_excel = pd.read_excel(output_path)

        # 获取需要移动的列
        # column_to_move = 'https://mirrors.gitee.com' + df_excel['URL']
        column_to_move = df_excel['URL']
        column_to_move2 = df_excel['num_threads']

        # 删除需要移动的列
        df_excel = df_excel.drop(columns=['URL', 'label','num_threads'])

        # 将列插入到指定的位置
        df_excel.insert(1, '接口', column_to_move)
        df_excel.insert(2, '并发数', column_to_move2)

        df_excel.to_excel(output_path, index=False)

        print("生成单个测试报告: " + output_path)


def merge_excel_files(base_path, array):
    """合并多个 Execl 生成最终测试报告"""

    # 读取第一个 Excel 文件的数据和表头
    df_first = pd.read_excel(base_path + 'result/' + array[0] + '/jmeter_test_report_' + array[0] + '_{}'.format(
        time.strftime("%Y%m%d", time.localtime())) + '.xlsx')
    header_first = list(df_first.columns)

    # 创建一个空的 DataFrame 用于存储合并后的数据
    df_merged = pd.DataFrame()

    # 遍历每个 Excel 文件并将数据合并到 df_merged 中
    for file in array:
        df = pd.read_excel(base_path + 'result/' + file + '/jmeter_test_report_' + file + '_{}'.format(
            time.strftime("%Y%m%d", time.localtime())) + '.xlsx')
        df_merged = pd.concat([df_merged, df])
        df_merged = df_merged.append(pd.Series(), ignore_index=True)  # 插入空行

    # 创建一个新的 DataFrame 用于存储插入表头后的数据
    df_final = pd.DataFrame(columns=header_first)

    # 插入每个 Excel 文件的数据和表头到 df_final 中
    for file in array:
        df = pd.read_excel(base_path + 'result/' + file + '/jmeter_test_report_' + file + '_{}'.format(
            time.strftime("%Y%m%d", time.localtime())) + '.xlsx')
        df_final = df_final.append(df, ignore_index=True)
        df_final = df_final.append(pd.Series(), ignore_index=True)  # 插入空行

    """
    # 写入并发数
    count = len(df_final[(~df_final.apply(lambda row: row.astype(str).str.contains('事务').any(), axis=1)) & (
        ~df_final.isnull().all(axis=1))])

    for index, row in df_final.iterrows():
        if not row.isnull().all() and not row.str.contains("事务").any() and not row.isin(header_first).any():
            concurrency = math.ceil(200 / count)
            df_final.at[index, "并发数"] = concurrency
        else:
            df_final.at[index, "并发数"] = ''

    # 将"并发数"列插入到第三列
    df_final.insert(2, "并发数", df_final.pop("并发数"))
    """

    # 将合并后的结果写入到新的 Excel 文件中
    output_path = base_path + 'result/' + 'jmeter_test_report_{}'.format(time.strftime("%Y%m%d", time.localtime())) + '.xlsx'
    df_final.to_excel(output_path, index=False)
    print("生成终版测试报告：" + output_path)

