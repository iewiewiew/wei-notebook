[TOC]

---

<h1 align="center">K3s 轻量级 Kubernetes</h1>

> By：weimenghua  
> Date：2023.05.22   
> Description：k3s

**参考资料**  
[K3S 官网](https://k3s.io/)  
[K3S 文档](https://docs.rancher.cn/docs/k3s/_index)  
[K3S 源码](https://github.com/k3s-io/k3s)  



### K3S 搭建
```
关闭防火墙
sed -i 's/enforcing/disabled/' /etc/selinux/config

安装
方式一
curl -sfL https://rancher-mirror.oss-cn-beijing.aliyuncs.com/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn sh -
方式二
curl -sfL https://get.k3s.io | sh -

待定
dnf install -y container-selinux
dnf install -y https://rpm.rancher.io/k3s/stable/common/centos/8/noarch/

配置
mkdir -p $HOME/.kube
cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
cat ~/.kube/config

vim ~/.kube/config
修改 127.0.0.1 为公网 IP

重启
systemctl restart k3s

停止
systemctl stop k3s

查看状态
systemctl status k3s.service

验证
kubectl get node

卸载
sh /usr/local/bin/k3s-uninstall.sh
```