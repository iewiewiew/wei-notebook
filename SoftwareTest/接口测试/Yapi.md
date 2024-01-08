[TOC]

<h1 align="center">Yapi</h1>

> By：weimenghua  
> Date：2024.01.08  
> Description：  

**参考资料**
[Yapi 官网](http://yapi.mglicai.com/)



```
docker run -d --name mongo-yapi mongo
docker pull registry.cn-hangzhou.aliyuncs.com/anoy/yapi
docker run -it --rm  --link mongo-yapi:mongo --entrypoint npm --workdir /api/vendors registry.cn-hangzhou.aliyuncs.com/anoy/yapi run install-server
docker run -d --name yapi --link mongo-yapi:mongo --workdir /api/vendors -p 7777:3000 registry.cn-hangzhou.aliyuncs.com/anoy/yapi server/app.js

访问http://IP:77777
登录账号：admin@admin.com
密码：ymfe.org
```
