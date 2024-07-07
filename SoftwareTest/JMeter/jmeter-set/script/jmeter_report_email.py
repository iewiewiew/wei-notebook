# !/usr/bin/env python
# -*- coding:utf-8 -*-

"""
@author       weimenghua
@time         2022/7/10 14:03
@description  发送邮件

python3 /root/gitee-performance-testing/script/email_jmeter_report.py
"""
import datetime
import os
import smtplib
from email import encoders
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText


def get_most_recent_directory(base_path):
    directories = [d for d in os.listdir(base_path) if os.path.isdir(os.path.join(base_path, d))]
    if not directories:
        return None

    directories.sort(reverse=True)  # Sort directories in descending order
    for directory in directories:
        try:
            timestamp = datetime.datetime.strptime(directory, "%Y%m%d%H%M%S%f")
            base_path = os.path.join(base_path, directory)
            return base_path
        except ValueError:
            continue

    return base_path


def send_multiple_reports(senderMail, authCode, receiverMail, base_path):
    subject = 'JMeter测试报告'

    try:
        server = smtplib.SMTP_SSL('smtp.qq.com', smtplib.SMTP_SSL_PORT)
        print('成功连接到邮件服务器')
        server.login(senderMail, authCode)
        print('成功登录邮箱')

        for filename in os.listdir(base_path):
            # if filename.startswith('result') and filename.endswith('.tar.gz'):
            if filename.startswith('负载测试报告') and filename.endswith('.xlsx'):
                filepath = os.path.join(base_path, filename)
                # filepath = base_path + 'result_20240408142600.tar.gz'

                msgRoot = MIMEMultipart('related')
                msgRoot['Subject'] = subject + filename
                msgRoot['From'] = senderMail
                msgRoot['To'] = receiverMail

                msgAtv = MIMEMultipart('alternative')
                msgRoot.attach(msgAtv)

                html_content = '''
                    <p>请下载附件查收 JMeter 测试报告</p>
                '''
                html = MIMEText(html_content, 'html', 'utf-8')
                msgAtv.attach(html)

                with open(filepath, 'rb') as file:
                    tar_gz_content = file.read()

                annex = MIMEBase('application', 'x-gzip')
                annex.set_payload(tar_gz_content)
                encoders.encode_base64(annex)

                annex.add_header('Content-Disposition', 'attachment', filename=os.path.basename(filepath))
                annex.add_header('Content-Type', 'application/x-gzip')

                msgRoot.attach(annex)

                server.sendmail(senderMail, receiverMail, msgRoot.as_string())
                print('邮件发送成功: {}'.format(filename))

        print('所有测试报告已发送')
    except smtplib.SMTPException as e:
        print('邮件发送异常', e)
    finally:
        server.quit()


if __name__ == '__main__':
    # 发送者邮箱地址
    senderMail = '123@qq.com'
    # 发送者 QQ 邮箱授权码
    authCode = '123456'
    # 接收者邮箱地址
    receiverMail = '456@qq.com'
    base_path = '/root/gitee-performance-testing/result/'

    send_multiple_reports(senderMail, authCode, receiverMail, get_most_recent_directory(base_path))
