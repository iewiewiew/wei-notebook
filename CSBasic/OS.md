[TOC]

<h1 align="center">OS</h1>

> By：weimenghua  
> Date：2022.06.07  
> Description：操作系统



## 1. CPU

CPU是电脑的中央处理器，是计算机的“大脑”，而GPU是电脑的图形处理器，又被称为“显卡”。 CPU一般由逻辑运算单元、控制单元和存储单元组成，是信息处理、程序运行的最终执行单元。 GPU则是一种专门在个人电脑和一些移动设备上做图像和图形相关运算工作的微处理器，实现图形加速。

32 位和 64 位 CPU 的区别：  
32 位 CPU ⼀次可以计算 4 个字节；
64 位 CPU ⼀次可以计算 8 个字节；
这里的 32 位和 64 位，通常称为 CPU 的位宽。

查看 CPU 信息：lscpu. 
逻辑cpu = 物理cpu个数 × cpu核数
4核指的是CPU有4个独立的核心，核心数越多，CPU的多任务处理能力就越强。



## 2. 内存

###  VM 虚拟内存

现代操作系统中的进程在使用内存的时候，都不是直接访问内存物理地址的，进程访问的都是虚拟内存地址，然后虚拟内存地址再转化为内存物理地址。  
为什么要使用虚拟内存呢？有以下两个优点？  
虚拟地址空间可以大于实际的内存空间，比如实际内存大小是1G,但是虚拟地址空间可以是4G。这样在操作系统中的普通应用程序看来，就好像是有4G 的可用内存。一个以上的虚拟地址可指向同一个物理内存地址。这个很好理解，虚拟地址到物理地址的映射可以是多对一的。  
虚拟内存（Virtual Memory）是指计算机呈现出要比实际拥有的内存大得多的内存量。因此它允许程序员编制并运行比实际系统拥有的内存大得多的程序。这使得许多大型项目也能够在具有有限内存资源的系统上实现。一个很恰当的比喻是：你不需要很长的轨道就可以让一列火车从上海开到北京。你只需要足够长的铁轨（比如说3公里）就可以完成这个任务。采取的方法是把后面的铁轨立刻铺到火车的前面，只要你的操作足够快并能满足要求，列车就能象在一条完整的轨道上运行。这也就是虚拟内存管理需要完成的任务。  

### Shared 共享内存

shared：共享内存是 IPC 机制中的一种，顾名思义，它允许两个不相关的进程访问同一段内存，这也是一种传递数据的有效方式。  
当一个程序加载进内存后，它就被分成叫作页的块。通信将存在内存的两个页之间或者两个独立的进程之间。总之，当一个程序想和另外一个程序通信的时候，那内存将会为这两个程序生成一块公共的内存区域，这块被两个进程分享的内存区域叫做共享内存。  
因为所有进程共享同一块内存，共享内存在各种进程间通信方式中具有最高的效率。访问共享内存区域和访问进程独有的内存区域一样快，并不需要通过系统调用或者其它需要切入内核的过程来完成，同时它也避免了对数据的各种不必要的复制。  
如果没有共享内存的概念，那一个进程不能存取另外一个进程的内存部分，因而导致共享数据或者通信失效。因为系统内核没有对访问共享内存进行同步，必须提供自己的同步措施。  

###  Cache 缓存

缓存就是数据交换的缓冲区（称作 cache），CPU 要读取一个数据时，首先从 cache 中查找，如果找到就立即读取并送给 CPU 处理；如果没有找到，就用相对慢的速度从内存中读取并送给 CPU 处理，同时把这个数据所在的数据块调入 cache 中，可以使得以后对整块数据的读取都从 cache 中进行，不必再调用内存。

###  SWAP 分区

swap 分区即交换区，Swap 空间的作用可简单描述为：当系统的物理内存（RAM）不够用的时候，就需要将物理内存中的一部分空间释放出来，以供当前运行的程序使用度。那些被释放的空间可能来自一些很长时间没有什么操作的程序（内存中不活跃的页），这些被释放的空间被临时保存到 Swap 空间中，等到那些程序要运行时，再从内 Swap 中恢复保存的数据到内存中（swap out 和 swap in）。



## 3. 磁盘

### 磁盘阵列

磁盘阵列（Redundant Arrays of Independent Disks，RAID），有"数块独立磁盘构成具有冗余能力的阵列”之意。
磁盘阵列是由很多块独立的磁盘，组合成一个容量巨大的磁盘组，利用个别磁盘提供数据所产生加成效果提升整个磁盘系统效能。利用这项技术，将数据切割成许多区段，分别存放在各个硬盘上。
磁盘阵列还能利用同位检查（Parity Check）的观念，当数组中任意一个硬盘发生故障时，仍可读出数据。在数据重构时，可将数据经计算后重新置入新硬盘中。

