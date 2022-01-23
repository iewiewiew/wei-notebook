[TOC]

<h1 align="center">Zadig 持续集成</h1>

**参考资料**  
[Zadig 官网](https://koderover.com/)    
[Zadig 帮助文档](https://docs.koderover.com/?type=zadig)



### 一、[安装 ZadigX](https://koderover.com/trial)  

安装 ZadigX
```
helm repo add koderover-chart https://koderover.tencentcloudcr.com/chartrepo/chart \
&& helm repo update \
&& helm upgrade --install --create-namespace -n my-space --set global.extensions.extAuth.extauthzServerRef.namespace=my-space --set endpoint.type=IP --set endpoint.IP=127.0.0.1 --set gloo.gatewayProxies.gatewayProxy.service.type=NodePort --set gloo.gatewayProxies.gatewayProxy.service.httpNodePort=30000 --set dex.fullnameOverride=zadig-my-space-dex --set dex.config.issuer=http://zadig-my-space-dex:5556/dex --set "dex.config.staticClients[0].redirectURIs[0]=http://127.0.0.1:30000/api/v1/callback,dex.config.staticClients[0].id=zadig,dex.config.staticClients[0].name=zadig,dex.config.staticClients[0].secret=ZXhhbXBsZS1hcHAtc2VjcmV0"  --set init.adminPassword=Zadig123 --set init.adminEmail=1425615649@qq.com --set mysql.persistence.pv=true --set tags.mysql=true --set mysql.persistence.size=20Gi --set mongodb.persistence.pv=true --set connections.mongodb.db=zadig --set tags.mongodb=true --set mongodb.persistence.size=20Gi --set minio.persistence.pv=true  --set tags.minio=true --set minio.persistence.size=20Gi zadigx-my-space koderover-chart/zadigx
```

查看日志
```
kubectl logs -f aslan-7475f675bf-6vfmr -c aslan -n my-space
```

![](./img/ZadigX%20页面.png)