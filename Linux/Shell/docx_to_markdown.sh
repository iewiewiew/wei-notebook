#!/bin/bash

# pandoc /Users/menghuawei/Downloads/遥感AI解译样本数据集简介.docx -o 遥感AI解译样本数据集简介.md --wrap=none --markdown-headings=atx --standalone --extract-media=.
# 在线转换: https://word2md.com/

DOCX_DIR="/Users/menghuawei/Downloads"
OUTPUT_DIR="/Users/menghuawei/IdeaProjects/my-project/wei-notebook/a_tmp/tmp/markdown_output"

mkdir -p "$OUTPUT_DIR"

# 遍历目录下的所有docx文件
find "$DOCX_DIR" -maxdepth 1 -type f -name "*.docx" | while read -r docx_file; do
    # 获取不带扩展名的文件名
    filename=$(basename -- "$docx_file")
    filename_noext="${filename%.*}"

    # 为每个文件创建单独的媒体文件夹
    media_dir="$OUTPUT_DIR/${filename_noext}_media"
    mkdir -p "$media_dir"

    echo "正在转换: $filename → ${filename_noext}.md"
    pandoc "$docx_file" -o "$OUTPUT_DIR/${filename_noext}.md" --wrap=none --markdown-headings=atx --standalone --extract-media="$media_dir"

    # 修复图片路径（相对路径调整）
    sed -i '' "s|${filename_noext}_media/||g" "$OUTPUT_DIR/${filename_noext}.md"
done

echo "转换完成！所有文件已保存到: $OUTPUT_DIR"