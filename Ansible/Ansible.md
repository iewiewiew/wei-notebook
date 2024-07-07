[TOC]

---

<h1 align="center">Ansible</h1>

> By：weimenghua  
> Date：2022.06.07  
> Description：Ansible 自动化运维  

**参考资料**  
[Ansible 官方文档](https://docs.ansible.com/)  
[Ansible 内容公共资源](https://galaxy.ansible.com/)  
[Ansible 源码](https://github.com/ansible/ansible)  
[Ansible 自动化运维教程](https://www.w3cschool.cn/automate_with_ansible/)  
[Ansible 中文权威指南](https://ansible-tran.readthedocs.io/en/latest/index.html#ansible)



## 1. Ansible 简介

ansible 是自动化运维工具，基于 Python 开发，集合了众多运维工具（puppet、cfengine、chef、func、fabric）的优点，实现了批量系统配置、批量程序部署、批量运行命令等功能。

### 1.1 Ansible 的特点

ansible 是基于模块工作的，本身没有批量部署的能力。真正具有批量部署的是 ansible 所运行的模块，ansible 只是提供一种框架。主要包括：  
(1) 连接插件 connection plugins：负责和被监控端实现通信  
(2) host inventory：指定操作的主机，是一个配置文件里面定义监控的主机  
(3) 各种模块核心模块、command 模块、自定义模块  
(4) 借助于插件完成记录日志邮件等功能  
(5) playbook：剧本执行多个任务时，非必需可以让节点一次性运行多个任务  

### 1.2 Ansible 相关概念

- Play：将一系列主机与需要在主机上运行的任务列表相关联
- Playbook：一个 ansible 脚本，它指定一系列 play 与一批 play 执行的对象主机
- Task：Ansible play 中的工作单元，一个 task 指定一个模块和相关参数，以及一个可选名字与一些可选的参数
- TLS（Transport Layer Security）：用于 Web 服务器与浏览器之间相关的安全通信协议
- Transport：Ansible 用于连接到远程主机的协议与实现，默认的 transport 是 SSH
- Convergence（收敛性）：配置管理系统的一种属性，具有这种属性的系统将会对一台服务器执行多次让服务器接近期望的状态（Ansible 执行一次后就会将服务器置为期望状态，所以不具备收敛性）



## 2. Ansible 搭建

1. ansible 的安装来源于 epel 仓库，因此在安装前需确保安装了正确的 epel 源：`yum install -y epel-release`
2. 安装 ansible 命令：`yum install ansible -y` `sudo apt install ansible`
3. 查看 ansible 是否安装：`rpm -qa |grep ansible / whereis ansible`
4. 查看 ansible 安装信息：`ansible --version`



## 3. Ansible 使用

ansible 配置文件：`/etc/ansible/ansible.cfg`

在管理节点（即安装 ansible 的节点）上添加目标节点（即需要管理的节点）的 ssh 认证信息。  
管理节点生成 SSH-KEY：`ssh-keygen`  
添加目标节点的 SSH 认证信息：`ssh-copy-id root@目标节点 IP`  
如：`test：127.0.0.1，root`  
这里 root 是在目标节点上登录的用户，@ 符号后面接目标节点 IP 即可，之后会提示输入目标节点 root 用户密码，输入即可。  
添加认证信息后，目标节点主机的`~/.ssh/`目录下将会出现一个`authorized_keys`文件，里面包含了 ansible 管理节点的公钥信息，可以检查一下是否存在。  
在主机列表添加机器信息

```
vim /etc/ansible/hosts
[test]
127.0.0.1
127.0.0.2
```

检查 ansible 主机是否连通目标机器
```
ansible -m ping <hosts_name>
ansible -m ping test
```

查看组清单  
`ansible <hosts_name> --list-hosts`  

主机发送文件到目标机器    
`ansible <hosts_name> -m copy -a "src=/tmp/demo.sh dest=/tmp/"`

同步文件 delete=yes: 全量同步，保持2边数据一致; 不加则增量同步  
`ansible <hosts_name> -m synchronize -a "src=/tmp/ dest=/tmp/ delete=yes"`

获取主机清单中所有服务器的 ip 地址  
`ansible <hosts_name> -m shell -a "ifconfig ens33 | awk '{if(NR==2){print $1}}'"`

在 Ansible 中，当一个任务被跳过时，它会显示 `skipped=1` 的信息。任务被跳过的原因可能有多种可能性，以下是其中一些常见的原因：
1. 条件不符合：任务包含了一个条件语句，但该条件语句的结果为 false，因此任务被跳过。
2. 模块不支持：任务使用了一个在目标主机上不可用的模块，因此任务被跳过。
3. 已经满足：任务已经被成功执行，并且结果已经符合预期，因此任务被跳过。
4. 依赖项未满足：任务所依赖的其他任务或变量未被成功执行或定义，因此任务被跳过。

查看任务被跳过的原因：`ansible-playbook myplaybook.yml -v`

查看更详细的执行过程：`ansible-playbook myplaybook.yml -vvv`

在 Ansible 中，`become` 是一种特权升级机制，可以在执行任务时提升用户的权限，以便执行需要特权的操作。`become` 可以使用不同的方法来实现特权升级，如 sudo、su、pbrun、pfexec 等。

以下是使用 `become` 在 Ansible 中提升特权的步骤：

1. 在 Playbook 文件中指定 `become`：

```
---
- hosts: all
  become: true
  tasks:
    - name: Install Apache
      apt:
        name: apache2
        state: present
```

在上述 Playbook 中，`become` 被设置为 `true`，这意味着在执行任务时会自动提升特权。

2. 使用 `become` 模块指定特权升级方式：

```
---
- hosts: all
  tasks:
    - name: Restart Apache
      service:
        name: apache2
        state: restarted
      become:
        method: sudo
```

在上述 Playbook 中，`become` 模块被用于指定特权升级方式。在这种情况下，使用 sudo 来提升特权。

3. 使用 `-b` 参数在命令行中指定 `become`：

```
ansible-playbook -b playbook.yml
```

在上述命令中，`-b` 参数被用于在命令行中指定 `become`，这将在执行 Playbook 时自动提升特权。

注意：目前仅在第 3 种方式实践成功。



## 4. Ansible 模块

[Ansible 模块](https://docs.ansible.com/ansible/2.9/modules/modules_by_category.html)

### 4.1 命令相关

- command 模块

comand 模块不会通过 Shell 处理命令，因此不支持像 $HOME 这样的变量。以及 < > | ; 和 & 等都是无效的。

```
查看帮助文档
ansible-doc -s command

查看模块总量
ansible-doc -l | wc -l

命令
ansible <host> -m command -a '<command>'

例子
ansible localhost -m command -a 'ls -l'
ansible localhost -m command -a 'free -m'
```

获取到 ansible playbook 中 command 模块的输出，可以通过使用 register 关键字来实现，register 关键字可以存储指定命令的输出结果到一个自定义的变量中，通过访问这个自定义变量就可以获取到命令的输出结果。

执行：ansible-playbook -C command.yml

```
---
- hosts: test
  tasks:
    - name: test
      command: ls -l
      register: command_result # register 指令把 command 执行结果寄存到自定义变量中
    - name: echo command
      debug:
        msg: "打印变量 {{ command_result }}"
```

- shell 模块

在远程节点上批量执行命令或脚本（可以是多个命令）

```
命令
ansible <host> -m shell -a '<command>'

例子
ansible localhost -m shell -a 'ls -l'
ansible localhost -m shell -a "sh /tmp/demo.sh"
```

- script 模块

把管理机本地脚本传输到远端被控节点并执行，参数同shell和command，比shell模块更强大，本地有一份脚本即可在所有被控机器上执行（且无需授权）。

```
命令
ansible <host> -m script -a '<command>'

举例
ansible <host> -m script -a '/root/backup.sh'
```

### 4.2 文件相关

- copy 模块

拷贝文件和目录，src 不能是空目录，空目录无法拷贝，拷贝过去的目录和文件如不指定属性，默认是 root:root，权限是 755 和 644。owner 指定属主，相当于chown、group 指定属组，相当于chown、mode 指定权限，相当于chomd。加上backup=yes，批量复制前会对原文件（如有）进行备份。

```
命令
ansible <host> -m copy -a 'src=/path/to/file dest=/path/to/file [owner=name] [group=name] [mode=number] 

举例
ansible test -m copy -a 'src=/root/tmp/tmp.txt dest=/root/tmp/tmp.txt owner=root group=root mode=644'
ansible test -m copy -a "src=/root/tmp/tmp.txt dest=/root/tmp/tmp.txt" 
```

执行：ansible-playbook -C copy.yml
```
---
- name: test1
  hosts: test
  tasks:
    - name: copy
      copy: src=/root/tmp/tmp.txt dest=/root/tmp/tmp.txt owner=root group=root mode=644

- name: test2
  hosts: test
  tasks:
    - name: copy
      copy:
        src: /root/tmp/tmp.txt
        dest: /root/tmp/tmp.txt
```

- synchronize 模块

synchronize 基于 rsync 命令批量同步文件，必须保证远程服务器上有 rsync 这个命令，`yum install -y rsync`  
**命令行方式**  
compress=yes 表示开启压缩，delete 表示数据一致，rsync_opts 表示同步参数，--exclude 表示排除文件  
把本地的 /tmp 目录以及里面除了 .txt 结尾的文件同步到 127.0.0.1 的 /mnt 目录里面，并且同步 /tmp 目录以及文件的属性，还要删除本地没有但远程主机有的文件

示例代码为：

```
ansible 127.0.0.1 -m synchronize -a "src=/tmp dest=/mnt compress=yes delete=yes archive=yes rsync_opts=--exclude=*.txt"
```

**参数说明**

- compress : 压缩传输(默认开启)
- archive : 是否采用归档模式同步，保证源文件和目标文件属性一致
- checksum : 是否校验
- dirs : 非递归传送目录
- links : 同步链接指向文件
- recursive : 是否递归 yes/no
- rsync_opts : 使用 rsync 参数
- copy_links : 同步的时候是否复制链接
- delete : 以推送方为主的无差异同步传输
- src : 源目录以文件
- dest : 目标文件及目录
- dest_port : 目标接受的端口
- rsync_path : 服务的路径，指定 rsync 在远程服务器上执行
- rsync_remote_user : 设置远程用户名
- --exclude=*.log : 此处为忽略 .log 结尾的文件，必须和 rsync_opts 使用例子：rsync_opts=--exclude=.txt
- mode : 同步模式，rsync 的同步模式默认推送 （push）从远端拉取为 （pull）

```
---
  - name: test
    hosts: test
    tasks:
    - name: "synchronize files"
      synchronize:
        src: '{{ item.src }}'
        dest: '{{ item.dest }}'
        delete: yes
      with_items:
      - { src: '/root/tmp/tmp.txt'， dest: '/root/tmp/tmp.txt' }
```

- fetch 模块

远程文件 copy 到本地  
**参数说明**

- `flat`：如果设置为 true，则从 `src` 中仅保留文件名，而不是保留完整的路径。
- `validate_checksum`：如果设置为 true，则在复制文件之前验证文件的校验和，以确保文件没有被修改。
- `remote_src`：如果设置为 true，则从远程主机的 `src` 路径获取文件，否则从控制节点上的 `src` 路径获取文件。

执行：ansible-playbook -C fetch.yml

```
---
- name: test
  hosts: test
  tasks:
    - name: "fetch"
      fetch:
        src: /root/tmp/tmp.txt
        dest: /root/tmp
        flat: true
```

- file 模块

文件操作

**参数说明**
用于设定或修改文件的属性信息
- group：默认为空 
- owner：默认为空 
- path：默认为空，别名：'dest'， `name' 
- recurse：yes， no 默认为 no 
- src：创建连接文件时有用
- state：file， link， directory， hard， touch， absent，file 默认属性，如果文件不存在则不创建，并且报错，用于修改已存在文件的属性 directory 如果目录不存在，则创建目录和子目录 
  1. absent 递归删除文件或目录 
  2. link 在创建软链接是有用 
  3. hard 创建硬链接              

执行：ansible-playbook -C file.yml

```
---
- name: test
  hosts: test
  tasks:
  - name: "create directory"
    file: path={{ item }} state=directory owner=root group=root recurse=yes
    with_items:
    - "/root/tmp/logs"
    - "/root/tmp/bin"
```

### 4.3 其它模块

- git 模块

代码管理

执行：ansible-playbook -C git.yml

```
---
- name: test
  hosts: test
  vars:
    git_dir: /root/tmp/wei-notebook  # 注：必须是空目录
  tasks:
    - name: "Clone the Git repo"
      git:
        repo: 'https://gitee.com/iewiewiew/wei-notebook.git'
        dest: '{{ git_dir }}'
        clone: yes
        update: yes
```

- get_url 模块

用途：用于将文件或软件从 http、https 或ftp 下载到本地节点上 ，类似于 wget

**参数说明**
- dest： 指定将文件下载的绝对路径---必须 
- url： 文件的下载地址（网址）---必须 
- url_username: 用于 http 基本认证的用户名 
- url_password： 用于 http 基本认证的密码 
- validate_certs： 如果否，SSL 证书将不会验证。这只应在使用自签名证书的个人控制站点上使用 
- owner： 指定属主
- group： 指定属组 
- mode： 指定权限              

```
ansible test -m get_url -a "url=http://nginx.org/download/nginx-1.12.2.tar.gz dest=/root/tmp/"
```

- mysql_db 模块

操作数据库

前提：yum install -y mysql / pip install pymysql

```
---
- name: mysql
  hosts: test
  tasks:
    - name: "create a database"
      mysql_db:
        login_host: "127.0.0.1"
        login_user: "root"
        login_password: "root"
        login_port: "3306"
        name: "ansible"
        encoding: "utf8"
        state: "present"

- name: mysql
  hosts: test
  tasks:
    - name: "delete a database"
      mysql_db:
        login_host: "127.0.0.1"
        login_user: "root"
        login_password: "root"
        login_port: "3306"
        name: "ansible"
        state: "absent"

- name: mysql
  hosts: test
  tasks:
    - name: "dump a database"
      mysql_db:
        login_host: "127.0.0.1"
        login_user: "root"
        login_password: "root"
        login_port: "3306"
        name: "ansible"
        target: "/tmp/ansible.gz"
        state: "dump"
        
---
- name: mysql
  hosts: test
  tasks:
    - name: "import a database"
      mysql_db:
        login_host: "127.0.0.1"
        login_user: "root"
        login_password: "root"
        login_port: "3306"
        name: "ansible"
        target: "/tmp/ansible.gz"
        state: "import"        
```

- user 模块

用户管理
检查：`cat /etc/passwd ｜ cat /etc/group`

执行：ansible-playbook -C user.yml

```
---
- hosts: test
  tasks:
    - name: "create user"
      user:
        name: "root" # 定义对象
        uid: "666"
        append: yes
        group: "root"
        state: present
        home: "/root/tmp"
```

- template 模块

文档内变量的替换  
template 模块官网说明：template 使用了 Jinja2格式作为文件模版，进行文档内变量的替换的模块。它的每次使用都会被 ansible 标记为”changed”状态。  
通俗来讲，就是在本地 file.j2 文件里的变量状态。例如在 file.j2 文件里有变量： username="{{ admin_username }}" password="{{ admin_password }}"。 那么，file.j2 文件会一直保持变量状态，直到 file.j2 文件被 ansible 的 template 模块执行后，文件里的变量就会被具体的值代替，并且传送到远程主机。  
例如，在 roles 里面调用了 template 模块，那么 ansible 会在 roles 同级目录 global_vars 里找到存储变量的文件，或者有时会在 roles 目录里的 vars 目录定义变量的文件，然后，找到对应变量的值，再将变量传递给 file.j2 文件。  

- with_items 模块

迭代

```
- name: add several users
  user: name={{ item }} state=present groups=wheel
  with_items:
    - testuser1
    - testuser2

- name: add several users
  user: name={{ item.name }} state=present groups={{ item.groups }}
  with_items:
    - { name: 'testuser1'， groups: 'wheel' }
    - { name: 'testuser2'， groups: 'root' }
```

其它

```
修改主机名称
ansible <host> -m hostname -a 'name=<host_name>'
```



## 5. Ansible Playbook
playbooks 使用 yaml 语法，在 ansible 中几乎所有的 yaml 文件都是以 list 开始，每个 item 是键值对的 list。  
所有的 yaml 文件都以---开头表示开始一个 document，所有的列表元素以 - 开头，键值对用 : 。  
键值对中的值如果是 bool 类型的字符串 true/false（首字母不论大小写），pyyaml 会 load 成 python 中对应的 bool 值，在键值对中如果值中有 : 或者以 {{ 开头的变量定义，则必须用引号引起来。

规则
- 大小写敏感
- 文档以---开始
- 缩进只能使用空格，不能使用 tab

1、执行 yml（不带参数）  
`ansible-playbook demo.yaml`

2、执行 yml（带参数）  
`ansible-playbook demo.yaml --extra-vars "user=user_name uid=666 group=group_name"`

3、检查 playbook  
`ansible-playbook -C playbook-demo.yml`

使用命令行变量
在命令行里面传值得的方法：  
`ansible-playbook var_in_command.yml --extra-vars "hosts=web user=root"`    
还可以用 json 格式传递参数：  
`ansible-playbook var_in_command.yml --extra-vars "{'hosts':'vm-rhel7-1'， 'user':'root'}"`

- hosts: "{{ groups.all | difference(['localhost']) }}"

groups.all 是一个特殊的Ansible变量，表示所有已定义的主机组。
difference(['localhost']) 是一个过滤器，用于从 groups.all 中移除 'localhost' 主机或主机组。这意味着在这个Playbook中，除了 'localhost' 主机（本地主机）外，其他所有主机或主机组都将作为目标主机。

```
[web_servers]
server1
server2
server3

[database_servers]
db1
db2

[localhost]
127.0.0.1
```

```
---
- name: Example Playbook
  hosts: "{{ groups.all | difference(['localhost']) }}"
  tasks:
  - name: Print hostname
    ansible.builtin.debug:
    msg: "This task runs on host {{ inventory_hostname }}"
```


在Ansible中，delegate_to: localhost 是一种指令，用于将任务委派（delegate）给本地主机执行。这意味着特定的任务将在控制节点上（即运行Ansible的主机）而不是目标主机上执行。

```
---
- name: Example Playbook
  hosts: all
  tasks:
    - name: Run a command on localhost
      ansible.builtin.command:
        cmd: echo "This command runs on localhost"
      delegate_to: localhost

    - name: Copy a file from localhost to target host
      ansible.builtin.copy:
        src: /path/to/local/file
        dest: /path/to/remote/file
      delegate_to: localhost
```

在Ansible中，ansible_facts 是一个特殊的变量，它包含了有关目标主机的各种系统信息和属性。ansible_facts 变量中的内容由Ansible在执行Playbook期间自动收集和提供。

```
---
- name: Example Playbook
  hosts: all
  tasks:
  - name: Print message for CentOS hosts
    debug:
    msg: "This task runs on CentOS hosts"
    when: ansible_facts['distribution'] == "CentOS"

  - name: Print message for non-CentOS hosts
    debug:
    msg: "This task runs on non-CentOS hosts"
    when: ansible_facts['distribution'] != "CentOS"
```

ansible-console 是一个交互式命令行工具，用于与远程主机进行交互操作。

```
打开控制台：ansible-console
列出当前组主机列表：list
列出所有的内置命令：？或者help
```



## 6. Ansible Galaxy

### Ansible Role
Ansible Role 是一种组织和重用 Ansible 配置的方式，它可以将相关的配置任务、变量和文件组织在一起，以便在多个项目或环境中重复使用。  
[详细例子](https://github.com/iewiewiew/Software-Installation)

### Ansible Galaxy

初始化角色
ansible-galaxy init roles

[roles 目录结构](roles/roles-example)  

- tasks 目录：用于存放主要的任务文件。
- vars 目录：用于存放变量文件。
- files 目录：用于存放要复制到目标主机的文件。
- templates 目录：用于存放模板文件。
- meta 目录：用于存放与 Role 相关的元数据，例如依赖关系。
- handlers 目录：用于存放处理器文件。
- defaults 目录：用于存放默认变量文件。

搜索角色
ansible-galaxy search 'redis'

角色安装管理
ansible-galaxy install geerlingguy.redis -p roles/

### Ansible 可视化

[Ansible GUI-Semaphore](https://github.com/semaphoreui/semaphore)

docker run -d -p 8888:3000 --name semaphore \
-e SEMAPHORE_DB_DIALECT=bolt \
-e SEMAPHORE_ADMIN=admin \
-e SEMAPHORE_ADMIN_PASSWORD=changeme \
-e SEMAPHORE_ADMIN_NAME=Admin \
-e SEMAPHORE_ADMIN_EMAIL=admin@localhost \
-d semaphoreui/semaphore:latest

### Ansible 文件修改

Ansible 提供的用于文件修改的三个关键模块是 lineinfile、replace 和 blockinfile。
管理文本文件中的行时，可以使用 lineinfile 模块。它可以确保文件中存在或不存在特定行。
替换模块与 lineinfile 类似，但它对完整的文件内容进行操作，或者可以替换文件中指定模式的所有实例。
在文件中插入/更新/删除行块时，可以使用 blockinfile 模块。



## 7. 知识碎片
### Ansible 踩坑
ansible 脚本中的参数不能带-

干了个蠢事，调试的时候加了 -C，我说咋又没报错，咋都没执行成功

