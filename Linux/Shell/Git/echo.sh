#!/bin/bash

time=`date +%Y%m%d%H%M%S`
uuid=`uuidgen`
echo $time $uuid  >> tmp.txt

