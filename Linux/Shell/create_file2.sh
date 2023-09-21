#!/bin/bash


DATA=$(date +%s)
echo $DATA

for i in {1..2}; do
  dd if=/dev/urandom of=random-file.zip bs=1M count=1
  git add .
  git commit -m "add file ${DATA} ${i}"
done

git gc --prune=now