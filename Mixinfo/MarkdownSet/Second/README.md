---
title: 标题
id: title_id
---

<h1 align="center">第二层的 README</h1>



# 文件相对路径

第二层相对当前路径文件 1  
`[sencond-md-1.md](sencond-md-1.md)`  
[sencond-md-1.md](sencond-md-1.md)

第二层相对当前路径文件 2  
`[sencond-md-2.md](sencond-md-2.md)`  
[sencond-md-2.md](sencond-md-2.md)

第二层相对下一层路径文件 1  
`[Third/third-md-1.md](Third/third-md-1.md)`  
[Third/third-md-1.md](Third/third-md-1.md)

第二层相对下一层路径文件 2   
`[Third/third-md-2.md](Third/third-md-2.md)`  
[Third/third-md-2.md](Third/third-md-2.md)

中文  
`[读我.md](读我.md)`  
[读我.md](读我.md)

中文+空格+英文  
`[读我%20README.md](读我%20README.md)`  
[读我%20README.md](读我%20README.md)

特殊测试  
`[超长路径下的文件](img1/img2/img3/img4/img5/img6/img7/img8/img9/img10/img11/img12/img13/img14/img15/img16/img17/img18/img19/img20/images1.png)`  
[超长路径下的文件](img1/img2/img3/img4/img5/img6/img7/img8/img9/img10/img11/img12/img13/img14/img15/img16/img17/img18/img19/img20/images1.png)



# 图片相对路径

## 相对当前路径的图片

`./img3/images1.png`

![](./img3/images1.png)

`img3/images2.png`

![](img3/images2.png)

`img3/中文.png`

![](img3/中文.png)



## 相对当前路径的隐藏目录的图片

`.img2/images1.png`

![](.img2/images1.png)



## 相对根目录的图片

`![](../img/images1.png)`

![](../img/images1.png)

`../img/gif1.gif`

![](../img/gif1.gif)



## 超长路径下的图片

`![](img1/img2/img3/img4/img5/img6/img7/img8/img9/img10/img11/img12/img13/img14/img15/img16/img17/img18/img19/img20/images1.png)`

![](img1/img2/img3/img4/img5/img6/img7/img8/img9/img10/img11/img12/img13/img14/img15/img16/img17/img18/img19/img20/images1.png)

创建超长目录
```
for i in $(seq 1 20); do
mkdir -p "img$i"
cd "img$i"
done
```



## 中文路径下的图片

`![](./中文/images1.png)`

![](./中文/images1.png)

`![](中文/images1.png)`

![](中文/images1.png)
