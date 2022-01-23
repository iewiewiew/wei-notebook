[TOC]

<h1 align="center">Linux</h1>

> By：weimenghua  
> Date：2022.05.14  
> Description：Linux  



### 环境变量
基本提示符，对于 root 用户是#，对于普通用户是$
1. 使用 echo 命令查看单个环境变量。例如：echo $PATH
2. 使用 env 查看所有环境变量。例如：env
3. 使用 set 查看所有本地定义的环境变量。
常用的环境变量：
1. PATH      决定了 shell 将到哪些目录中寻找命令或程序
2. HOME      当前用户主目录
3. USER      当前用户
4. HISTSIZE　历史记录数
5. LOGNAME   当前用户的登录名
6. HOSTNAME　指主机的名称
7. SHELL    当前用户 Shell 类型
8. LANGUGE  语言相关的环境变量，多语言可以修改此环境变量
9. MAIL　    当前用户的邮件存放目录


### Linux 下获取当前的目录
Linux 下获取当前的目录：$(cd `dirname $0`;pwd)  
dirname $0，取得当前执行的脚本文件的父目录  
cd `dirname $0`，进入这个目录(切换当前工作目录)  
pwd，显示当前工作目录(cd 执行后的)  
在使用的过程中需注意此事项：命令中“`”不是英文的单引号，而是英文输入法下的“~”同一个按键下面的那个符号。


### Linux 设置开机自启
/etc/rc.local 映射文件是/etc/rc.d/rc.local。(前提：chmod +x /etc/rc.d/rc.local)  
在/etc/rc.local 或者/etc/rc.d/rc.local 添加执行脚本语句, 举例：sh /tmp/demo.sh。


### Linux 查看防火墙状态
1. getenforce
2. /usr/sbin/sestatus -v
SELinux 有三种工作模式，分别是：  
1. enforcing：强制模式。违反 SELinux 规则的行为将被阻止并记录到日志中
2. permissive：宽容模式。违反 SELinux 规则的行为只会记录到日志中，一般为调试用
3. disabled：关闭 SELinux
SELinux 工作模式可以在 /etc/selinux/config 中设定, 如果想从 disabled 切换到 enforcing 或者 permissive 的话，需要重启系统，反过来也一样, enforcing 和 permissive 模式可以通过 setenforce 1|0 命令快速切换


### Linux 修改主机名
1. vim /etc/sysconfig/network, 添加：HOSTNAME=主机名, hostname 新主机名, 然后用 ssh 重新登录，就会显示新的主机名。
2. hostnamectl set-hostname 新主机名, 重启：reboot。


### Linux 字体颜色
1. 浅蓝色：表示链接文件
2. 灰色：表示其他文件
3. 绿色：表示可执行文件
4. 红色：表示压缩文件
5. 蓝色：表示目录
6. 红色闪烁：表示链接的文件有问题了
7. 黄色：表示设备文件，包括 block，char，fifo


### 清除缓存 buff 或者 cache
通过 free -m 查看到 buff/cache 的值比较大，通过下面的命令，清除缓存。
echo 1 > /proc/sys/vm/drop_caches
echo 2 > /proc/sys/vm/drop_caches
echo 3 > /proc/sys/vm/drop_caches


### 常见服务对应的端口
查看远端的服务是否开通：tcp 8000 端口，比如查看 baidu.com 是否开通：telnet baidu.com 8000。
1. 21 FTP
2. 22 SSH
3. 25 SMTP
4. 3306 MYSQL
5. 873 rsync
6. 161 snmp
7. 111 rpc
8. 3389 RPC
9. 80 HTTP
10. 443 HTTPS
11. 110 POP3
12. 53 DNS
13. 514 syslog


### Linux 开放端口
$ iptables -I INPUT -p tcp --dport 80 -j DROP
$ iptables -I INPUT -p tcp -s 1.2.3.4 --dport 80 -j ACCEPT
这里仅允许 1.2.3.4 访问本地主机的 80 端口。

对于类似 docker run -d -p 80:80 shaowenchen/demo-whoami 运行的服务，上面的方法无效，需要在 DOCKER-USER 链中添加规则。
Docker 会将 iptables 规则添加到 DOCKER 链中，如果需要在 Docker 之前添加规则需要添加到 DOCKER-USER 链中
$ iptables -I DOCKER-USER -i ens192 ! -s 1.2.3.4 -p tcp --dport 80 -j DROP
ens192 是本地的网卡，这里仅允许 1.2.3.4 访问本地主机的 80 端口。

$ yum install -y iptables-services
$ systemctl restart iptables.service
如果需要在主机重启之后 iptables 设置，依然有效，需要安装 iptables-services 并保存
$ yum install -y iptables-services
$ service iptables save


### 设置 SSH 会话时长
vim /etc/ssh/sshd_config

设置 ClientAliveInterval 参数为一个较小的值，例如 300（表示 300 秒）。
设置 ClientAliveCountMax 参数为一个较大的值，例如 0（表示没有限制）。
保存并关闭配置文件。
重新加载 SSH 服务器配置，以使更改生效，可以使用 service ssh reload 或 systemctl reload sshd 命令。

ClientAliveInterval：指定服务器向客户端发送保持活动消息的时间间隔。如果在指定的时间内没有活动，服务器将向客户端发送一个保持活动的消息。
ClientAliveCountMax：指定服务器在关闭连接之前允许客户端没有响应的次数。设置为 0 表示没有限制。