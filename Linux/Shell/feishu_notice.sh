#!/bin/bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：清除文件.
#-----------------------------------------------------------------------------

function send_notice() {
    local webhook_url="https://open.feishu.cn/open-apis/bot/v2/hook/<webhook_token>"
    local json_data='{"msg_type":"interactive","card":{"elements":[{"tag":"div","text":{"content":"<at id=all></at>标题","tag":"lark_md"}},{"tag":"hr"},{"tag":"div","text":{"content":"**内容1**","tag":"lark_md"}},{"tag":"div","text":{"content":"**内容2**","tag":"lark_md"}},{"tag":"hr"},{"actions":[{"tag":"button","text":{"content":"按钮","tag":"lark_md"},"url":"http://www.gitee.com","type":"default","value":{}}],"tag":"action"}],"header":{"template":"blue","title":{"content":"头部标题","tag":"plain_text"}}}}'
    curl -X POST -H "Content-Type: application/json" -d "${json_data}" "${webhook_url}"
}


function send_notice2() {
    local webhook_url="https://open.feishu.cn/open-apis/bot/v2/hook/<webhook_token>"
    local json_data='{"msg_type":"interactive","card":{"elements":[{"tag":"div","text":{"content":"<at id=all></at>任务完成","tag":"lark_md"}},{"actions":[{"tag":"button","text":{"content":"点击查看下载周报地址","tag":"lark_md"},"url":"http://127.0.0.1:8888","type":"default","value":{}}],"tag":"action"},{"actions":[{"tag":"button","text":{"content":"点击查看Jenkins构建地址","tag":"lark_md"},"url":"http://127.0.0.1:8080/job/gitee-pref-mirrors/","type":"default","value":{}}],"tag":"action"}],"header":{"template":"blue","title":{"content":"通知","tag":"plain_text"}}}}'
    curl -X POST -H "Content-Type: application/json" -d "${json_data}" "${webhook_url}"
}


function send_notice3() {
    local webhook_url="https://open.feishu.cn/open-apis/bot/v2/hook/<webhook_token>"
    local content="构建完成，下载测试报告地址: http://${IP_ADDR}:8888"
    local json_data='{"msg_type":"text","content":{"text":"'${content}'"}}'
    curl -X POST -H "Content-Type: application/json" -d "${json_data}" "${webhook_url}"
}


#send_notice
#send_notice2
send_notice3



