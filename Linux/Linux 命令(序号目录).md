[TOC]

<h1 align="center">Linux 命令</h1>

> By：weimenghua  
> Date：2022.05.14  
> Description：Linux   



1. awk
2. cat
3. cd
4. chmod
5. chown
6. curl
7. cut
8. date
9. dd
10. df
11. dig
12. du
13. echo
14. find
15. free
16. grep
17. groupadd
18. gzip
19. history
20. ifconfig
21. jar
22. kill
23. last
24. less
25. ln
26. locale
27. lsblk
28. lscpu
29. lsof
30. md5sum
31. mkdir
32. more
33. mv
34. netstat
35. nohup
36. nmon
37. nslookup
38. ping
39. ps
40. realpath
41. rm
42. rpm
43. rsync
44. scp
45. sed
46. service
47. set
48. sftp
49. source
50. ssh
51. su
52. systemctl
53. tar
54. tcpdump
55. top
56. traceroute
57. tree
58. uid
59. uname
60. unzip
61. useradd
62. uuidgen
63. vim
64. wc
65. whereis
66. whoami
67. yum
68. zcat
69. zless
70. zmore
71. Linux 查看硬件资源命令

---

### 0.0.1. awk
- awk '{print $5}' file                 #打印文件中以空格分隔的第五列
- awk -F ',' '{print $5}' file          #打印文件中以逗号分隔的第五列
- awk '/str/ {print $2}' file           #打印文件中包含 str 的所有行的第二列
- awk -F ',' '{print $NF}' file         #打印逗号分隔的文件中的每行最后一列
- awk '{s+=$1} END {print s}' file      #计算所有第一列的和
- awk 'NR%3==1' file                    #从第一行开始, 每隔三行打印一行

### 0.0.2. cat
- cat -n demo.txt                       #在文件中显示行号
- cat /proc/meminfo                     #查看 linux 系统内存大小的详细信息, 可以查看总内存、剩余内存、可使用内存等信息
- cat /proc/cpuinfo                     #查看 cpu 信息
- cat /proc/cpuinfo |grep "cores" |uniq #查看 cpu 个数
- cat /proc/cpuinfo |grep name |cut -f2 -d: |uniq -c #查看 cpu 型号
- cat /etc/redhat-release               #查看 linux 版本
- cat /etc/passwd | sort                #排序查看文件

### 0.0.3. cd
- cd ~      #切换到主目录
- cd /tmp   #切换到目录/tmp
- cd tmp    #切换到当前目录下的 tmp 目录
- cd /      #切换到根目录
- cd ..     #切换到到上一级目录
- cd ../..  #切换到上二级目录
- cd ~      #切换到用户目录, 比如是 root 用户, 则切换到/root 下
- cd -      #返回上次所在的目录

### 0.0.4. chmod
- chmod a+x 文件名  #给所有人添加可执行权限
- chmod u+x 文件名  #给文件所有者添加可执行权限
- chmod g+x 文件名  #给所在组添加可执行权限
- chmod o+x 文件名  #给所在组以外的人添加可执行权限  
每个文件的三组权限说明：
- a 代表全部的人, 也就是包括 u, g 和o
- u 代表所有者（user）
- g 代表所有者所在的组群（group）
- o 代表其他人, 但不是 u和 g（other）
rwx 说明：
- r------------4
- w------------2
- x------------1
- ---------------0
- --rw------- (600) 只有所有者才有读和写的权限
- --rw-r--r-- (644) 只有所有者才有读和写的权限, 组群和其他人只有读的权限
- --rwx------ (700) 只有所有者才有读, 写, 执行的权限
- --rwx--x--x (711) 只有所有者才有读, 写, 执行的权限, 组群和其他人只有执行的权限
- --rw-rw-rw- (666) 每个人都有读写的权限
- --rwxrwxrwx (777) 每个人都有读写和执行的权限
权限说明：
- 对于文件的 r,w,x 权限：  
   r: cat/more/head/tail/less  
   w: vim  
   x: script command
- 对于目录的 r,w,x 权限：  
   r: ls  
   w: touch/mkdir/rmdir/rm  
   x: cd

### 0.0.5. chown
- chown uname:gname demo.sh  #给文件分配用户和用户组, chown 用户名:用户组 文件
- chown uname:gname /tmp     #给文件分配用户和用户组, chown 用户名:用户组 文件夹

