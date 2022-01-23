#!/usr/bin/env bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：批量创建用户.
#-----------------------------------------------------------------------------

user=`cat /tmp/user.txt`
for i in $user
do
    useradd $i
    echo "123456" |passwd --stdin "$i"
done


#-----------------------------------------------------------------------------
# author: other
# 脚本说明：批量创建用户并设置密码.
#-----------------------------------------------------------------------------

USER_LIST=$@
USER_FILE=./user.info
for USER in $USER_LIST;do
  if ! id $USER &>/dev/null; then
    PASS=$(echo $RANDOM |md5sum |cut -c 1-8)
    useradd $USER
    echo $PASS | passwd --stdin $USER &>/dev/null
    echo "$USER   $PASS" >> $USER_FILE
    echo "$USER User create successful."
  else
    echo "$USER User already exists!"
  fi
done