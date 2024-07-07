#!/bin/bash

# Check disk usage and send alert if usage exceeds 80%
THRESHOLD=80
df -h | awk '{ if($5+0 > THRESHOLD) print $0; }' | while read output;
do
    echo "Disk usage alert: $output"
done