### 0.0.6. curl
- curl https://gitee.com/iewiewiew/wei-notebook      #获取页面内容或接口响应(get 请求)
- curl -I https://gitee.com/iewiewiew/wei-notebook   #-I：获取请求页面或接口的请求头信息(get 请求)
- curl -H "Content-Type:application/json" -X POST -d '{"id":"123456","username": "username123","password": "123456"}' 'http://127.0.0.1:9999/demo/add'  #-X POST：post 请求
- -f 选项表示使用安静模式（silent mode），当 HTTP 服务器返回错误码时不输出任何信息。
- -s 选项表示使用静默模式（silent mode），不输出任何进度或统计信息，仅输出需要的内容。
- -S 选项表示显示错误（show errors），在 HTTP 服务器返回错误码时输出错误信息。
- -L 选项表示跟踪重定向（follow redirect），自动跟踪 HTTP 重定向链接。
例子：curl -fsSL https://get.docker.com -o get-docker.sh

### 0.0.7. cut
- cut -c 1-16                          #截取每行头16个字符
- cut -c 1-16 file                     #截取指定文件中每行头 16个字符
- cut -c3 -                            #截取每行从第三个字符开始到行末的内容
- cut -d ':' -f5                       #截取用冒号分隔的第五列内容
- cut -d ';' -f2, 10                   #截取用分号分隔的第二和第十列内容
- cut -d ' ' -f3 -7                    #截取空格分隔的三到七列

### 0.0.8. date
- date                                 #Wed May 11 10:23:43 CST 2022
- date +%Y%m%d                         #注意：+前面有空格
- date +%Y-%m-%d%t%H:%M:%S
- date -R                              #以 RFC 2822 格式显示当前时间和日期，例如：Wed, 12 Jul 2023 14:54:29 +0800

### 0.0.9. dd
- dd if=/dev/random of=binary bs=1024000 count=1		# 创建1M 文件

### 0.0.10. df
- df                                  #（Disk Free）命令用于显示目前在 linux 系统上的文件系统的磁盘使用情况统计
- df -h                               #查看 linux 系统各分区的使用情况
- df -hT

### 0.0.11. dig
安装 dig `yum install bind-utils -y`
`dig` 是一个常用的用于 DNS 查询的命令行工具，它可以用来获取域名相关的信息。以下是一些常见的 `dig` 命令用法：
1. 查询域名的 A 记录（IP 地址）：
dig example.com

2. 查询特定类型的记录，如 MX 记录（邮件交换服务器）：
dig example.com MX

3. 查询域名的 NS 记录（域名服务器）：
dig example.com NS

4. 查询域名的 CNAME 记录（别名）：
dig example.com CNAME

5. 查询域名的 TXT 记录（文本记录）：
dig example.com TXT

6. 查询域名的 AAAA 记录（IPv6 地址）：
dig example.com AAAA

7. 查询域名的 SOA 记录（授权信息）：
dig example.com SOA

