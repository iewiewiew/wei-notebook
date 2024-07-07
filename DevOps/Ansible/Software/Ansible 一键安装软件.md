[TOC]

<h1 align="center">Ansible 一键安装软件</h1>

> By：weiemnghua  
> Date：2023.08.11  
> Description：



1. 安装 Ansible
```
yum install -y ansible
sudo apt install -y ansible
```

```
ubuntu 安装插件
sudo apt install sshpass
```


2. 克隆仓库
```
git clone git@github.com:iewiewiew/wei-notebook.git
```


3. 执行 Ansible 部署
   1. 修改 `hosts.ini` 文件，配置发压机ip、root账号、root密码。
   2. `cd Software-Ansible` 执行 `ansible-playbook -i hosts.ini run.yml` 命令，进行自动部署


4. 检查软件是否安装成功
- ant -version
- docker version
- git --version
- java -version
- jmeter --version
- python3 -V


踩坑：  
必须手动执行 `souce /etc/profile`
