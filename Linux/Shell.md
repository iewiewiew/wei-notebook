[TOC]

---

<h1 align="center">Shell</h1>

> By：weimenghua  
> Date：2022.05.14  
> Description：Shell 脚本  


### shell 数组

#### shell 数组的遍历  
1. 使用 @ 或 * 可以获取数组中的所有元素
2. ${数组名[@]} 得到是以空格隔开的元素，可以用在数组遍历中
3. ${数组名[*]} 得到的是一整个字符串
4. 注意：${数组名} 并不会获得所有值，它只会获得到第一个元素的值
即 ${数组名} 等价于 ${数组名[0]}

#### 获取所有数组元素  
方式一  
echo "${demo_array[@]}"  
方式二  
echo "${demo_array[*]}"  

#### 获取所有数组索引  
方式一  
echo "${!demo_array[@]}"  
方式二  
echo "${!demo_array[*]}"  

#### 获取数组长度  
方式一  
echo "${#demo_array[@]}"  
方式二  
echo "${#demo_array[*]}"  

删除操作  
删除某个数组元素  
unset demo_array[weight]  
删除整个数组  
unset demo_array  

模式替换  
${数组名[@]/模式/新值}  
替换 demo_array 数组中所有成员包含的"ming"为"ning"  
echo "${demo_array[@]/ming/ning}"  

遍历数组  
for value in "${demo_array[@]}"  
do  
echo "${value}"  
done  


### 软链接

ln -s file1 lnk1    #创建一个指向文件或目录的软链接
ln -s /data/.jenkins/bak_workspace bak_jenkins_workspace    #举例：在目标文件所在路径下：ln -s 源文件或目录 目标文件或目录(lnk1|目标文件或目录件：无需新建)
ln file1 lnk1   #创建一个指向文件或目录的物理链接


### 2>&1 重定向 

nohup command>/dev/null 2>&1 &  
- nohup 表示当前用户和系统的会话下的进程忽略响应 HUP 消息，也就是不挂断地运行命令
- /dev/null 表示空设备文件
- 0 表示 stdin 标准输入
- 1 表示 stdout 标准输出
- 2 表示 stderr 标准错误
- & 表示把该命令以后台的 job 的形式运行


### shell 反斜杠拼成一行  

./configure \  
–prefix=/usr \  
–sbin-path=/usr/sbin/nginx \  
–conf-path=/etc/nginx/nginx.conf \


### shell 单引号和双引号的区别

使用单引号时，内部的内容会被视为纯文本，而使用双引号时，内部的内容可以包含变量、转义字符等特殊字符。
具体来说，使用单引号时，内部所有的字符都会被原样输出，包括特殊字符和变量。

```
$ echo 'Hello, $USER'
Hello, $USER

$ echo "Hello, $USER"
Hello, username
```

```
NAME="John"
echo ${NAME}    # => John (变量)
echo $NAME      # => John (变量)
echo "$NAME"    # => John (变量)
echo '$NAME'    # => $NAME (字符串原样输出)
echo "${NAME}!" # => John! (变量)
NAME = "John"   # => Error (注意不能有空格)
```

使用单引号时可以避免变量和特殊字符的解析，因此有时候会更加安全
```
$ rm -rf '/path/to/directory'
```



### shellcheck

[shellcheck](https://github.com/koalaman/shellcheck)

```
sudo apt-get install shellcheck
brew install shellcheck
```


### 踩坑

使用 #!/bin/bash 解释器，sh start.sh 执行以下脚本，报错： `start.sh: 40: start.sh: Syntax error: "(" unexpected (expecting "}")`
```
for1() {
    array=(a b c)
    for i in ${array[@]}; do
    echo "for 循环: ${i}"
done
}
```
解决：sh 可能链接到不支持数组的解释器，应该使用 bash start.sh 来确保脚本在 Bash 解释器中执行