- online  表示正常状态
- degraded  降级状态表示 RAID 组中有故障或离线的硬盘，但基于 RAID 组的磁盘仍然可以正常读写
- offline  表示 RAID 组存在超过允许范围的故障或离线硬盘，RAID 组瘫痪，数据已无法读写
- Failed 表示虚拟磁盘已经失败
- rebuild RAID 重建状态表示 RAID 组正在进行数据同步

### Linux 硬盘

/dev/hda, /dev/hdb, /dev/sda, /dev/sdb。  
hda 一般是指 IDE 接口的硬盘，hda 指第一块硬盘，hdb 指第二块硬盘等等；sda 一般是指 SATA 接口的硬盘，sda 指第一块硬盘，sdb 指第二块硬盘等等。



## 4. 其它

### DLL 动态链接库

DLL（Dynamic-Link Library）相当于 Linux 下的共享对象。Windows 系统中大量采用 DLL 机制，甚至内核的结构很大程度依赖于 DLL 机制。Windows 下的 DLL 文件和 EXE 文件实际上是一个概念，都是 PE 格式的二进制文件。一般的动态库程序有 lib 文件和 dll 文件，lib 文件是编译时期连接到应用程序中的，而 dll 文件才是运行时才会被调用的。

死锁是指两个或两个以上的进程（线程）在运行过程中因争夺资源而造成的一种僵局（Deadly-Embrace) ) ，若无外力作用，这些进程（线程）都将无法向前推进。
先看生活中的一个实例，2个人一起吃饭但是只有一双筷子，2人轮流吃（同时拥有2只筷子才能吃）。某一个时候，一个拿了左筷子，一人拿了右筷子，2个人都同时占用一个资源，等待另一个资源，这个时候甲在等待乙吃完并释放它占有的筷子，同理，乙也在等待甲吃完并释放它占有的筷子，这样就陷入了一个死循环，谁也无法继续吃饭。
在计算机系统中也存在类似的情况。例如，某计算机系统中只有一台打印机和一台输入设备，进程 P1正占用输入设备，同时又提出使用打印机的请求，但此时打印机正被进程 P2 所占用，而 P2在未释放打印机之前，又提出请求使用正被 P1占用着的输入设备。这样两个进程相互无休止地等待下去，均无法继续执行，此时两个进程陷入死锁状态。

- 预防死锁：通过设置某些限制条件，去破坏产生死锁的四个必要条件中的一个或几个条件，来防止死锁的发生。
- 避免死锁：在资源的动态分配过程中，用某种方法去防止系统进入不安全状态，从而避免死锁的发生。
- 检测死锁：允许系统在运行过程中发生死锁，但可设置检测机构及时检测死锁的发生，并采取适当措施加以清除。
- 解除死锁：当检测出死锁后，便采取适当措施将进程从死锁状态中解脱出来。

- 产生条件：1、互斥条件；2、请求保持；3、不可剥夺；4、环路等待
- 解决方法：1、预防死锁；2、避免死锁；3、死锁检测
- 产生原因：1、资源抢占；2、程序推进顺序

### 计算机存储单位

计算机存储信息的最小单位，称之为位（bit），音译比特，二进制的一个“0”或一个“1”叫一位。

- 1KB=1024B
- 1MB=1024KB
- 1GB=1024MB
- 1TB=1024GB
- 1PB=1024TB
- 1EB=1024PB
- 1ZB=1024EB
- 1YB=1024ZB

数据大小单位表

| **单位**     | **缩写** | **字节数（B）**                     | **换算关系**    |
| ------------ | -------- | ----------------------------------- | --------------- |
| **比特**     | bit      | 1 位（最小单位）                    | 8 bit = 1 byte  |
| **字节**     | B        | 1 byte                              | 1 B = 8 bit     |
| **千字节**   | KB       | 1,024 B                             | 1 KB = 1,024 B  |
| **兆字节**   | MB       | 1,048,576 B                         | 1 MB = 1,024 KB |
| **千兆字节** | GB       | 1,073,741,824 B                     | 1 GB = 1,024 MB |
| **太字节**   | TB       | 1,099,511,627,776 B                 | 1 TB = 1,024 GB |
| **拍字节**   | PB       | 1,125,899,906,842,624 B             | 1 PB = 1,024 TB |
| **艾字节**   | EB       | 1,152,921,504,606,846,976 B         | 1 EB = 1,024 PB |
| **泽字节**   | ZB       | 1,180,591,620,717,411,303,424 B     | 1 ZB = 1,024 EB |
| **尧字节**   | YB       | 1,208,925,819,614,629,174,706,176 B | 1 YB = 1,024 ZB |




### CMD 手册

生成目录结构

方式一  tree

