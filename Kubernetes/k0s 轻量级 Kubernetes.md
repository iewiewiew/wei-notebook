[TOC]

<h1 align="center">k0s 轻量级 Kubernetes</h1>

> By：weimenghua  
> Date：2022.10.01   
> Description：k0s

**参考资料**  
[k0sproject](https://k0sproject.io/)  
[docs.k0sproject](https://docs.k0sproject.io/v1.27.1+k0s.0/)



### k0s 搭建
```
curl -sSLf https://get.k0s.sh | sudo sh

sudo k0s install controller --single

sudo k0s start

sudo k0s status
```