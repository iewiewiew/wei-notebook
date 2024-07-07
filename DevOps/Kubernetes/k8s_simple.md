# Kubernetes (K8s) 容器管理常用命令

## 基础配置

### 查看集群信息
```bash
# 查看集群信息
kubectl cluster-info

# 查看节点信息
kubectl get nodes

# 查看节点详细信息
kubectl describe node <node_name>

# 查看集群配置
kubectl config view
```

### 切换上下文
```bash
# 查看当前上下文
kubectl config current-context

# 查看所有上下文
kubectl config get-contexts

# 切换上下文
kubectl config use-context <context_name>
```

## Pod 管理

### 查看 Pod
```bash
# 查看所有 Pod
kubectl get pods

# 查看所有命名空间的 Pod
kubectl get pods --all-namespaces

# 查看指定命名空间的 Pod
kubectl get pods -n <namespace>

# 查看 Pod 详细信息
kubectl describe pod <pod_name>

# 查看 Pod 日志
kubectl logs <pod_name>

# 实时查看 Pod 日志
kubectl logs -f <pod_name>

# 查看多个 Pod 的日志
kubectl logs -f <pod_name1> <pod_name2>
```

### 创建和删除 Pod
```bash
# 通过 YAML 文件创建 Pod
kubectl create -f <pod.yaml>

# 通过 YAML 文件应用配置（创建或更新）
kubectl apply -f <pod.yaml>

# 删除 Pod
kubectl delete pod <pod_name>

# 强制删除 Pod
kubectl delete pod <pod_name> --force --grace-period=0

# 删除指定命名空间的 Pod
kubectl delete pod <pod_name> -n <namespace>
```

### 进入 Pod
```bash
# 进入 Pod 容器
kubectl exec -it <pod_name> -- /bin/bash

# 进入 Pod 指定容器（多容器 Pod）
kubectl exec -it <pod_name> -c <container_name> -- /bin/bash

# 在 Pod 中执行命令
kubectl exec <pod_name> -- <command>
```

## Deployment 管理

### 查看 Deployment
```bash
# 查看 Deployment
kubectl get deployments

# 查看 Deployment 详细信息
kubectl describe deployment <deployment_name>

# 查看 Deployment 的 ReplicaSet
kubectl get rs
```

### 创建和更新 Deployment
```bash
# 创建 Deployment
kubectl create deployment <deployment_name> --image=<image_name>

# 应用 Deployment 配置
kubectl apply -f <deployment.yaml>

# 更新 Deployment 镜像
kubectl set image deployment/<deployment_name> <container_name>=<new_image>

# 扩展 Deployment
kubectl scale deployment <deployment_name> --replicas=<number>

# 滚动更新 Deployment
kubectl rollout restart deployment/<deployment_name>
```

### 查看更新状态
```bash
# 查看更新状态
kubectl rollout status deployment/<deployment_name>

# 查看更新历史
kubectl rollout history deployment/<deployment_name>

# 回滚到上一个版本
kubectl rollout undo deployment/<deployment_name>

# 回滚到指定版本
kubectl rollout undo deployment/<deployment_name> --to-revision=<revision_number>
```

## Service 管理

### 查看 Service
```bash
# 查看 Service
kubectl get services

# 查看 Service 详细信息
kubectl describe service <service_name>

# 查看 Service 端点
kubectl get endpoints <service_name>
```

### 创建 Service
```bash
# 创建 Service
kubectl create service <service_type> <service_name> --tcp=<port>

# 应用 Service 配置
kubectl apply -f <service.yaml>

# 为 Deployment 创建 Service
kubectl expose deployment <deployment_name> --port=<port> --target-port=<target_port>
```

## ConfigMap 和 Secret

### ConfigMap 管理
```bash
# 查看 ConfigMap
kubectl get configmap

# 查看 ConfigMap 详细信息
kubectl describe configmap <configmap_name>

# 创建 ConfigMap
kubectl create configmap <configmap_name> --from-file=<file_path>

# 从字面值创建 ConfigMap
kubectl create configmap <configmap_name> --from-literal=<key>=<value>

# 应用 ConfigMap 配置
kubectl apply -f <configmap.yaml>

# 删除 ConfigMap
kubectl delete configmap <configmap_name>
```

### Secret 管理
```bash
# 查看 Secret
kubectl get secrets

# 查看 Secret 详细信息
kubectl describe secret <secret_name>

# 创建 Secret
kubectl create secret generic <secret_name> --from-file=<file_path>

# 从字面值创建 Secret
kubectl create secret generic <secret_name> --from-literal=<key>=<value>

# 应用 Secret 配置
kubectl apply -f <secret.yaml>

# 删除 Secret
kubectl delete secret <secret_name>
```

