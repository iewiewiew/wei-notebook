[TOC]

<h1 align = "center">Helm_Install</h1>

> By：weimenghua  
> Date：2023.05.20  
> Description：Helm 安装软件

**参考资料**  
[Helm 官方文档](https://helm.sh/zh/docs/)  
[Helm 仓库](https://artifacthub.io/)  
[bitnami charts](https://charts.bitnami.com/)  
[Helm 包管理器](./Helm.md)  



### 示例

```
helm install [RELEASE_NAME] jenkins/jenkins [flags]
helm uninstall [RELEASE_NAME]

1、添加 chart 仓库
命令：helm repo add <仓库名称> <仓库 URL>
举例：helm repo add bitnami https://charts.bitnami.com/bitnami
举例：helm repo add azure http://mirror.azure.cn/kubernetes/charts/
举例：helm repo add stable https://charts.helm.sh/stable
举例：helm repo add stable https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts

2、查看配置的仓库
helm repo list

3、移除仓库
命令：helm repo remove <仓库名称>
举例：helm repo remove bitnami
举例：helm repo remove azure

4、更新 chart 列表
helm repo update

5、查看应用？
helm list
helm -n <namespace> ls
helm -n <namespace> ls -a
helm -n <namespace> delete <packagename>
举例
helm -n my-space ls
helm -n my-space delete minio

6、查看 ns 下所有资源
kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found -n my-space

7、删除 ns 下某个服务的所有 pod
kubectl get pod -n my-space |grep sentry |awk '{print $1}'|xargs kubectl delete pod -n my-space

8、查看状态
helm status <release_name> -n <namespace>
其中，`<release_name>` 是要查看状态的 Helm 发布的名称，`<namespace>` 是 Helm 发布所在的 Kubernetes 名称空间。如果未指定名称空间，则默认使用 `default` 名称空间。


helm show values jenkins/jenkins
```



### Jenkins （未安装成功）

```
1、添加 Jenkins Helm 仓库
helm repo add jenkins https://charts.jenkins.io
helm repo update

2、安装 Jenkins
helm install jenkins jenkins/jenkins

安装 Jenkins 并设置参数
helm install jenkins jenkins/jenkins
helm install jenkins jenkins/jenkins --set adminPassword=admin --set service.type=NodePort --set service.port=30001

3、查看 Jenkins 端口号
kubectl get svc jenkins

4、访问 Jenkins
http://<Node_IP>:<Node_Port>/

5、踩坑：Jenkins 没有暴露端口号
查看当前 Helm Chart 的配置
helm get values jenkins
helm show values jenkins

升级 Jenkins Chart 的配置
helm upgrade jenkins jenkins/jenkins --set service.type=NodePort --set service.port=<port_number>
helm upgrade jenkins jenkins/jenkins --set service.type=NodePort --set service.port=30001

6、拉取 Jenkins 到本地再安装
helm fetch jenkins/jenkins --untar
helm install jenkins ./jenkins

在 values.yaml 添加以下内容：
Service:
  Type: NodePort
  Port: 8080
  TargetPort: 8080
  NodePort: 30001
  
helm upgrade --install jenkins jenkins/jenkins -f values.yaml -n my-space
```



### Mongodb

```
helm repo add bitnami https://charts.bitnami.com/bitnami

helm install mongodb bitnami/mongodb -n my-space

kubectl get svc mongodb -n my-space
kubectl get pod -n my-space |grep mongodb

-- mongodb-7b977c49bd-tvb4g mongodb-client
kubectl exec -it mongodb-client -n my-space -- /bin/bash
kubectl exec -it mongodb-7b977c49bd-tvb4g -n my-space -- mongo
```



### Nginx

```
1、搜索
helm search repo nginx

2、安装
helm install my-release bitnami/nginx

3、查看资源（查看端口）
kubectl get svc --namespace default -w my-release-nginx

4、获取 ip 及端口（未实践成功）
export SERVICE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].port}" services my-release-nginx)
export SERVICE_IP=$(kubectl get svc --namespace default my-release-nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo "http://${SERVICE_IP}:${SERVICE_PORT}"
    
5、验证
http://127.0.0.1:32433/
```



### PostgrepSQL

```
cat >> values-pord.yaml<<'EOF'
global:
  storageClass: "my-nfs"
  postgresql:
    auth:
      postgresPassword: "root"
      username: "root"
      password: "root"
      database: "demo"

  service:
    type: NodePort
    nodePorts:
      postgresql: 30032

primary:
  service:
    type: NodePort
    nodePorts:
      postgresql: 30032
EOF

helm upgrade --install postgresql postgresql -f values-pord.yaml
```

Chart 仓库地址：https://artifacthub.io/packages/helm/bitnami/postgresql
```
helm repo add bitnami https://charts.bitnami.com/bitnami

helm repo update

拉取压缩包
helm pull bitnami/postgresql

拉取安装包
helm pull bitnami/postgresql --untar

helm upgrade --install postgresql bitnami/postgresql --namespace myspace --create-namespace
helm upgrade --install postgresql bitnami/postgresql -f your-values.yaml --namespace myspace --create-namespace

kubectl get secret --namespace myspace postgresql -o jsonpath="{.data.postgres-password}" | base64 -d
密码：n13x9Eafwl
kubectl exec -it pod/postgresql-0 -n myspace -- bash
psql --host 127.0.0.1 -U postgres -d postgres -p 5432
```



### Zookeeper

```
1、搜索
helm search repo zookeeper

2、安装
方式一（注：时间较长）
helm install my-zookeeper bitnami/zookeeper -n my-space

方式二
helm pull bitnami/zookeeper --version 10.2.3
tar xf zookeeper-10.2.3.tg
helm install zookeeper zookeeper \
  --namespace my-space --create-namespace \
  --set global.storageClass="nfs-client-demo" \
  --set replicaCount=3 \
  --set auth.enabled=false \
  --set persistence.enabled=true \
  --set persistence.storageClass="nfs-client-demo"

3、查看状态
helm status my-zookeeper -n my-space

4、进入 pod 执行命令
export POD_NAME=$(kubectl get pods --namespace my-space -l "app.kubernetes.io/name=zookeeper,app.kubernetes.io/instance=my-zookeeper,app.kubernetes.io/component=zookeeper" -o jsonpath="{.items[0].metadata.name}")

kubectl exec -it my-zookeeper-0 -n my-space -- zkCli.sh

kubectl exec -it my-zookeeper-0 -n my-space -- /opt/bitnami/zookeeper/bin/zkServer.sh status

5、删除
helm delete my-zookeeper -n my-space
```



### Grafana

```
kubectl create ns monitoring

```



### NFS+StorageClass

```
添加仓库
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner
helm repo update

默认镜像下载网络受限，使用中国内部镜像
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
--set image.repository=easzlab/nfs-subdir-external-provisioner \
--set image.tag=v4.0.2 \
--set nfs.server=127.0.0.1 \
--set nfs.path=/root/nfs/tmp \
--set storageClass.name=nfs-client-demo \
--set storageClass.reclaimPolicy="Retain" \
--namespace my-space --create-namespace

检查 StorageClass 部署状态
kubectl get pod -n my-space
kubectl get sc -n my-space
helm list -n my-space

删除 StorageClass
helm delete nfs-subdir-external-provisioner -n my-space
```



### MySQL

```
拉取镜像
mkdir mysql-mater-slave/5.7 -p ; cd mysql-mater-slave/5.7
helm repo add kubegemsapp https://charts.kubegems.io/kubegemsapp
helm repo update
helm pull kubegemsapp/mysql --version 4.5.2 --untar

运行服务
helm install mysql-1m2s-57 mysql \
--set service.type=NodePort \
--set service.mnodePort=30006 \
--set service.snodePort=30036 \
--set root.password=root \
--set replication.enabled=true \
--set replication.password="root" \
--set master.persistence.storageClass="nfs-client-demo" \
--set master.persistence.size="50G" \
--set slave.replicas=2 \
--set slave.persistence.storageClass="nfs-client-demo" \
--set slave.persistence.size="50G" \
--namespace my-space --create-namespace

查看所有
kubectl get all -n my-space

进入 pod
kubectl exec -it pod/mysql-mysql-master-0 -n my-space -- bash

访问主库
mysql -uroot -proot -h mysql.my-space.svc.cluster.local -P 3306

访问从库
mysql -uroot -proot -h mysql-mysql-slave.my-space.svc.cluster.local -P 3306
show slave status\G;
```



### Redis

```
拉取 chart
helm pull bitnami/redis

拉取 chart 并解压
helm pull bitnami/redis --untar

安装一（注：时间较长）
helm install my-redis bitnami/redis -n my-space

安装二
helm install redis redis \
--set global.storageClass="nfs-client-demo" \
--set cluster.enabled=false \
--set usePassword=false \
--set global.service.type=NodePort \
--set global.service.nodePort=30079 \
--set master.service.type=NodePort \
--set master.service.nodePort=30079 \
--namespace my-space --create-namespace

查看状态
helm status my-redis -n my-space

查看 redis 密码
kubectl get secret --namespace my-space my-redis -o jsonpath="{.data.redis-password}" | base64 -d

进入 pod
kubectl exec -it pod/my-redis-master-0 -n my-space -- bash

进入 redis 客户端
redis-cli -h 127.0.0.1 -p 6379 -a nHlgvmmqg3

输入命令
keys *
```

### Redis 集群-3主3从

```
踩坑：找不到7.5.0版本，去掉版本后安装最新的
helm pull bitnami/redis-cluster --version 7.5.0
tar -xvf redis-cluster-7.5.0.tgz

cat > values-pro.yaml<<'EOF'
global:
  storageClass: "nfs-client-demo"
usePassword: false

service:
  ports:
    redis: 6379


redis:
  livenessProbe:
    enabled: true
    initialDelaySeconds: 60
    periodSeconds: 30
    timeoutSeconds: 10
    successThreshold: 1
    failureThreshold: 5

  readinessProbe:
    enabled: true
    initialDelaySeconds: 60
    periodSeconds: 30
    timeoutSeconds: 10
    successThreshold: 1
    failureThreshold: 5

  startupProbe:
    enabled: false
    path: /
    initialDelaySeconds: 300
    periodSeconds: 30
    timeoutSeconds: 10
    failureThreshold: 6
    successThreshold: 1
EOF

helm install redis-cluster redis-cluster -f values-pro.yaml --namespace my-space --create-namespace

You have deployed a Redis&reg; Cluster accessible only from within you Kubernetes Cluster.INFO: The Job to create the cluster will be created.To connect to your Redis&reg; cluster:

1. Run a Redis&reg; pod that you can use as a client:
kubectl run --namespace my-space redis-cluster-client --rm --tty -i --restart='Never' \
--image docker.io/bitnami/redis-cluster:7.0.8-debian-11-r0 -- bash

2. Connect using the Redis&reg; CLI:
redis-cli -c -h redis-cluster

kubectl -n my-space get pods -l helm.sh/chart=redis-cluster-8.3.5

helm -n my-space ls
helm -n my-space delete redis-cluster

(如何使用？)
集群内部访问，通过 svc 自动负载均衡：
redis-cluster.my-space.svc.cluster.local:6379

集群内访问单个 redis 地址
redis-cluster-0.redis-cluster-headless.my-space
redis-cluster-1.redis-cluster-headless.my-space
redis-cluster-2.redis-cluster-headless.my-space
redis-cluster-3.redis-cluster-headless.my-space
redis-cluster-4.redis-cluster-headless.my-space
redis-cluster-5.redis-cluster-headless.my-space

默认 redis-cluster-0 和 redis-cluster-1 为主从，0主1从
默认 redis-cluster-2 和 redis-cluster-3 为主从，0主1从
默认 redis-cluster-4 和 redis-cluster-5 为主从，0主1从
集群主节点为：redis-cluster-0 redis-cluster-2 redis-cluster-4
集群从节点为：redis-cluster-1 redis-cluster-3 redis-cluster-5
```



### Minio

```
添加 minio 的仓库
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm pull bitnami/minio --version 11.6.5
tar -zxvf minio-11.6.5.tgz

踩坑：密码长度有限制
helm install minio minio \
--namespace my-space --create-namespace \
--set global.storageClass="nfs-client-demo" \
--set fullnameOverride="minio" \
--set mode=distributed \
--set auth.rootUser="minioadmin" \
--set auth.rootPassword="minioadmin" \
--set statefulset.replicas=2 \
--set service.type=NodePort \
--set service.nodePorts.api=30001 \
--set service.nodePorts.console=30002 \
--set persistence.size=200Gi

helm -n my-space ls
helm -n my-space delete minio

kubectl get pods -n my-space|grep minio
kubectl get pvc -n my-space|grep minio
kubectl get svc -n my-space|grep minio

http://127.0.0.1:30002
```



### sentry（未安装成功）

```
1、安装
方式一
git clone https://github.com/mapyJJJ/helm-sentry.git

sed -i 's/nfsclass/nfs-client-demo/' helm-sentry/sentry/charts/redis/values.yaml
sed -i 's/nfsclass/nfs-client-demo/' helm-sentry/sentry/charts/postgresql/values.yaml
sed -i 's/nfsclass/nfs-client-demo/' helm-sentry/sentry/values.yaml

helm install sentry -f sentry/values.yaml --namespace my-space sentry/ \
--set filestore.filesystem.persistence.storageClass=nfs-client-demo \
--set user.email=admin@sentry.local \
--set user.password=root

方式二
helm install sentry stable/sentry -n my-space

查看 nodeport，直接访问该地址
kubectl get service sentry -n my-space 

kubectl get secret sentry -n my-space  -o jsonpath='{.data}' 

helm -n my-space ls
helm -n my-space delete sentry
```



### Harbor

```
添加 Chart 仓库
helm repo add harbor https://helm.goharbor.io

更新
helm repo update
```



### Kafka（未安装成功）

```
Chart 仓库地址：https://artifacthub.io/packages/helm/bitnami/kafka
镜像 github 地址：https://github.com/bitnami/bitnami-docker-kafka

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm pull bitnami/kafka --untar --version 19.0.0
cd kafka

# values-prod.yaml
## Persistence parameters
##
cat > values-pro.yaml<<'EOF'
persistence:
  enabled: true
  storageClass: "nfs-client-demo"
  accessModes:
    - ReadWriteOnce
  size: 5Gi
  ## Mount point for persistence
  mountPath: /bitnami/kafka

# 配置 zk volumes
zookeeper:
  enabled: true
  persistence:
    enabled: true
    storageClass: "nfs-client-demo"
    accessModes:
      - ReadWriteOnce
    size: 8Gi
EOF

helm install kafka kafka -f values-prod.yaml -n my-space --create-namespace
```



### Memcached

```
Chart 仓库地址：https://artifacthub.io/packages/helm/bitnami/memcached

helm repo add bitnami https://charts.bitnami.com/bitnami
helm pull bitnami/memcached --version 6.3.0
tar zxf memcached-6.3.0.tgz

helm install memcached memcached -n my-space

kubectl get pod -n my-space

kubectl get svc -n my-space

helm -n my-space ls
helm -n my-space delete memcached
```



### kubernetes-dashboard

```
添加仓库
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm repo update

下载到本地安装
helm search repo kubernetes-dashboard/kubernetes-dashboard
helm pull  kubernetes-dashboard/kubernetes-dashboard --version 6.0.0 --untar

helm install kubernetes-dashboard kubernetes-dashboard \
--set service.type=NodePort \
--set service.nodePort=30081 \
--set rbac.clusterReadOnlyRole=true \
--namespace kubernetes-dashboard --create-namespace

检查 kubernetes-dashboard 部署状态
kubectl get pods,svc -n kubernetes-dashboard | grep kubernetes-dashboard
kubectl get all -n kubernetes-dashboard

查看访问地址 注：https
export NODE_PORT=$(kubectl get -n kubernetes-dashboard -o jsonpath="{.spec.ports[0].nodePort}" services kubernetes-dashboard)
export NODE_IP=$(kubectl get nodes -o jsonpath="{.items[0].status.addresses[0].address}")
echo https://$NODE_IP:$NODE_PORT/
https://127.0.0.1:30081/#/login

卸载应用
helm delete kubernetes-dashboard -n my-space

cat >dashboard-admin.yaml<<'EOF'
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    k8s-app: kubernetes-dashboard
  name: dashboard-admin
  namespace: kubernetes-dashboard
EOF


cat > dashboard-admin-bind-cluster-role.yaml<<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: dashboard-admin-bind-cluster-role
  labels:
    k8s-app: kubernetes-dashboard
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: dashboard-admin
  namespace: kubernetes-dashboard
EOF

kubectl apply -f dashboard-admin.yaml
kubectl apply -f dashboard-admin-bind-cluster-role.yaml

cat >dashboard-token.sh<<'EOF'
#!/bin/sh
kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep dashboard-admin | awk '{print $1}')|grep "token:" | awk '{ print $2}'
EOF

bash dashboard-token.sh
```
