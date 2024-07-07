[TOC]

<h1 align="center">Network</h1>

> By：weimenghua  
> Date：2022.05.24  
> Description：计算机网络

**参考资料**  
[lemon-guide](https://gitee.com/yu120/lemon-guide)



## 1. 网络基础

### OSI 网络七层协议

![](./img/http-7.png)

### 网络四层模型

- 应用层：HTTP、SSH、FTP
- 传输层：TCP、UDP
- 网络层：IP
- 网络接口层：以太网

网络层有四个协议：ARP 协议，IP 协议，ICMP 协议，IGMP 协议。ARP 协议为 IP 协议提供服务，IP 协议为 ICMP 协议提供服务，ICMP 协议为 IGMP 协议提供服务。  
- ARP 协议：地址解析协议，即 ARP（Address Resolution Protocol），是根据 IP 地址获取物理地址的一个 TCP/IP 协议。
- IP 是Internet Protocol（网际互连协议）的缩写，是 TCP/IP 体系中的网络层协议。设计 IP 的目的是提高网络的可扩展性：一是解决互联网问题，实现大规模、异构网络的互联互通；二是分割顶层网络应用和底层网络技术之间的耦合关系，以利于两者的独立发展。根据端到端的设计原则，IP 只为主机提供一种无连接、不可靠的、尽力而为的数据包传输服务。
- ICMP（Internet Control Message Protocol）Internet 控制报文协议。它是 TCP/IP 协议簇的一个子协议，用于在 IP 主机、路由器之间传递控制消息。控制消息是指网络通不通、主机是否可达、路由是否可用等网络本身的消息。这些控制消息虽然并不传输用户数据，但是对于用户数据的传递起着重要的作用。
- IGMP 协议：互联网组管理协议（IGMP，Internet Group Management Protocol）是因特网协议家族中的一个组播协议。TCP/IP 协议族的一个子协议，用于 IP 主机向任一个直接相邻的路由器报告他们的组成员情况。允许 Internet 主机参加多播，也是 IP 主机用作向相邻多目路由器报告多目组成员的协议。多目路由器是支持组播的路由器，向本地网络发送 IGMP 查询。主机通过发送 IGMP 报告来应答查询。组播路由器负责将组播包转发到所有网络中组播成员。

### URL、网页、根目录、域名、服务器名、协议区分

示例：http://mail.163.com/index.html
- http://                         协议，也就是 HTTP 超文本传输协议，也就是网页在网上传输的协议。
- mail                            服务器名，代表着是一个邮箱服务器，所以是 mail
- 163.com                         域名，是用来定位网站的独一无二的名字。
- mail.163.com                    网站名，由服务器和域名组成。
- /                               根目录，也就是说：通过网站名找到服务器，然后在服务器找到存放网页的根目录。
- index.html                      根目录下的默认网页。
- http://mail.163.com/index.html  URL，统一资源定位符，全球性地址，用于定位网上的资源。

### 网段

网段（network segment）指一个计算机网络中使用同一物理层设备（传输介质，中继器，集线器等）能够直接通讯的那一部分。例如，从192.168.0.1 到 192.168.255.255 这之间就是一个网段。

### 子网掩码

子网掩码将某个 IP 地址划分成网络地址和主机地址两部分，最直接的作用是判断 IP 地址与另一个 IP 地址是否在同一个网段内，这时只有在同一子网的计算机才能"直接"互通。

### 盗链

盗链是指服务提供商自己不提供服务的内容，通过技术手段绕过其它有利益的最终用户界面（如广告），直接在自己的网站上向最终用户提供其它服务提供商的服务内容，骗取最终用户的浏览和点击率。受益者不提供资源或提供很少的资源，而真正的服务提供商却得不到任何的收益。



## 2. HTTP 请求

### HTTP 请求头

1. Accept: application/json, text/plain, */*
2. Accept-Encoding: gzip, deflate, br  #浏览器支持的压缩编码是 gzip 和 deflate。
3. Accept-Language: zh-CN,zh;q=0.9 #浏览器支持的语言分别是中文和简体中文，优先支持简体中文。(zh-cn 表示简体中文;zh 表示中文)。q 是权重系数，范围 0 =< q <= 1，q 值越大，请求越倾向于获得其“;”之前的类型表示的内容，若没有指定 q 值，则默认为1，若被赋值为0，则用于提醒服务器哪些是浏览器不接受的内容类型。
4. Cache-Control: no-cache
5. Connection: keep-alive #Connection 表示客户端与服务连接类型，keep-alive 表示持久连接。
6. Content-Length: 2
7. Content-Type: application/json;charset=UTF-8
8. Cookie: theme=theme_base; _ga=GA1.2.978307603.1615374702; userName=root; token=123456789; userId=root; userType=SYSADM
9. Host: www.example.com #示请求的服务器网址
10. Origin: https://www.example.com
11. Pragma: no-cache
12. Referer: https://www.example.com/example/
13. Sec-Fetch-Dest: empty
14. Sec-Fetch-Mode: cors
15. Sec-Fetch-Site: same-origin
16. User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36 16. #User-Agent（用户代理），简称 UA，它是一个特殊字符串头，使得服务器能够识别客户端使用的操作系统及版本、CPU 类型、浏览器及版本、浏览器渲染引擎、浏览器语言、浏览器插件等。 Mozilla/5.0：Mozilla 是浏览器名，版本是 5.0；compatible（兼容的）表示平台是兼容模式；

### Content-Type 内容类型

Content-Type（内容类型）字段用于服务器回应时，告诉客户端，本次数据是什么格式。

Content-Type 中常见的媒体格式类型:
1. 以 text 开头的媒体格式类型：
- text/html：HTML 格式。
- text/plain：纯文本格式。
- text/xml：XML 格式。

2. 以 image 开头的媒体格式类型：
- image/gif：gif 图片格式。
- image/jpeg：jpg 图片格式。
- image/png：png 图片格式。

3. 以 application 开头的媒体格式类型：
- application/xhtml+xml：XHTML 格式。
- application/xml：XML 数据格式。
- application/atom+xml：Atom XML 聚合格式 。
- application/json：JSON 数据格式。
- application/pdf：pdf 格式 。
- application/msword： Word 文档格式。
- application/octet-stream： 二进制流数据（如常见的文件下载）。
- application/x-www-form-urlencoded： form 表单数据被编码为 key/value 格式发送到服务器（表单默认的提交数据的格式）。

4. 上传文件的媒体格式类型：
- multipart/form-data ： 需要在表单中进行文件上传时，就需要使用该格式。

### 状态码

2XX 成功
- 200 OK，表示从客户端发来的请求在服务器端被正确处理
- 204 No content，表示请求成功，但响应报文不含实体的主体部分
- 205 Reset Content，表示请求成功，但响应报文不含实体的主体部分，但是与 204 响应不同在于要求请求方重置内容
- 206 Partial Content，进行范围请求

3XX 重定向
- 301 moved permanently，永久性重定向，表示资源已被分配了新的 URL
- 302 found，临时性重定向，表示资源临时被分配了新的 URL
- 303 see other，表示资源存在着另一个 URL，应使用 GET 方法获取资源
- 304 not modified，表示服务器允许访问资源，但因发生请求未满足条件的情况
- 307 temporary redirect，临时重定向，和302含义类似，但是期望客户端保持请求方法不变向新的地址发出请求

4XX 客户端错误
- 400 bad request，请求报文存在语法错误
- 401 unauthorized，表示发送的请求需要有通过 HTTP 认证的认证信息
- 403 forbidden，表示对请求资源的访问被服务器拒绝
- 404 not found，表示在服务器上没有找到请求的资源

5XX 服务器错误
- 500 internal sever error，表示服务器端在执行请求时发生了错误
- 501 Not Implemented，表示服务器不支持当前请求所需要的某个功能
- 503 service unavailable，表明服务器暂时处于超负载或正在停机维护，无法处理请求
- 504 网关超时

### 网页加载慢的可能原因

1. 带宽不足
2. CPU 或者内存占满
3. DNS 解析慢
4. 加载资源慢, 因为资源在第三方站点, 资源太大等
5. 数据库发生死锁, sql 查询慢



## 3. 网络安全

### 对称加密和非对称加密

- 对称加密：加密和解密的密钥一样，比如用123加密就是用123解密，但是实际中密码都是普通数据在互联网传输的，这样一点密码被中间人截取并破解，加密直接被攻破。
- 非对称加密：把密钥分为公钥和私钥，公钥是公开的所有人都可以认领，私钥是保密的只有一个人知道。假设 A要发送一封 Email 给B，他不想让任何其他人在传输中看到 Email 的内容，做法就是使用 B的公钥对 Email 加密，只有 B的私钥能够解密（B 的私钥唯一性保证信件不会泄露）。

- 公钥的作用：对内容本身加密，保证不被其他人看到。
- 私钥的作用：证明内容的来源。
- 公钥和私钥是配对关系，公钥加密就用私钥解密，反之亦然，用错的密钥来尝试解密会报错。

### 哈希

#### 哈希

Hash（哈希），又称“散列”，散列（hash）英文原意是“混杂”、“拼凑”、“重新表述”的意思。  
在某种程度上，散列是与排序相反的一种操作，排序是将集合中的元素按照某种方式比如字典顺序排列在一起，而散列通过计算哈希值，打破元素之间原有的关系，使集合中的元素按照散列函数的分类进行排列。  
在介绍一些集合时，我们总强调需要重写某个类的 equlas() 方法和 hashCode() 方法，确保唯一性。这里的 hashCode() 表示的是对当前对象的唯一标示。计算 hashCode 的过程就称作 哈希。

#### 哈希函数

哈希函数（Hash Function），也称为散列函数，给定一个输入 x，它会算出相应的输出 H(x)。哈希函数的主要特征是：
- 输入 x 可以是任意长度的字符串
- 输出结果即 H(x) 的长度是固定的
- 计算 H(x) 的过程是高效的（对于长度为 n 的字符串 x ，计算出 H(x) 的时间复杂度应为 O(n) ）
- 单向不可逆
  密码哈希函数不变的情况下，A 任何轻微的变化都会导致根据哈希函数计算出来的α完全不一样。这个效应我们称之为雪崩效应（avalanche effect）。

### 跨域

#### 1. 什么是跨域

跨域：由于浏览器同源策略，凡是发送请求 url 的协议、域名、端口三者之间任意一个与当前页面地址不同即为跨域。存在跨域的情况：
- 网络协议不同，如 http 协议访问 https 协议
- 端口不同，如 80 端口访问 8080 端口
- 域名不同，如 aaa.com 访问 bbb.com
- 域名不同，如 abc.example.com 访问 def.example.com
- 域名和域名对应 ip，如 www.example.com 访问 127.0.0.1

#### 2. 同源

1995年，同源政策由 Netscape 公司引入浏览器。目前，所有浏览器都实行这个政策。最初，它的含义是指，A 网页设置的 Cookie，B 网页不能打开，除非这两个网页"同源"。所谓"同源"指的是"三个相同"。
- 协议相同
- 域名相同
- 端口相同

#### 3.举例

举例来说，http://www.example.com/dir/page.html 这个网址，协议是 http://，域名是 http://www.example.com，端口是80（默认端口可以省略）。它的同源情况如下。
- http://www.example.com/dir2/other.html：同源
- http://example.com/dir/other.html：不同源（域名不同）
- http://v2.www.example.com/dir/other.html：不同源（域名不同）
- http://www.example.com:81/dir/other.html：不同源（端口不同）

#### 4. 同源政策的目的

同源策略的主要作用是保护用户信息免受不同源的网页访问。 它确保了敏感数据（如用户登录状态、个人信息等）的安全，防止了恶意脚本对数据的非法访问和操作。

#### 5. 持跨域

在发起请求时添加 Origin 的头，用来标记请求的来源，服务端会接受 Origin 字段的内容，并判断是否在 CORS 允许的来源白名单中，如果在，则会返回允许跨域请求的 header（Access-Control-Allow-Origin）

允许跨域的方法：access-control-allow-methods: GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS

同时存在 CORS 和非 CORS 请求：Vary: Origin

### 测试上行和下行带宽 

测试上行和下行带宽可以更准确地了解网络性能。 上行带宽是指数据从用户设备传输到互联网的速度，而下行带宽是指数据从互联网接收到用户设备的速度。



## 4. 知识碎片

### ICMP

ping 某个域名 timeout，但是实际上域名可正常访问，是因为没有开头 ICMP 没开？

ping命令对一个域名进行测试时出现超时，但实际上可以通过其他方式正常访问该域名（例如，使用浏览器），那么可能是因为ICMP（Internet Control Message Protocol）被阻止了。

ICMP流量被阻止或限制的原因有很多。一些网络管理员或互联网服务提供商（ISP）可能出于安全考虑或为了优化网络资源而选择阻止ICMP的回显请求。此外，一些防火墙或安全设备可能设置了ICMP过滤规则。

Linux 服务器如何查看带宽被打满

iftop 是一个实时流量监控工具，可以显示网络接口的使用情况。
apt install iftop 
iftop -i eth0

curl cip.cc
curl ip.gs
