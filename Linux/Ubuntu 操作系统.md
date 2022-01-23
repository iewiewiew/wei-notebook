[TOC]

<h1 align="center">ubuntu 操作系统</h1>

> By：weimenghua  
> Date：2023.08.10  
> Description：  


### 安装 Ansible
```
更新系统软件包列表
sudo apt update

安装Ansible软件包
sudo apt install ansible

检查Ansible的版本
ansible --version
```



### 安装 MySQL
```
更新软件包列表
sudo apt update

安装MySQL服务器
sudo apt install mysql-server

安装过程中，系统会提示设置MySQL root用户的密码，设置一个安全的密码并记住它

安装完成后，启动MySQL服务
sudo systemctl start mysql

可以将MySQL设置为开机自启动
sudo systemctl enable mysql
```

重置MySQL密码（未实践成功）
```
如果无法找到MySQL密码或需要重置密码，可以使用以下步骤：

停止MySQL服务
sudo systemctl stop mysql

启动MySQL服务，并跳过权限检查：
sudo mysqld_safe --skip-grant-tables &

使用以下命令以root用户身份登录MySQL
mysql -u root

在MySQL命令行中执行以下命令来更新密码：
UPDATE mysql.user SET authentication_string = PASSWORD('新密码') WHERE User = 'root';
FLUSH PRIVILEGES;
将"新密码"替换为您要设置的新密码。

退出MySQL命令行：
exit;

停止MySQL服务：
sudo systemctl stop mysql

重新启动MySQL服务：
sudo systemctl start mysql
```



### ubuntu 系统启用 root 用户远程登陆
1、使用ubuntu用户登陆到系统中；

2、编辑/etc/ssh/sshd_config文件；  
sudo vim /etc/ssh/sshd_config  
找到配置参数：PermitRootLogin  
将该参数后面的值修改为yes即可；  
按“esc键” :wq 回车，保存退出；

3、给root用户设置密码；  
sudo passwd root  
输入两遍密码；  
（给root用户设置了密码后，就已经可以使用root用户从vnc登陆到系统中了）

4、重启ssh服务
sudo systemctl restart ssh  
然后测试用root用户远程登陆即可；