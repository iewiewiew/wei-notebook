#!/bin/bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：查看文件的 MIME 文件类型
# MIME（Multipurpose Internet Mail Extensions）是一种互联网标准，用于表示文档、图像、音频、视频等多种类型的文件。MIME 类型是一种标识不同文件类型的标准，由一个主类型和一个子类型组成，中间用斜杠（/）分隔。
  #以下是一些常见的 MIME 类型及其对应的文件类型：
  #- text/html：HTML 文档
  #- text/plain：纯文本文档
  #- image/jpeg：JPEG 格式的图像文件
  #- image/png：PNG 格式的图像文件
  #- application/pdf：PDF 文档
  #- application/msword：Microsoft Word 文档
  #- application/vnd.ms-excel：Microsoft Excel 文档
  #- audio/mpeg：MP3格式的音频文件
  #- video/mp4：MP4格式的视频文件
  #MIME 类型在互联网上的应用非常广泛，它可以帮助浏览器正确地识别和处理不同类型的文件。在 Web 开发中，开发者可以使用 MIME 类型来指定服务器向浏览器发送的文件类型。
#-----------------------------------------------------------------------------


function demo() {
    file_path='/Users/menghuawei/IdeaProjects/wei-notebook/Linux/Shell/file/img/png_1.png'
    file --mime-type ${file_path}

}

function demo2() {
    file_path='/Users/menghuawei/IdeaProjects/wei-notebook/Linux/Shell/file/img'
    ls ${file_path}
    # -R 递归处理
    file --mime-type ${file_path}/*
}

demo2