```
用法：    
tree [drive][path] [/F] [/A]  
/F 显示所有目录及目录下的所有文件，省略时，只显示目录，不显示目录下的文件  
/A 使用 ASCII 字符，而不使用扩展字符  
举例：
1. tree //展示当前目录
2. tree D:\software\IdeaProjects\wei-notebook //展示指定目录
3. tree D:\software\IdeaProjects\wei-notebook > D:\software\IdeaProjects\wei-notebook\目录结构.txt //指定目录存储到指定文件
4. tree D:\software\IdeaProjects\wei-notebook /A > D:\software\IdeaProjects\wei-notebook\目录结构.txt //指定目录存储到指定文件
5. tree D:\software\IdeaProjects\wei-notebook /F > D:\software\IdeaProjects\wei-notebook\目录结构.txt //指定目录及文件存储到指定文件
6. tree D:\software\IdeaProjects\wei-notebook -i "公众号资料" //忽略目录
7. tree -I "node_modules" //排除文件夹
8. tree -I "node_modules|cache|test_*" //排除多个文件夹
9. tree -L 2 //只看两级目录
10. tree -L 1 > 目录结构.txt
    注：windows 下的 tree 命令被阉割了，只有/F 和/A 命令，为使用更加完整的功能，可以使用 Tree for Windows 工具。
    在[Tree for Winodws](http://gnuwin32.sourceforge.net/packages/tree.htm) 页面，下载二进制文件 Binaries zip。
    解压压缩包，找到压缩包内的 bin 目录，将 bin 目录下的 tree.exe 复制到 git 文件夹 Git\usr\bin 目录下，将 tree.exe 粘贴到该目录下，安装完成，进入 git bash 即可使用。

#### 方式二 treer
安装 treer：npm install -g treer  
用法：
1. treer -d <指定路径>
2. treer -e <导出路径>
3. treer -i <"文件名，支持正则表达式/regex/">  //-i 是忽略不需要的目录，多个文件用竖线 | 隔开,前后要用斜线 / 包括
   举例：
   treer -d D:\software\IdeaProjects\wei-notebook -e D:\software\IdeaProjects\wei-notebook\目录结构.txt -i "/.git|.idea|lib|公众号资料|README.md/"  
   treer -d D:\software\IdeaProjects\Learn-Java -e D:\software\IdeaProjects\Learn-Java\目录结构.txt -i "/.git|.idea|lib|公众号资料|README.md/"

#### mac tree
brew install tree
tree -I /Users/menghuawei/IdeaProjects/wei-notebook -L 2 > /Users/menghuawei/IdeaProjects/wei-notebook/目录结构.txt -I "lib|tmp|wei-notebook.iml|目录结构.txt"
(似乎无法指定路径，直接生成当前目录结构)
```

### 构造文件

```
用法：fsutil file createNew <filename> <length>  #命令中指定文件大小的单位是 byte 

1 byte = 8 bit  
1 KB = 1024 byte  
1 MB = 1024 KB  
1 GB = 1024 MB  
1G = 1024 * 1024 *1024 = 1073741824 byte

例子1：fsutil file createnew d:\demo.jpg 1  
例子2：fsutil file createnew d:\demo.txt 0
例子3：fsutil file createnew d:\500M.bak 524288000
例子4：fsutil file createnew d:\1G.bak 1073741824
```



### APT

高级打包工具（英语：Advanced Packaging Tools，缩写为APT）是Debian及其派生的Linux软件包管理器。APT可以自动下载，配置，安装二进制或者源代码格式的软件包，因此简化了Unix系统上管理软件的过程。APT最早被设计成dpkg的前端，用来处理deb格式的软件包。现在经过APT-RPM组织修改，APT已经可以安装在支持RPM的系统管理RPM包。
APT由以下的几个主要的命令构成：  
- apt-get  
- apt-cache
- apt-file
在Debian系统中，APT建构于dpkg之上。

打印所有软件包的列表，包括软件包的版本和结构的信息。
sudo apt list

从APT存储库中获取最新索引数据
sudo apt update

安装Ansible软件包
sudo apt install ansible

ubuntu 系统启用 root 用户远程登陆

1. 使用ubuntu用户登陆到系统中；

2. 编辑/etc/ssh/sshd_config文件；  
sudo vim /etc/ssh/sshd_config  
找到配置参数：PermitRootLogin  
将该参数后面的值修改为yes即可；  
按“esc键” :wq 回车，保存退出；

3. 给root用户设置密码；  
sudo passwd root  
输入两遍密码；  
（给root用户设置了密码后，就已经可以使用root用户从vnc登陆到系统中了）

4. 重启ssh服务
sudo systemctl restart ssh  
然后测试用root用户远程登陆即可；



## 5. 知识碎片

华为芯片：麒麟、鲲鹏、昇腾、巴龙、凌霄  
银河麒麟v10 + 华为鲲鹏arm64
