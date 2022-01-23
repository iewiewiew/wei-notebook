#!/bin/bash

TIME=$(date +%Y-%m-%d_%H:%M:%S)

function demo() {
  mkdir -vp file/img

  # 创建 PNG 图像
  convert -size 400x300 xc:white -pointsize 36 -fill black -draw "text 100,150 'PNG Example'" file/img/example.png

  # 创建 JPG 图像
  convert -size 800x600 xc:skyblue -pointsize 24 -fill white -annotate +200+300 "JPG Example" file/img/example.jpg

  # 创建 JPEG 图像
  convert -size 800x600 xc:skyblue -pointsize 24 -fill white -annotate +200+300 "JPEG Example" file/img/example.jpeg

  # 创建 GIF 图像
  convert -size 200x150 xc:yellowgreen -fill red -stroke black -draw "rectangle 50,50 150,100" -pointsize 18 -fill black -annotate +10+130 "GIF Example" file/img/example.gif

  # 创建 TIFF 图像
  convert -size 1200x900 xc:magenta -pointsize 42 -fill yellow -annotate +500+450 "TIFF Example" file/img/example.tiff
}


function create_img() {
     mkdir -vp file/img

     for ((i=1; i<=5; i++)); do
        convert -size 800x300 xc:white -pointsize 36 -fill black -draw "text 100,150 'PNG_${i}_${TIME}'" file/img/png_${i}.png

        convert -size 800x600 xc:skyblue -pointsize 24 -fill white -annotate +200+300 "JPG_${i}_${TIME}" file/img/jpg_${i}.jpg

        convert -size 300x150 xc:yellowgreen -fill red -stroke black -draw "rectangle 50,50 150,100" -pointsize 18 -fill black -annotate +10+130 "GIF_${i}_${TIME}" file/img/gif_${i}.gif
     done
}

create_img