[TOC]

---

<h1 align="center">Helm 包管理器</h1>

> By：weimenghua  
> Date：2022.10.01  
> Description：Helm

**参考资料**  
[Helm 官方文档](https://helm.sh/zh/docs/)  
[Helm 仓库](https://artifacthub.io/)  
[bitnami charts](https://charts.bitnami.com/)  
[微软 azure 源](http://mirror.azure.cn/kubernetes/charts/)  
[Helm 安装软件](./Helm 安装软件.md)



## 一、Helm 简介

Chart 代表着 Helm 包。它包含在 Kubernetes 集群内部运行应用程序，工具或服务所需的所有资源定义。你可以把它看作是 Homebrew formula，Apt dpkg，或 Yum RPM 在 Kubernetes 中的等价物。  
Repository（仓库） 是用来存放和共享 charts 的地方。它就像 Perl 的 CPAN 档案库网络 或是 Fedora 的 软件包仓库，只不过它是供 Kubernetes 包所使用的。  
Release 是运行在 Kubernetes 集群中的 chart 的实例。一个 chart 通常可以在同一个集群中安装多次。每一次安装都会创建一个新的 release。以 MySQL chart 为例，如果你想在你的集群中运行两个数据库，你可以安装该 chart 两次。每一个数据库都会拥有它自己的 release 和 release name。  
在了解了上述这些概念以后，我们就可以这样来解释 Helm：  
Helm 安装 charts 到 Kubernetes 集群中，每次安装都会创建一个新的 release。你可以在 Helm 的 chart repositories 中寻找新的 chart。



## 二、Helm 安装

```
1、Linux 安装 Helm
方式一
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get |bash

方式二
wget -c https://get.helm.sh/helm-v3.10.1-linux-amd64.tar.gz
tar -zxvf helm-v3.10.1-linux-amd64.tar.gz

方式三
wget https://mirrors.huaweicloud.com/helm/v3.7.2/helm-v3.7.2-linux-amd64.tar.gz
tar -zxvf helm-v3.7.2-linux-amd64.tar.gz

chmod 755 linux-amd64/helm
cp linux-amd64/helm /usr/local/bin/
ls /usr/local/bin/

cat >> /etc/profile << EOF
source <(helm completion bash)
EOF
source /etc/profile
cat /etc/profile

2、Mac 安装 Helm
brew install helm

3、验证
helm version
```



## 三、Helm 使用

**基本操作**

```
1、helm search 
查找 Charts
Helm 自带一个强大的搜索命令，可以用来从两种来源中进行搜索：
helm search hub 从 Artifact Hub 中查找并列出 helm charts。 Artifact Hub 中存放了大量不同的仓库。
helm search repo 从你添加（使用 helm repo add）到本地 helm 客户端中的仓库中进行查找。该命令基于本地数据进行搜索，无需连接互联网。

展示所有可用的 charts
helm search hub

2、heml list
查看应用（helm list --all 会展示 Helm 保留的所有 release 记录，包括失败或删除的条目（指定了 --keep-history））
```

**仓库管理**

```
1、添加 chart 仓库
命令：helm repo add <仓库名称> <仓库 URL>
举例：helm repo add bitnami https://charts.bitnami.com/bitnami
举例：helm repo add azure http://mirror.azure.cn/kubernetes/charts
举例：helm repo add stable https://charts.helm.sh/stable
举例：helm repo add aliyun https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts

2、查看配置的仓库
helm repo list

3、移除仓库
命令：helm repo remove <仓库名称>
举例：helm repo remove bitnami

4、更新 chart 列表
helm repo update

5、查看应用列表
helm list
```

**chart 管理**

```
1、查看 chart 列表
命令：helm search repo <chart 名称>
举例：helm search repo mysql

2、更新 chart 列表
helm repo update

3、查看 chart 信息
命令：helm show chart <仓库名称>/<chart 名称>
举例：helm show chart bitnami/mysql

4、拉取 chart 包
命令：helm pull <仓库名称>/<chart 名称> --version=<chart 版本>
举例：helm pull bitnami/mysql --version=9.4.1

5、安装 Chart
命令：helm install <release 名称> <仓库名称>/<chart 名称> --version=<chart 版本>
举例：helm install my-release bitnami/mysql --version=9.4.1
命令：helm install <仓库名称>/<chart 名称> --generate-name //生成随机<release 名称>
举例：helm install bitnami/mysql --generate-name

5、查看发布信息
命令：helm status <release 名称>
举例：helm status my-release

6、查看发布历史
命令：helm history <release 名称>
举例：helm history my-release

7、回滚版本（每当发生了一次安装、升级或回滚操作，revision 的值就会加1。第一次 revision 的值永远是1。我们可以使用 helm history [RELEASE] 命令来查看一个特定 release 的修订版本号。）
命令：helm rollback <release 名称> 1
举例：helm rollback my-release 1

8、卸载 chart（该命令会从 Kubernetes 卸载 my-release， 它将删除和该版本相关的所有相关资源（service、deployment、 pod 等等）甚至版本历史。）
命令：helm uninstall <release 名称>
举例：helm uninstall my-release

9、删除 chart（heml list 查看发布的 chart）
命令：helm delete --purge <release 名称>
举例：helm delete --purge my-release

10、创建 chart 包
命令：helm create <chart 名称>
举例：helm create mychart

11、其它
安装 MySQL 客户端（未成功）
yum install mariadb -y
```

**template**

```
拉取 chart 包
命令：helm pull <仓库名称>/<chart 名称> --version=<chart 版本>
举例：helm pull bitnami/mysql --version=9.4.1

下载 mysql-9.4.1.tgz 到本地，执行：tar -zxvf mysql-9.4.1.tgz 解压 mysql-9.4.1.tgz 到mysql

修改文件后执行：helm package mysql/ 重新打包
```

**Helm 安装资源顺序**

```
ns
NetworkPolicy
ResourceQuota
LimitRange
PodSecurityPolicy
PodDisruptionBudget
ServiceAccount
Secret
SecretList
ConfigMap
StorageClass
PersistentVolume
PersistentVolumeClaim
CustomResourceDefinition
ClusterRole
ClusterRoleList
ClusterRoleBinding
ClusterRoleBindingList
Role
RoleList
RoleBinding
RoleBindingList
Service
DaemonSet
Pod
ReplicationController
ReplicaSet
Deployment
HorizontalPodAutoscaler
StatefulSet
Job
CronJob
Ingress
APIService
```



## 四、Chart 解释
**制作 Helm Chart**

1. 创建一个名为 mychart 的新 Chart `helm create mychart`
2. Chart.yaml 文件是描述 Chart 元数据的文件，包括 Chart 名称、版本、描述等。您可以打开 Chart.yaml 文件并根据需要对其进行编辑。
3. values.yaml 文件包含 Chart 的默认值，您可以在其中定义应用程序的配置选项。您可以根据需要修改或添加键值对。
4. templates 目录包含了用于生成 Kubernetes 清单文件的模板文件。您可以编辑这些文件来定义应用程序的 Kubernetes 对象，如 Deployment、Service 和ConfigMap 等。
5. 打包 Chart `helm package mychart/`，这将在当前目录下创建一个名为 mychart-version.tgz 的文件，其中 version 是Chart 的版本号
6. 发布 Chart `helm push mychart-version.tgz myrepo`
7. 安装 Chart `helm install mychart myrelease`

**推送 Helm Chart 到 Harbor** 注：未实践

```
安装 Helm Push 插件
helm plugin install https://github.com/chartmuseum/helm-push

将 Harbor 添加为 Helm chart 存储库
helm repo add my-repo https://example.com/harbor

推送 Helm chart 到 Harbor
helm push my-chart-0.1.0.tgz my-repo
```