## 命名空间管理

### 查看命名空间
```bash
# 查看所有命名空间
kubectl get namespaces

# 查看命名空间详细信息
kubectl describe namespace <namespace_name>
```

### 创建和删除命名空间
```bash
# 创建命名空间
kubectl create namespace <namespace_name>

# 应用命名空间配置
kubectl apply -f <namespace.yaml>

# 删除命名空间
kubectl delete namespace <namespace_name>
```

### 切换到命名空间
```bash
# 设置默认命名空间
kubectl config set-context --current --namespace=<namespace_name>
```

## 资源管理

### 查看资源
```bash
# 查看所有资源
kubectl get all

# 查看指定命名空间的所有资源
kubectl get all -n <namespace>

# 查看资源使用情况
kubectl top nodes

# 查看 Pod 资源使用情况
kubectl top pods

# 查看指定命名空间的 Pod 资源使用情况
kubectl top pods -n <namespace>
```

### 资源限制
```bash
# 查看资源配额
kubectl get quota

# 查看资源配额详细信息
kubectl describe quota <quota_name>

# 查看限制范围
kubectl get limitrange

# 查看限制范围详细信息
kubectl describe limitrange <limitrange_name>
```

## 调试和故障排查

### 查看事件
```bash
# 查看所有事件
kubectl get events

# 查看指定命名空间的事件
kubectl get events -n <namespace>

# 实时查看事件
kubectl get events --watch
```

### 查看组件状态
```bash
# 查看所有组件状态
kubectl get componentstatuses

# 查看集群组件健康状态
kubectl get cs
```

### 端口转发
```bash
# 转发 Pod 端口到本地
kubectl port-forward <pod_name> <local_port>:<pod_port>

# 转发 Service 端口到本地
kubectl port-forward service/<service_name> <local_port>:<service_port>

# 转发 Deployment 端口到本地
kubectl port-forward deployment/<deployment_name> <local_port>:<container_port>
```

## 标签和选择器

### 标签管理
```bash
# 查看标签
kubectl get pods --show-labels

# 添加标签
kubectl label pod <pod_name> <key>=<value>

# 删除标签
kubectl label pod <pod_name> <key>-

# 更新标签
kubectl label pod <pod_name> <key>=<value> --overwrite
```

### 使用选择器
```bash
# 使用标签选择器
kubectl get pods -l <key>=<value>

# 使用多个标签选择器
kubectl get pods -l <key1>=<value1>,<key2>=<value2>

# 使用表达式选择器
kubectl get pods -l '<key> in (<value1>,<value2>)'
```

## 常用技巧

### YAML 文件操作
```bash
# 使用 YAML 格式输出
kubectl get pod <pod_name> -o yaml

# 使用 JSON 格式输出
kubectl get pod <pod_name> -o json

# 导出资源配置
kubectl get pod <pod_name> -o yaml > pod.yaml

# 编辑资源
kubectl edit pod <pod_name>

# 编辑 Deployment
kubectl edit deployment <deployment_name>
```

### 批量操作
```bash
# 删除所有 Pod
kubectl delete pods --all

# 删除指定命名空间的所有 Pod
kubectl delete pods --all -n <namespace>

# 删除所有 Deployment
kubectl delete deployments --all

# 删除所有 Service
kubectl delete services --all
```

### 补丁操作
```bash
# 使用 JSON 补丁
kubectl patch pod <pod_name> -p '{"spec":{"containers":[{"name":"<container_name>","image":"<new_image>"}]}}'

# 使用策略合并补丁
kubectl patch pod <pod_name> --type='merge' -p '{"metadata":{"labels":{"new-label":"value"}}}'
```

### 执行命令
```bash
# 在所有 Pod 中执行命令
kubectl get pods -o name | xargs -I {} kubectl exec {} -- <command>

# 在指定标签的 Pod 中执行命令
kubectl get pods -l <key>=<value> -o name | xargs -I {} kubectl exec {} -- <command>
```

## Helm 管理（可选）

### 基础操作
```bash
# 安装 Helm Chart
helm install <release_name> <chart_name>

# 列出已安装的 Helm Release
helm list

# 升级 Helm Release
helm upgrade <release_name> <chart_name>

# 卸载 Helm Release
helm uninstall <release_name>

# 查看 Helm Release 状态
helm status <release_name>
```

