[TOC]

<h1 align="center">Helm</h1>

> By：weimenghua  
> Date：2022.10.01  
> Description：Helm 包管理器

**参考资料**  
[Helm 官方文档](https://helm.sh/zh/docs/)    
[Helm 仓库1](https://artifacthub.io/)   
[Helm 仓库2](https://hub.grapps.cn/). 
[bitnami 源](https://charts.bitnami.com/)  
[azure 源](http://mirror.azure.cn/kubernetes/charts/)  
[Helm 安装软件](./Helm_Install.md)



## 1. Helm 简介

Helm 的核心组成包括 `Repository`、`Chart`、`Release`。

Repository（仓库）是用来存放和共享 charts 的地方。它就像 Perl 的 CPAN 档案库网络 或是 Fedora 的 软件包仓库，只不过它是供 Kubernetes 包所使用的。

Chart 代表着 Helm 包。它包含在 Kubernetes 集群内部运行应用程序，工具或服务所需的所有资源定义。你可以把它看作是 Homebrew formula，Apt dpkg，或 Yum RPM 在 Kubernetes 中的等价物。  

Release 是运行在 Kubernetes 集群中的 chart 的实例。一个 chart 通常可以在同一个集群中安装多次。每一次安装都会创建一个新的 release。以 MySQL chart 为例，如果你想在你的集群中运行两个数据库，你可以安装该 chart 两次。每一个数据库都会拥有它自己的 release 和 release name。

在了解了上述这些概念以后，我们就可以这样来解释 Helm：Helm 安装 charts 到 Kubernetes 集群中，每次安装都会创建一个新的 release。你可以在 Helm 的 chart repositories 中寻找新的 chart。



## 2. Helm 安装

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

4、Helm 命令补全
helm completion bash | sudo tee /etc/bash_completion.d/helm && bash
```

[helm-dashboard](https://github.com/komodorio/helm-dashboard) 注：未实践成功

helm plugin 方式
```
helm plugin install https://github.com/komodorio/helm-dashboard.git
helm dashboard
# -port 指定端口号
helm dashboard --port=31111

helm plugin list
which helm-dashboard
helm plugin uninstall dashboard
```

helm install 方式
```
helm repo add komodorio https://helm-charts.komodor.io
helm repo update
helm upgrade --install myrelease komodorio/helm-dashboard
helm uninstall dashboard
```



## 3. Helm 使用

### 基本操作

```
1、helm search 
查找 Charts
Helm 自带一个强大的搜索命令，可以用来从两种来源中进行搜索：
helm search hub 从 Artifact Hub 中查找并列出 helm charts。 Artifact Hub 中存放了大量不同的仓库。
helm search repo 从你添加（使用 helm repo add）到本地 helm 客户端中的仓库中进行查找。该命令基于本地数据进行搜索，无需连接互联网。

展示所有可用的 charts
helm search hub

2、helm list
查看应用（helm list --all 会展示 Helm 保留的所有 release 记录，包括失败或删除的条目（指定了 --keep-history））
```

### 最佳实践

chart 名称必须是小写字母和数字。单词之间可以使用横杠分隔(-)。  
chart 名称中不能用大写字母也不能用下划线。点 . 符号也不行。  
Chart.yaml需要首字母大写，因为文件名大小写敏感。  

values.yaml 文件命名规范：  
变量名称以小写字母开头，单词按驼峰区分。  
所有的 Helm 内置变量以大写字母开头，以便与用户定义的 value 进行区分：.Release.Name，.Capabilities.KubeVersion。

### Repository 管理

```
1、添加 chart 仓库
命令：helm repo add <仓库名称> <仓库 URL>
举例：helm repo add azure http://mirror.azure.cn/kubernetes/charts
举例：helm repo add aliyun https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts
举例：helm repo add bitnami https://charts.bitnami.com/bitnami
举例：helm repo add stable https://charts.helm.sh/stable

2、查看配置的仓库
helm repo list

3、移除仓库
命令：helm repo remove <仓库名称>
举例：helm repo remove bitnami

4、更新 chart 列表
helm repo update
```

### Chart 管理

```
1、查看 chart 列表
命令：helm search repo <repo 名称>
举例：helm search repo bitnami

2、更新 chart 列表
helm repo update

3、查看 chart 信息
命令：helm show chart <仓库名称>/<chart 名称>
举例：helm show chart bitnami/mysql

4、拉取 chart 包
命令：helm pull <仓库名称>/<chart 名称>
举例：helm pull bitnami/mysql
命令：helm pull <仓库名称>/<chart 名称> --version=<chart 版本>
举例：helm pull bitnami/mysql --version=9.4.1

5、创建 chart 包
命令：helm create <chart 名称>
举例：helm create mychart

6、打包
命令：helm package <chart 名称>
举例：helm package mychart/

7、修改 Chart 并重新打包
拉取 chart 包
命令：helm pull <仓库名称>/<chart 名称> --version=<chart 版本>
举例：helm pull bitnami/mysql --version=9.4.1
下载 mysql-9.4.1.tgz 到本地，执行：tar -zxvf mysql-9.4.1.tgz 解压 mysql-9.4.1.tgz 到 mysql
修改文件后并重新打包：helm package mysql/

8、查看 value
helm show values mychart/

9、查看所有 value
helm show all mychart/
```

### Release 管理

```
1、安装 Chart
命令：helm install <release 名称> <仓库名称>/<chart 名称>
举例：helm install myrelease bitnami/mysql
命令：helm install <release 名称> <仓库名称>/<chart 名称> --version=<chart 版本>
举例：helm install myrelease bitnami/mysql --version=9.4.1

命令：helm install <仓库名称>/<chart 名称> --generate-name //生成随机<release 名称>
举例：helm install bitnami/mysql --generate-name
参数说明：
-n: 指定将服务部署在k8s的命名空间中
--drun-run：测试安装，不进行实际安装操作

2、查看发布信息
命令：helm status <release 名称>
举例：helm status myrelease

3、使用 Helm 检索版本并查看实际加载的模板
helm get manifest <release 名称>
helm get manifest myrelease

4、查看发布历史
命令：helm history <release 名称>
举例：helm history myrelease

5、回滚版本（每当发生了一次安装、升级或回滚操作，revision 的值就会加1。第一次 revision 的值永远是1。我们可以使用 helm history [RELEASE] 命令来查看一个特定 release 的修订版本号。）
命令：helm rollback <release 名称> 1
举例：helm rollback myrelease 1

6、卸载 chart（该命令会从 Kubernetes 卸载 myrelease， 它将删除和该版本相关的所有相关资源（service、deployment、 pod 等等）甚至版本历史。）
命令：helm uninstall <release 名称>
举例：helm uninstall myrelease

7、删除 chart（heml list 查看发布的 chart）
命令：helm delete --purge <release 名称>
举例：helm delete --purge myrelease
```

helm upgrade 参数解释

```
helm upgrade [RELEASE] [CHART] [flags]

一些常用的标志（flags）包括：
--install：如果指定的 Release 不存在，则执行安装操作。
--namespace：指定部署的命名空间。
--values：指定自定义的 values 文件来覆盖 Chart 中的默认值。
--set：通过命令行设置单个值，例如：--set key=value。
--atomic：如果升级失败，回滚到之前的版本。
```


### Helm 安装资源顺序

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



## 4. Chart 解释

[帮助文档](https://helm.sh/zh/docs/chart_template_guide/getting_started/)

### 制作 Helm Chart

1. 创建一个名为 mychart 的新 Chart：`helm create mychart`
2. Chart.yaml 文件是描述 Chart 元数据的文件，包括 Chart 名称、版本、描述等。可以打开 Chart.yaml 文件并根据需要对其进行编辑。
3. values.yaml 文件包含 Chart 的默认值，可以在其中定义应用程序的配置选项。可以根据需要修改或添加键值对。
4. templates 目录包含了用于生成 Kubernetes 清单文件的模板文件。您可以编辑这些文件来定义应用程序的 Kubernetes 对象，如 Deployment、Service 和 ConfigMap （NOTES.txt: chart的"帮助文本"）等。一般以 .yaml 作为 YAML 文件的后缀，以 .tpl 作为 helper 文件的后缀。
5. 打包 Chart：`helm package mychart/`，这将在当前目录下创建一个名为 mychart-version.tgz 的文件，其中 version 是Chart 的版本号
6. 发布 Chart：`helm push mychart-version.tgz myrepo`
7. 安装 Chart：`helm install mychart myrelease`
8. Release 说明：

对象描述了版本发布本身。包含了以下对象：

- `Release.Name`：release名称
- `Release.Namespace`：版本中包含的命名空间(如果manifest没有覆盖的话)
- `Release.IsUpgrade`：如果当前操作是升级或回滚的话，该值将被设置为`true`
- `Release.IsInstall`：如果当前操作是安装的话，该值将被设置为`true`
- `Release.Revision`：此次修订的版本号。安装时是1，每次升级或回滚都会自增
- `Release.Service`：该service用来渲染当前模板。Helm里始终`Helm`

9. 子 Chart

```
cd mychart/charts
helm create mysubchart
rm -rf mysubchart/templates/*

单独测试子 chart
helm install my-sub-release --dry-run --debug mychart/charts/mysubchart
helm install myrelease --dry-run --debug ./mychart
```

### 推送 Helm Chart

```
安装 Helm Push 插件 注：未实践成功
helm plugin install https://github.com/chartmuseum/helm-push

将 Harbor 添加为 Helm chart 存储库
helm repo add my-repo https://example.com/harbor

推送 Helm chart 到 Harbor
helm push my-chart-0.1.0.tgz my-repo
```

### Helm Chart 函数

Helm Chart 提供了一系列内置的函数，用于处理和操作模板数据。以下是一些常用的函数示例：

- include 函数：用于包含其他模板文件。
- toYaml 函数：将对象转换为 YAML 格式的字符串。
- tpl 函数：对字符串进行模板渲染。
- toYaml 函数：将对象转换为 YAML 格式的字符串。
- default 函数：设置默认值，用于处理可选的配置选项。

```
创建 chart
helm create mychart

打包 chart
helm package mychart/

访问服务
curl http://127.0.0.1:8080

切换到 chart 目录并安装服务，优先指定 --namespace，其次从 yaml 文件读取 namespace
cd mychart
helm install myrelease .
helm install myrelease . --namespace my-space

查看服务列表
helm list

查看所有服务
kubectl get all -l app.kubernetes.io/name=mychart

删除服务
helm delete myrelease

指定文件安装服务
helm install myrelease -f my-values.yaml ./mychart

指定参数安装服务，--set 参数最高
helm install --set enableFeature=true ./mychart

更新服务，指定 values.yaml 文件：-f new-values.yaml
helm upgrade myrelease ./mychart
helm upgrade myrelease --set enableFeature=true ./mychart
helm upgrade myrelease -f new-values.yaml ./mychart

查看生成的 ConfigMap 资源
kubectl get configmap -A
kubectl get configmap example-configmap5 -o yaml

查看 Pod
kubectl get pod -A |grep mychart

查看 Service
kubectl get svc -A |grep mychart

查看 Secret
kubectl get secret myrelease-secret -o yaml

回滚到上一个版本
helm rollback myrelease 1

在命令行中预览
helm install myrelease ./mychart --dry-run --debug

导出到文件
helm template myrelease ./mychart > generated-resources.yaml
helm template myrelease mychart | grep -A 10 example-configmap4
```

1. Kubernetes ConfigMap 的定义文件示例，用于生成一个名为 helm-configmap-example.conf 的文件。这个示例使用 Helm 模板语法来动态插入变量值。

在 mychart/templates/ 目录下创建一个名为 configmap.yaml 的文件，添加以下内容：

```
apiVersion: v1
kind: ConfigMap
metadata:
name: example-configmap
namespace: {{ .Release.Namespace }}
data:
helm-configmap-example.conf: |+
[example]
key1 = {{ .Values.exampleConfig.key1 }}
key2 = {{ .Values.exampleConfig.key2 }}
key3 = {{ .Values.exampleConfig.key3 }}
key4 = {{ .Values.exampleConfig.key4 }}
```

在 mychart/values.yaml 文件中定义这些变量的默认值：

```
exampleConfig:
key1: value1
key2: value2
key3: value3
key4: value4
```

2. 使用模板化和可重用的方式。

在 mychart/templates/ 目录修改 service.yaml 的文件，修改以下内容：

```
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ if .Values.enableFeature }}8888{{ else }}80{{ end }}
      targetPort: http
      protocol: TCP
      name: http
```
.Values.enableFeature：引用 values.yaml 文件中的 enableFeature 配置选项。根据该选项的值，决定生成的配置。

在 mychart/values.yaml 文件中定义这些变量的默认值：
```
service:
  type: ClusterIP
  port: 80
  
enableFeature: true
```

3. .Values.services 是一个定义了多个服务的列表，在循环中遍历该列表，生成多个 Service 资源。

在 mychart/templates/ 目录下创建一个名为 service2.yaml 的文件，并添加以下内容：

```
{{- range .Values.services2 }}
---
apiVersion: v1
kind: Service
metadata:
  name: {{ include "mychart.fullname" $ }}-{{ .name }}
  labels:
    {{- include "mychart.labels" $ | nindent 4 }}
spec:
  type: {{ .type }}
  ports:
    - port: {{ .port }}
      targetPort: {{ .targetPort }}
      protocol: TCP
      name: http
  selector:
    {{- include "mychart.selectorLabels" $ | nindent 4 }}
{{- end }}
```

在 mychart/values.yaml 文件中定义这些变量的默认值：

```
services2:
  service1:
    name: service1
    type: ClusterIP
    port: 80
    targetPort: 8080
  service2:
    name: service2
    type: NodePort
    port: 8080
    targetPort: 8000
  service3:
    name: service3
    type: LoadBalancer
    port: 8888
    targetPort: 9090
```

4. {{ template "example.fullname" . }} 这个模板函数是从 Helm 图表的 _helpers.tpl 文件中获取的。
   在 Helm 图表中,通常会有一个名为 _helpers.tpl 的文件,用于定义各种可重用的模板函数。这个文件不会被直接渲染成 Kubernetes 资源清单,而是被其他模板文件引用。

5. 在 mychart/values.yaml 文件中定义这些变量的默认值：global.namespace: my-space 表示在整个 Helm 部署中,默认的命名空间都是 my-space。这个值可以被的 {{ .Release.Namespace }} 引用到。注：未实践成功
```
global:
namespace: my-space
```

6. 在 Helm 中，Release 是一个特殊的对象,它代表了当前 Helm 部署的状态和元数据。

7. {{ template "example-app.configmap" . }}: 这个模板函数使用了一个自定义的模板 example-app.configmap，它可能会在 templates/_helpers.tpl 文件中定义。这个模板函数用于生成 ConfigMap 的名称。

8. {{- $root := . }}: 这一行将当前的上下文(根上下文)赋值给 $root 变量。这是 Helm chart 中的一个常见做法,可以从嵌套的模板中访问顶层 chart 的值和函数。

9. include 函数在 Helm 模板中用于将一个已定义的模板插入到另一个模板中。它是一种重用和组织 Helm 图表模板的方式。
   在 mychart/templates/ 目录下创建一个名为 comfigmap3.yaml 的文件，并添加以下内容：
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: example-configmap
  namespace: {{ .Release.Namespace }}
data:
  helm-configmap-example.conf: |+
{{ include "example-config" . | indent 4 }}
```
在 mychart/templates/_helpers.tpl 并添加以下内容：
```
{{- define "example-config" }}
[example]
key1 = {{ .Values.exampleConfig.key1 }}
key2 = {{ .Values.exampleConfig.key2 }}
key3 = {{ .Values.exampleConfig.key3 }}
key4 = {{ .Values.exampleConfig.key4 }}
{{- end }}
```

10. {{ toYaml .Values.exampleConfig | indent 4 }}
    toYaml 函数可以将 .Values.exampleConfig 对象转换为 YAML 格式的字符串。使用 | indent 4 来缩进这些 YAML 数据,使其与前面的配置项对齐。

11. 嵌套循环

```
{{- $root := . }}
{{- $replicas := int $root.Values.example.replicaCount }}
{{- $nodeCount := int $root.Values.example.nodeCount }}
{{ range $_, $e := until $replicas }}
{{ range $_, $n := until $nodeCount }}
...
{{ end }}
{{ end }}
```

12. 在 mychart/templates/configmap.yaml 中修改配置：

```
倒置命令，使用管道符(|)将参数“发送”给函数
key1 = {{ .Values.exampleConfig.key0 }}
key1 = {{ .Values.exampleConfig.key1 | upper }}
key2 = {{ .Values.exampleConfig.key2 | upper | quote }}
key3 = {{ .Values.exampleConfig.key3 | repeat 5 | quote }}
key4 = {{ .Values.exampleConfig.key4 | default "tea" | quote }}
key5 = {{ .Values.exampleConfig.key5 | default (printf "%s-tea" (include "mychart.fullname" .))}}

values.yaml
key0: value0
key1: value1
key2: value2
key3: value3
#  key4: value4
#  key5: value5

查看结果
kubectl get configmap example-configmap -o yaml
key1 = value0
key1 = VALUE1
key2 = "VALUE2"
key3 = "value3value3value3value3value3"
key4 = "tea"
key5 = myrelease-mychart-tea
```

13. 流程语句

```
{{- if eq .Values.exampleConfig.key8 "value8" }}
key8 = "yes666"
{{- else }}
key8 = {{ .Values.exampleConfig.key8 }}
{{- end }}

{{-}} 表示去空格
{{- 3 }} 表示“删除左边空格并打印3”
{{-3 }} 表示“打印-3”
```

14. |-  {/* |-行是声明的多行字符串 */}

### Helm Chart 调试

1. helm lint 检查

helm lint 命令用于验证 Helm 图表的结构和配置。它会检查图表中是否存在任何问题或潜在的问题。
helm lint [CHART]
检查内容：

- 图表的 YAML 文件中是否存在语法错误
- 是否缺少或无效的必需字段
- 使用了 Kubernetes 资源的过时 API
- 资源命名约定是否正确
- 图表的 values.yaml 文件中是否存在未使用或重复的值

2. `helm template --debug` 在本地测试渲染chart模板
3. `helm install --dry-run --debug`：让服务器渲染模板的好方法，然后返回生成的清单文件。
4. `helm get manifest`: 这是查看安装在服务器上的模板的好方法。



## 五、知识碎片

### 制作插件

添加 main.go

```
helm plugin list

export HELM_PLUGIN_DIR=~/.config/helm/plugins

mkdir -vp ~/.config/helm/plugins/my-plugin/cmd/my-plugin

cd ~/.config/helm/plugins/my-plugin/cmd/my-plugin

vim main.go

package main

import (
    "fmt"
    "os"
)

func main() {
    fmt.Println("This is my custom Helm plugin!")
    os.Exit(0)
}

apt install golang-go
apt install gccgo-go

cd ~/.config/helm/plugins/my-plugin
go build -o cmd/my-plugin/main ./cmd/my-plugin/main.go
```
添加 plugin.yaml
```
cd ~/.config/helm/plugins/my-plugin
vim plugin.yaml

name: my-plugin
version: 0.1.0
usage: "This is my custom Helm plugin!"
description: My custom Helm plugin
#command: ./cmd/my-plugin/main 相对路径，推荐使用绝对路径
command: /root/.config/helm/plugins/my-plugin/cmd/my-plugin/main

cd ~/.config/helm/plugins
helm plugin remove my-plugin
helm plugin install ./my-plugin

如果使用相对路径就得切换到指定目录执行命令，设置绝对路径则可在任意位置执行
cd ~/.config/helm/plugins/my-plugin
helm my-plugin
```

### 安装依赖

在运行 helm dependency update 命令之后，它只会下载和更新依赖项，而不会自动安装实例
helm dependency update ./mychart

查看依赖列表
helm dependency list ./mychart

卸载实例
helm uninstall myrelease

安装实例
helm install myrelease ./mychart

更新实例
helm upgrade myrelease ./mychart

### 零散记录

执行发布版本的测试
helm test <release 名称>

这个命令用于将本地的 8080 端口转发到 Kubernetes 集群中名为 $POD_NAME 的 Pod 中的 $CONTAINER_PORT 端口。这样做可以通过访问本地的 8080 端口来访问 Pod 中的服务，而无需在集群外部直接访问 Pod。  
`kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT`