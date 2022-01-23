#!/bin/bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：判断用户是否存在：#id -u 用户名：返回用户 id.
#-----------------------------------------------------------------------------

username=${1}

if id -u ${username} >/dev/null 2>&1; then
    echo "user exists"
else
    echo "user does not exist"
fi