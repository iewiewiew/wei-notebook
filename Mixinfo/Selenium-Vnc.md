[TOC]

<h1 align="center">Selenium-Vnc</h1>

> By：weimenghua   
> Date：2022.12.12  
> Description：Selenium-Vnc 虚拟网络控制台

**参考资料**  
[vnc 客户端下载](https://www.realvnc.com/de/connect/download/viewer/linux/)



```
VNC (Virtual Network Console) 是虚拟网络控制台

启动 vnc
docker run --rm -it -p 4444:4444 -p 7900:7900 --shm-size 2g selenium/standalone-chrome

验证
http://127.0.0.1:7900
密码：secret

参数说明
–shm-size="2g" 使用主机的共享内存，防止容器崩溃，这是避免浏览器在 docker 容器内崩溃的
```
