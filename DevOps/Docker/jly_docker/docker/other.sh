#!/usr/bin/env bash

#根据容器名称找到容器 ID
docker ps | grep jly-aps-oms-v002 | grep -v grep | awk '{print $1}'