### 0.0.12. du
du --max-depth=1 -h                   #查看当前的文件夹下的磁盘使用情况
du -sh 文件或文件夹路径                  #查看单个文件夹目录大小
du -sh *                              #查看当前目录下每个文件的大小
du -shk *                             #k 指定单位 KB
du -shm *                             #m 指定单位 MB
du -csh ./*                           #查看当前目录下每个文件的大小, 并且有汇总  

### 0.0.13. echo
echo 1 > /proc/sys/vm/drop_caches #清除缓存
echo 2 > /proc/sys/vm/drop_caches
echo 3 > /proc/sys/vm/drop_caches

### 0.0.14. find
- find /tmp '*.mysql' -print                          #从 /tmp 目录下找后缀是.mysql 的文件
- find /tmp -atime 3  -print                          #从 /tmp 目录开始往下找, 找最近3天之内存取过的文件
- find /tmp -ctime 5  -print                          #从 /tmp 目录开始往下找, 找最近5天之内修改过的文件
- find /tmp -user myname 'j*' –print                  #从 /tmp 目录开始往下找, 找 myname 的、文件名开头是 j 的文件
- find /tmp \(-name 'aa*' -o --name 'bb*' \) –print   #从 /tmp 目录开始往下找, 找寻文件名是 aa 开头或者 bb 开头的文件
- find /tmp -name '*bak' -exec rm {} \;               #从 /tmp 目录开始往下找, 找到凡是文件名结尾为 bak 的文件, 把它删除掉。-exec 选项是执行的意思, rm 是删除命令, { } 表示文件名, “\;”是规定的命令结尾

### 0.0.15. free
- free       #查看系统占用内存（不带单位）
- free -h    #查看系统占用内存（带单位）
- free -m    #查看 linux 系统内存使用量和交换区使用量
说明：
- Mem ：内存的使用信息
- Swap ：交换空间的使用信息
- total ：系统总的可用物理内存大小
- used ：已被使用的物理内存大小
- free ：还有多少物理内存可用
- shared ：被共享使用的物理内存大小
- buff/cache ：被 buffer 和 cache 使用的物理内存大小
- available ：还可以被使用的物理内存大小（即系统可用内存约等于 free+shared+buff/cache）

### 0.0.16. grep
- ps-ef |grep-c demo        #查看指定进程的个数
- grep-o demo demo.         #查找 demo.中的 demo 关键字（-o:只显示被模式匹配到的字符串, 而不是整个行）
- grep-v 'demo'             #反向匹配, 不包含'demo'
- more xxx-core_err.log | grep -E 'keyWordA|keyWordB' #grep-E 同时匹配多个关键字–或关系
- more xxx-core_err.log | grep keyWordA|keyWordB      #grep-E 同时匹配多个关键字–与关系
说明：grep (global search regular expression(RE)

### 0.0.17. groupadd
- groupadd gname   #添加用户组

### 0.0.18. gzip
gzip -dc demo.tar.gz | grep --binary-files=text -1 '关键字' --color  #查询 linux 的压缩文件日志, --binary-files=text 让二进制文件等价于文本文件

### 0.0.19. history
- history          #查看历史命令
- fc -l            #查看历史命令

### 0.0.20. ifconfig
/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d addr:  #获取本机 ip 地址

### 0.0.21. jar
jar -cvfM0 demo.war demo  #将 demo 压缩成 demo.war

### 0.0.22. kill
- kill   [进程 ID]          #根据进程 id 杀进程
- pkill   [进程 ID]         #根据进程名称杀进程
- killall  [进程 ID]        #根据进程名称(相关)杀进程
- kill -KILL [进程 ID]      #kill -KILL 命令用于强制终止一个进程。它发送一个无法捕获的进程终止信号给目标进程，使其立即停止运行，无论进程当前正在执行什么操作

### 0.0.23. last
- last            #查出最近当前哪些 IP 地址登录过系统

### 0.0.24. less
- less            #查看文件

### 0.0.25. ln
- ln -s file1 lnk1  #创建一个指向文件或目录的软链接
- ln -s /aa/bb cc   #举例：在目标文件所在路径下：ln -s 源文件或目录 目标文件或目录(lnk1|目标文件或目录件：无需新建)
- ln file1 lnk1     #创建一个指向文件或目录的物理链接

### 0.0.26. locale
- locale -a         #查看系统支持的语言
说明：系统编码设置为 UTF-8，并支持中文。/etc/sysconfig/i18n 的LANG=en_US.UTF-8，在不重启的情况下重新加载 i18n 文件：source /etc/sysconfig/i18n。

### 0.0.27. lsblk
- lsblk           #列出块设备
说明：
- 第一个软驱 /dev/fd0
- 第二个软驱 /dev/fd1
- 第一块硬盘 /dev/sda
- 第二块硬盘 /dev/sdb, 以此类推
- 第一个 SCSI CD-ROM /dev/scd0, 可以用/dev/sr0
- /dev/sda1 是分区 就像 windows 下的 c 盘 d 盘
- /tmp, /root, /home 是目录 就像 windows 下的 c:\windows 一样

### 0.0.28. lscpu
在使用 lscpu 命令时，会输出 CPU 的基本信息，包括：
- CPU 架构、型号、频率等信息
- CPU 处理器核心数量、线程数量等信息
- CPU 缓存大小、类型等信息
- CPU 可以使用的指令集信息
- 系统字节序（大端序或小端序）

### 0.0.29. lsof
- lsof -i:port           #根据端口号查进程查
- lsof -i:pid            #根据进程号查端口

@TODO
### 0.0.30. md5sum
md5sum tmp.txt

### 0.0.31. mkdir
- mkdir –vp 目录1/目录2/目录3 #递归创建目录
- mkdir-vp scf/{lib/,bin/,tmp/{info,product},logs/{info,product},service/deploy/{info,product}}
- mkdir-vp-m 664 /d1/d2/d3/d4 #在创建目录的同时设定权限（而不是采用 umask 默认值）, 创建目录的同时设定权限为664
- mkdir $(date +"%Y-%m-%d")
- mkdir "$(date +"%Y-%m-%d")"
说明：
- -v：显示命令执行过程中的详细信息（每次创建新目录都显示信息）
- -p：创建子目录, 确保目录名称存在, 如果目录不存在的就新创建一个

### 0.0.32. more
- more                  #查看文件, 空格键：向下翻一页, b：向上翻一页, 回车键：向下滚动一行, q：离开 more/less 模式

### 0.0.33. mv
- mv /A/* . 	        #将/A 中的所有文件移到当前目录(用”.”表示)中
- mv A/*  /B/           #把当前目录的一个子目录里的文件移动到另一个子目录里
- mv * ../              #移动当前文件夹下的所有文件到上一级目录
- mv test.txt demo.txt  #将文件 test.txt 重命名为 demo.txt, 注意：如果当前目录下也有个 demo.txt 的文件的话, 这个文件是会将它覆盖
- mv A B                #将目录 A重命名为 B
- mv /A /B/C            #将/a 目录移动到/b 下, 并重命名为 c

### 0.0.34. netstat
- netstat -tunlp |grep port  #根据端口号查进程
- netstat -tunlp |grep pid   #根据进程号查端口
说明：
- -t (tcp) 仅显示 tcp 相关选项
- -u (udp) 仅显示 udp 相关选项
- -n 拒绝显示别名, 能显示数字的全部转化为数字
- -l 仅列出在 Listen(监听)的服务状态
- -p 显示建立相关链接的程序名  
  列出所有端口 (包括监听和未监听的)
- netstat -anp   #查看已开放的端口
- netstat -a     #列出所有端口
- netstat -at    #列出所有 tcp 端口
- netstat -au    #列出所有 udp 端口  
  列出所有处于监听状态的 Sockets
- netstat-l      #只显示监听端口
- netstat-lt     #只列出所有监听 tcp 端口
- netstat-lu     #只列出所有监听 udp 端口
- netstat-lx     #只列出所有监听 UNIX 端口  
  显示每个协议的统计信息
- netstat-s      #显示所有端口的统计信息

### 0.0.35. nohup
- nohup command &   #后台运行, 关掉终端也会继续运行。
- command &         #后台运行, 关掉终端会停止运行。
说明：nohup 的作用可以将程序以忽略挂起信号（SIGHUP）的方式运行。常见的用法是和 & 命令一同使用, 将命令放置到后台运行, 即使终端挂掉, 进程会忽略挂起信号, 继续运行。

### 0.0.36. nmon
- nmon           #监控系统资源

### 0.0.37. nslookup
- nslookup gitee.com            #查询域名对应的 IP 地址

### 0.0.38. ping
- ping gitee.com    #在网络中 ping 是一个十分强大的 TCP/IP 工具。它的作用主要为： 1、用来检测网络的连通情况和分析网络速度 2、根据域名得到服务器 IP 3、根据 ping 返回的 TTL 值来判断对方所使用的操作系统及数据包经过路由器数量。

常用的 ping 命令选项包括：
- `-c`：指定发送`ICMP`请求的次数。
- `-i`：指定发送`ICMP`请求的时间间隔。
- `-s`：指定`ICMP`请求的数据包大小。
- `-t`：在`ping`命令结果中显示时间戳。

举例：
ping -c 5 -s 64 gitee.com

### 0.0.39. ps
- ps -ef | grep tomcat*                                  #根据进程名称查找相关进程
- ps -ef | grep port                                     #根据端口号查找相关进程
- ps -ef | grep pid                                      #根据进程号查找相关进程
- ps aux|grep nginx|grep -v grep|awk '{print $2}'        #查看应用进程号
- ps aux|head -1;ps aux|grep -v PID|sort -rn -k +3|head  #linux 下获取占用 CPU 资源最多的10个进程

### 0.0.40. realpath
- realpath 文件名    #打印出文件的绝对路径

### 0.0.41. rm
- rm -rf !(demo1 | demo2)  #删除 demo1和 demo2文件之外的所有文件

### 0.0.42. rpm
- rpm-qa|grep demo       #查找 demo 安装包
- rpm-ql demo            #查找 demo 安装包的安装路径
- rpm-qa                 #查询所有安装的 rpm 包, 可以配合 grep 命令
- rpm-qi demo            #查询某个具体包的介绍
- rpm-ivh 包名（支持*）    #安装 rpm 包
- rpm-e 包名（不支持*）    #卸载 rpm 包

### 0.0.43. rsync
- rsync -avz /tmp/test /tmp/backup       #本地备份
- rsync -avz /tmp/ root@172.17.1.1:/tmp  #备份（推送）到远程主机
- rsync -avz root@172.17.1.1:/tmp /tmp   #在本地拉取远程主机文件
- rsync -avz --delete test/ tmp--exclude=common/settings.py serverid.txt  #--exclude 的路径是相对源目录的路径, 不能用绝对路径
说明：
- 安装：yum-y install rsync
- -v         ----详细模式输出
- -a         ----归档模式, 递归传输并保持文件属性不变
- -z         ----压缩传输
- -delete    ----删除那些 DST 中存在而在 SRC 中没有的文件

### 0.0.44. scp
- scp -r root@127.0.0.1:/tmp  /tmp  #将服务器上的文件复制到本地（另一台服务器）
- scp -r /tmp/ root@127.0.0.1:/tmp  #将本地的文件复制到远程服务器上, 注：无/ 

### 0.0.45. sed
```
- sed 's/find/replace/' file          #替换文件中首次出现的字符串并输出结果
- sed '10s/find/replace/' file        #替换文件第 10 行内容
- sed '10,20s/find/replace/' file     #替换文件中 10-20 行内容
- sed -r 's/regex/replace/g' file     #替换文件中所有出现的字符串
- sed -i 's/find/replace/g' file      #替换文件中所有出现的字符并且覆盖文件
- sed -i '/find/i\newline' file       #在文件的匹配文本前插入行
- sed -i '/find/a\newline' file       #在文件的匹配文本后插入行
- sed '/line/s/find/replace/' file    #先搜索行特征再执行替换
- sed -e 's/f/r/'-e 's/f/r' file      #执行多次替换
- sed 's#find#replace#' file          #使用 # 替换 / 来避免 pattern 中有斜杆
- sed -i-r 's/^\s+//g' file           #删除文件每行头部空格
- sed '/^$/d' file                    #删除文件空行并打印
- sed -i 's/\s\+$//' file             #删除文件每行末尾多余空格
- sed -n '2p' file                    #打印文件第二行
- sed -n '2,5p' file                  #打印文件第二到第五行
- sed -n '100 p' demo.                #-n 选项屏蔽默认输出
- sed -n '100,200 p' demo.            #执行查看哪几行内容
- sed -i '$a\upstream '"${codeName}"'-oms {\n\tserver 127.0.0.1:'"${tomcat_http_port}"';\n}\n' /app/demo/upstream.conf; # 踩坑：'"变量名称"' ：变量需加上 '""'
- sed -i "s/aaa/bbb/g" /tmp/*/*/demo.txt; #替换:将文本里所有 aaa 替换为 bbb。s:search 查找并替换; g:global 全部替换; -i:implace; * 通配符。
- sed -i '$a\末尾追加内容' /tmp/demo.txt; #末尾追加内容。$获取文件的末尾, a 追加在文件末尾。
- sed -i '/aaa/ i\指定行（关键字）前加' /tmp/demo.txt; #在指定行（关键字）前面添加内容。前面追加 i; 后面追加 a。
- sed -i '/aaa/ a\指定行（关键字）后加' /tmp/demo.txt; #在指定行（关键字）后面添加内容。前面追加 i; 后面追加 a。
- sed -i '/aaa/i 指定行（关键字）前加' /tmp/demo.txt;  #在指定行（关键字）前面添加内容。前面追加 i; 后面追加 a。
- sed -i '/aaa/a 指定行（关键字）后加' /tmp/demo.txt;  #在指定行（关键字）后面添加内容。前面追加 i; 后面追加 a。
- sed -i '10 i 指定行（行号）前加' /tmp/demo.txt;      #在指定行（行号）前面添加内容。前面追加 i; 后面追加 a。
- sed -i '10 a 指定行（行号）后加' /tmp/demo.txt;      #在指定行（行号）后面添加内容。前面追加 i; 后面追加 a。
- sed -i "s/<core>[0-9]<\/core>.*$/<core>2<\/core>/g" /tmp/demo.txt #/ 需用 \ 来转义
```

### 0.0.46. service
- service network restart  #重启网络, 方式二：/etc/init.d/network restart

### 0.0.47. set
- 在"set-e"之后出现的代码, 一旦出现了返回值非零, 整个脚本就会立即退出, exit 0---是正常退出的命令, exit 1---是非正常退出的命令, echo $?获取上次命令执行的结果, 如果是0就是正常执行, 如果非0就是执行出现了异常
- set-x 会在执行每一行 shell 脚本时, 把执行的内容输出来, 看到当前执行的情况, 里面涉及的变量也会被替换成实际的值

### 0.0.48. sftp
- sftp -P 端口号 用户名@服务器地址  #连接 SFTP 服务器
- get xxx（文件名）               #下载文件
- get -r xxx（文件夹名）          #下载文件夹
- put xxx（文件名）               #上传文件
- put -r xxx（文件夹名）          #上传文件夹

### 0.0.49. source
- source /etc/profile                #使配置文件生效

### 0.0.50. ssh
- ssh-keygen  #不加邮箱的话 id_rsa.pub 的后缀就是机器的用户名。管理节点生成 SSH-KEY,  之后一路回车就行啦; 会在～（home）目录下中产生.ssh（隐藏）文件夹, 里面有两个文件 id_rsa(私钥)、id_rsa.pub(公钥)文件, 通过 ls -a 查看隐藏文件
- ssh-keygen -t rsa -C "1425615649@qq.com"
- ssh-keygen -t rsa -C "demo@qq.com", 输入名称: demo.rsa
- ssh-keygen -t rsa  -N "" -C "demo@qq.com" -f /root/.ssh/id_rsa
- ssh-keygen -t rsa  -N "" -C "demo@qq.com" -f ./id_rsa
- ssh-copy-id root@目标节点 IP #ssh-copy-id root@127.0.0.1, 添加目标节点的 SSH 认证信息。添加认证信息后, 目标节点主机的~/.ssh/目录下将会出现一个 authorized_keys 文件, 里面包含了管理节点的 id_rsa.pub(公钥)信息
- ssh root@127.0.0.1 #验证是否安装成功
- exit #退出免密登录

### 0.0.51. su
- su 用户名   #su 是switch user 的缩写, 表示用户切换, 从新的用户状态下输入“exit”即可退回到刚才的用户状态

### 0.0.52. systemctl
- systemctl redis start
- systemctl redis stop
- systemctl enable redis   #开机自启动  
说明：systemd 是linux 系统最新的初始化系统(init),作用是提高系统的启动速度, 尽可能启动较少的进程, 尽可能更多进程并发启动。systemd 对应的进程管理命令是 systemctl。

### 0.0.53. tar
- tar -zxvf demo.tar.gz                   #解压 demo.tar.gz 到当前目录下
- tar -xvf demo.tar.gz --force-local      #去掉 z,--force-local 忽略特殊符号
- tar -cvf demo.tar.gz demo --force-local #压缩文件

### 0.0.54. tcpdump
- tcpdump tcp port 3306
- tcpdump udp port 3306

### 0.0.55. traceroute
Traceroute 命令用于跟踪数据包在网络中的传输路径。它通过向目标主机发送一系列 ICMP 回显请求，并记录每个请求经过的路由器 IP 地址和响应时间，从而帮助用户诊断网络故障。  

常用的 traceroute 命令选项包括：
-I：使用 ICMP 协议发送数据包。
-T：使用 TCP 协议发送数据包。
-U：使用 UDP 协议发送数据包。
-p：指定发送数据包的目标端口号。

- traceroute gitee.com


### 0.0.56. top
- top                           #查看进程占用内存
- top -s

### 0.0.57. tree
- tree                          #树状图列出目录内容, yum-y install tree

### 0.0.58. uid
- uid                           #查看用户的 uid 和gid：cat /etc/passwd
- id demo                       #查看用户 id
- id -u demo                    #查看用户 uid
- id -g demo                    #查看用户 gid
- usermod -u 666 demo           #修改用户 demo 的uid
- usermod -g 600 demo           #修改用户 demo 的gid
- usermod -l new_username old_username    #修改用户名
- usermod -u 666 new_username             #修改用户 uid
- usermod -d /tmp -m new_username         #修改用户家目录
- usermod -u 666 -g 600 demo              #同时修改 uid 和gid
- groupmod -g xxx demo                    #修改用户组 demo 的gid

### 0.0.59. uname
- uname -a                       #查看 linux 名称

### 0.0.60. unzip
- unzip -oq demo.war -d /tmp #将 demo.war 解压到指定目录/tmp,不加-d 则默认解压到当前目录

### 0.0.61. useradd
- useradd –g 组名 用户名          #添加用户

### 0.0.62. uuidgen
- uuidgen  #生成 uuid

### 0.0.63. vim
vim ~/.vimrc  
set ts=4 #设置为4个字符  
set noexpandtab  
set expandtab #设置为4个空格  
注：脚本里面不能有注释, 否则编辑其它文件时的时候会报错, 不过不影响使用  
1、多行删除  
vim 进入命令模式 ：输入 ：set nu 即可查看行号, 输入 ：4,6d 即可删除4到6行, 按 u可恢复删除的内容  
2、单行删除  
vim 进入命令模式, 输入：dd , 按 u可恢复删除的内容

### 0.0.64. wc
- grep-o keyword filename |wc-l     #查询关键字出现的次数
说明：
- o: 只输出匹配的具体字符串,匹配行中其他内容不会输出-o 参数将行转化成列
- keyword：指定的关键字
- filename：指定的文件
- |wc-l ：统计的次数

### 0.0.65. whereis
- whereis demo   #查看软件安装的路径, demo 表示软件名称

### 0.0.66. whoami
- whoami #查看当前用户

### 0.0.67. yum
- yum install-y epel-release #配置 yum 源
- yum install 软件名称        #安装软件, 手动选择 y or n  
- yum-y install 软件名称      #安装软件, 自动选择 y
- yum remove 软件名称         #卸载软件
- yum update 软件名称         #更新软件
- yum list                   #列出所有可安装的软件包
- yum list updates           #列出所有可更新的软件包
- yum list installed         #列出所有已安装的软件包
- yum info updates           #列出所有可更新的软件包信息
- yum info installed         #列出所有已安裝的软件包信息
- yum clean all              #清理内存

### 0.0.68. zcat
- zcat demo..tar.gz

### 0.0.69. zless
- zless demo..tar.gz

### 0.0.70. zmore
- zmore demo..tar.gz

### 0.0.71. Linux 查看硬件资源命令
```
1. uname -a                     #查看内核/操作系统/CPU 信息
2. head -n 1 /etc/issue         #查看操作系统版本
3. cat /proc/cpuinfo            #查看 CPU 信息
4. hostname                     #查看计算机名
5. lspci -tv                    #列出所有 PCI 设备
6. lsusb -tv                    #列出所有 USB 设备
7. lsmod                        #列出加载的内核模块
8. env                          #查看环境变量资源
9. free -m                      #查看内存使用量和交换区使用量
10. df -h                       #查看各分区使用情况
11. du -sh <目录名>              #查看指定目录的大小
12. grep MemTotal /proc/meminfo #查看内存总量
13. grep MemFree /proc/meminfo  #查看空闲内存量
14. uptime                      #查看系统运行时间、用户数、负载
15. cat /proc/loadavg           #查看系统负载磁盘和分区
16. mount | column -t           #查看挂接的分区状态
17. fdisk -l                    #查看所有分区
18. swapon -s                   #查看所有交换分区
19. hdparm -i /dev/hda          #查看磁盘参数(仅适用于 IDE 设备)
20. dmesg | grep IDE            #查看启动时 IDE 设备检测状况网络
21. ifconfig                    #查看所有网络接口的属性
22. iptables -L                 #查看防火墙设置
23. route -n                    #查看路由表
24. netstat -lntp               #查看所有监听端口
25. netstat -antp               #查看所有已经建立的连接
26. netstat -s                  #查看网络统计信息进程
27. ps -ef                      #查看所有进程
28. top                         #实时显示进程状态用户
29. w                           #查看活动用户
30. id <用户名>                  #查看指定用户信息
31. last                        #查看用户登录日志
32. cut -d: -f1 /etc/passwd     #查看系统所有用户
33. cut -d: -f1 /etc/group      #查看系统所有组
34. crontab -l                  #查看当前用户的计划任务服务
35. chkconfig –list             #列出所有系统服务
36. chkconfig –list | grep on   #列出所有启动的系统服务程序
37. rpm -qa                     #查看所有安装的软件包
```

### 0.0.72. 草稿
```
查看服务器开放的端口
iptables -n -L
firewall-cmd --zone=public --list-ports

操作系统 IPC 共享内存/队列
ipcs

监控各进程的网络流量
nethogs
```
