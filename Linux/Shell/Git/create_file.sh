#!/bin/bash

#-----------------------------------------------------------------------------
# author: wmh
# 脚本说明：创建文件
#-----------------------------------------------------------------------------

time=$(date +%Y%m%d%H%M%S)

function creat_file() {
  # 注：脚本创建的 ppt 打不开，手动 touch 就正常打开？
  # file_suffix=(txt doc docx xls xlsx zip)
   file_suffix=(docx)

  # shellcheck disable=SC2068
  for i in ${file_suffix[@]}; do
    mkdir -vp ../lfs/file/${i}
    for ((j=1; j<=6; j++)) ; do

        if [[ ${i} = "zip" ]]; then
          cp -R ../lfs/file/txt/ ../lfs/file/zip
          cd ../lfs/file/zip
          zip zip_${j}.zip txt_${j}.txt
        else
          echo ${i}_${j}_${time} > ../lfs/file/${i}/${i}_${j}.${i}
        fi
    done
  done
}


creat_file
