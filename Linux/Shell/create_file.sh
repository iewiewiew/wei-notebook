#!/bin/bash

time=$(date +%Y-%m-%d_%H:%M:%S)

function creat_file() {
  # 注：脚本创建的 ppt 打不开，手动 touch 就正常打开？
  file_suffix=(txt doc docx xls xlsx zip)

  # shellcheck disable=SC2068
  for i in ${file_suffix[@]}; do
    mkdir -vp file/${i}
    for ((j=1; j<5; j++)) ; do

        if [[ ${i} = "zip" ]]; then
          cp -R file/txt/ file/zip
          cd file/zip
          zip zip_${j}.zip txt_${j}.txt
        else
          echo ${i}_${j}_${time} > file/${i}/${i}_${j}.${i}
        fi
    done
  done
}



#.txt:文本文件
#.doc:Microsoft Word 文档
#.docx:Microsoft Word 2016 文档
#.pdf:Adobe Acrobat 文档
#.ppt:Microsoft PowerPoint 演示文稿
#.pptx:Microsoft PowerPoint 2016 演示文稿
#.xls:Microsoft Excel 工作表
#.xlsx:Microsoft Excel 2016 工作表
#.zip:压缩文件
#.rar:压缩文件
#.7z:压缩文件
#.tar:压缩文件
#.gz:压缩文件
#.bz2:压缩文件
#.iso:镜像文件
#.jpg:JPEG 图像
#.png:PNG 图像
#.gif:GIF 图像
#.svg:可缩放矢量图 (SVG)
#.json:JSON 数据文件
#.cpp:C/C++源代码文件
#.h:C/C++头文件
#.py:Python 源代码文件
#.jsp:Java 服务器页面 (JSP) 文件
#.html:超文本标记语言 (HTML) 文件
#.css:层叠样式表 (CSS) 文件
#.js:JavaScript 文件
#.ts:TypeScript 文件
#.fsx:Microsoft Windows API 文件
#.dylib:MacOS X 动态链接库文件
#.rar:RAR 压缩文件
