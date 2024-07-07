[TOC]

<h1 align="center">Nginx</h1>

> By：weimenghua  
> Date：2022.11.20  
> Description：Nginx 代理



## 1. 环境搭建

```
1、前提
安装依赖包
yum -y install gcc zlib zlib-devel pcre-devel openssl openssl-devel

2、下载并解压 nginx 到/usr/local/ngnix/
2.1、下载 nginx
方式一：官网下载：http://nginx.org/en/download.html  
方式二：wget http://nginx.org/download/nginx-1.13.7.tar.gz

2.1、解压 tar 包到/usr/local/nginx/目录下
tar -zxvf nginx-1.13.7.tar.gz -C /usr/local/ngnix/

3、安装 nginx
cd /usr/local/nginx/nginx-1.13.7
执行配置
./configure
编译安装
make && make install

4、配置 nginx.conf
将端口号改成8089，因为可能 apeache 占用80端口，apeache 端口尽量不要修改，选择修改 nginx 端口
vim /usr/local/nginx/nginx-1.13.7/conf/nginx.conf

5、启动 nginx
cd /usr/local/nginx/sbin/nginx/nginx-1.13.7
./nginx           //启动
./nginx -s stop   //关闭
./nginx -s reload //重启

6、查看 nginx 进程是否启动
ps -ef | grep nginx

7、验证 nginx 是否配置成功
nginx -t

8、查询 nginx 的安装路径
whereis nginx
```



## 2. 常用命令

```
nginx 安装目录地址 -c nginx 配置文件地址（-c 参数指定了要加载的 nginx 配置文件路径）  
/app/ngnix/sbin/nginx  -c  /app/nginx/conf/nginx.conf

nginx  -s  start      #  启动 nginx  
nginx  -s  stop       #  停止 nginx  
nginx  -s  quit       #  等待工作进程处理完成后关闭  
nginx  -s  reload     #  重新加载配置文件，热重启  
nginx  -s  reopen     #  重启 Nginx  
nginx  -T             #  查看当前 Nginx 最终的配置  
nginx  -t             #  检查配置是否有问题  
```



## 3. Nginx 限流

参考资料  
[怎么样通过 Nginx 实现限流？](https://zhuanlan.zhihu.com/p/463946760)  
[Nginx 配置限流，技能拉满！](https://mp.weixin.qq.com/s/-FybaaL5kwzZPrwaO_Xt5w)

Nginx 的”流量限制”使用漏桶算法(leaky bucket algorithm)，该算法在通讯和分组交换计算机网络中广泛使用，用以处理带宽有限时的突发情况。就好比，一个桶口在倒水，桶底在漏水的水桶。如果桶口倒水的速率大于桶底的漏水速率，桶里面的水将会溢出；同样，在请求处理方面，水代表来自客户端的请求，水桶代表根据”先进先出调度算法”(FIFO)等待被处理的请求队列，桶底漏出的水代表离开缓冲区被服务器处理的请求，桶口溢出的水代表被丢弃和不被处理的请求。

测试 Nginx 限流的 pod
```
docker rm -f my-vue
docker rmi vue-view-demo
docker build -t vue-view-demo:v1.0.0 .
docker run --name my-vue -d -p 8888:80 vue-view-demo:v1.0.0
```

限流配置
```
limit_req_zone $binary_remote_addr zone=one:10m rate=10r/s;
第一个参数：$binary_remote_addr 表示通过 remote_addr 这个标识来做限制，“binary_”的目的是缩写内存占用量，是限制同一客户端 ip 地址。
第二个参数：zone=one:10m 表示生成一个大小为10M，名字为 one 的内存区域，用来存储访问的频次信息。
第三个参数：rate=10r/s 表示允许同一个客户端的访问频次是每秒10次，还可以有比如30r/m 的。

配置案例：

limit_req_zone $binary_remote_addr zone=one:20m rate=200r/s;
limit_req_zone $binary_remote_addr zone=req_sdk_api:20m rate=200r/s;
limit_req_zone $binary_remote_addr zone=req_host_base_info:20m rate=300r/s;
limit_req_zone $binary_remote_addr zone=req_open_api:40m rate=200r/s;

发送到客户端的错误代码
一般情况下，客户端超过配置的流量限制时，Nginx 响应状态码为503(Service Temporarily Unavailable)。可以使用 limit_req_status 指令来设置为其它状态码(例如下面的444状态码):
location /login/ {
    limit_req zone=mylimit burst=20 nodelay;
    limit_req_status 444;
}

指定 location 拒绝所有请求
location /login/ {
	deny all;
}
```

```
在 ngnix 的 conf 目录下创建一个 blockip.conf 文件
里面放需要封禁的 IP，格式如下
deny 1.2.3.4;
在 ngnix 的 HTTP 的配置中添加如下内容
include blockips.conf;
重启 ngnix
/usr/local/nginx/sbin/nginx -s reload
```



## 4. 正向代理和反向代理

### 4.1 正向代理

正向代理：你可以这样理解，就是把局域网以外的 Internet 想象成一个外网世界，那么当我们局域网中的客户端设备要访问局域网以外的 Internet 时，需在客户端浏览器中配置代理服务器，然后通过代理服务器来进行访问，将访问到的局域网以外的 Internet 网站内容返回给客户端，而不是通过局域网中的客户端设备直接访问到局域网以外的 Internet 网站中，这种代理服务称之为：正向代理。

正向代理的用途：  
访问原来无法访问的资源；
可做缓存，加速访问资源；
对客户端访问授权，上网进行认证；
代理可以记录用户访问记录等，且对外隐藏用户信息；

### 4.2 反向代理

反向代理：无需在客户端进行配置即可访问，我们只需要将请求发送给反向代理服务器，然后由反向代理服务器去选择要访问的目标服务器获取数据后，在返回给客户端。这里你可以这样理解：反向代理服务器和目标服务器对外访问的就是一台服务器，知道的是反向代理服务器地址，其实隐藏了真实服务器的 IP 地址， 这种代理服务称之为：反向代理。

反向代理的用途：  
保证内网安全，通常将反向代理作为公网访问地址，Web 服务器是内网；
负载均衡，通过反向代理服务器来优化网站的负载；



## 5. 知识碎片

### NginxConfig

[NginxConfig 官网](https://www.digitalocean.com/community/tools/nginx?global.app.lang=zhCN)  
[NginxConfig 源码](https://github.com/digitalocean/nginxconfig.io)

### Nginx 是如何支持百万并发

[只知道 Nginx 牛逼！却不知道它怎么支持百万并发？](https://mp.weixin.qq.com/s/6OFA1jhxnjb_M7Z9vzEwPg)  
当 Nginx 启动时，会生成主进程（master）和工作进程（worker）。

