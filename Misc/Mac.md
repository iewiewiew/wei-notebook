[TOC]

<h1 align="center">Mac</h1>

> By：weimenghua  
> Date：2023.05.23  
> Descrition：Mac 使用技巧 



## Mac 信息

- 查看操作系统版本：左上角苹果图标 > 关于本机 > 操作系统版本
- 查看设备序列号：左上角苹果图标 > 关于本机 > 序列号
- 查看硬盘序列号：启动台搜索"系统信息" > 点击硬件 > 硬件UUID
- 查看 Mac 地址：ifconfig | grep "ether"  / ifconfig en0 | grep "ether"
- 查看操作系统的更新时间：softwareupdate --history --all



## Mac 快捷键

- Command+⬆️+#：截全屏
- Command+⬆️+$/4：截取选择区域
- Command+⬆️+%：录屏
- command+H：隐藏在运行窗口
- Command+W：关闭所有程序
- Command+tab：在应用程序间切换
- Command+Option+向左箭头/向右箭头：退回/前进到上一个操作的位置
- Command+⬆+.：展示隐藏文件
- 选择多列：  
  Option + 按住鼠标左键往上下拖拽  
  Option + 按住触控板 + 按住触控板往上下拖拽 
- 捏拢拇指和其他三指：打开启动台



## Mac 系统设置

- 找到 /etc/hosts 文件：访达 > 上方导航栏前往 > 前往文件夹 > 输入 /etc/ 按回车
- 右键共享发送文件到微信：设置方式：隐私与安全性-扩展-共享-发送到微信
- 开启自启：系统设置 > 通用 > 登录项



## Mac 工具集合

- SwitchHosts -- Host 管理工具
- [switchhosts 官网](https://switchhosts.vercel.app/zh)  
- [switchhosts 下载](https://github.com/oldj/SwitchHosts/releases)
- [Parallels Desktop  -- 虚拟机](https://www.parallels.com/products/desktop/)
- [Xterminal SSH 终端](https://www.terminal.icu/)
- iBar -- 强大的菜单栏图标管理工具
- TopMost -- 窗口可以置顶的工具
- 超级右键 -- 支持右键新建文件



## Mac Homebrew

**参考资料**  
[Homebrew 官网](https://brew.sh/)  
[Homebrew 源码](https://github.com/Homebrew)

1. 简介

Homebrew formula 是Homebrew 包管理器的一种形式，它是一种简单的脚本或模板，用于在 Homebrew 中安装软件包。Homebrew formula 包含有关软件包的信息，例如软件包的名称、版本、来源、依赖关系和安装过程等。

2. 安装

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```
安装软件包
brew install <package>

卸载软件包
brew uninstall <package>

更新已安装的软件包
brew update

搜索软件包
brew search <keyword>

查看已安装的软件包
brew list

显示软件包信息：
brew info <package>

查看软件包依赖关系brew deps python
brew deps <package>
```

3. formula

Homebrew formula 的地址在 Homebrew 官方 GitHub 仓库中，官方仓库的地址是 https://github.com/Homebrew/homebrew-core。  
在 homebrew-core 仓库中，所有的 formula 文件都存储在 Formula 目录下。你可以使用以下命令在本地查看 Homebrew 的 formula：

```
cd $(brew --repo)/Library/Taps/homebrew/homebrew-core/Formula/
ls
```

Brew 安装软件

```
brew install mysql-client

echo 'export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"' >> ~/.zshrc
mysqldump --version
```

1. 视频下载 [you-get](https://you-get.org/)

```
安装
brew install you-get
pip install you-get

例子
you-get 'https://www.youtube.com/watch?v=jNQXAC9IVRw'
```


## 知识碎片

- 下载软件
  - [macked](https://macked.app/)
  - [macwl](https://www.macwl.com/)

- Darwin

[Darwin](https://en.wikipedia.org/wiki/Darwin_(operating_system)) 是指苹果公司所开发的操作系统内核，它是 macOS 和 iOS 等操作系统的基础。Darwin 内核是一个开源项目，它基于类似于 BSD 的 UNIX 系统，并经过苹果公司的修改和优化。

brew install rar

rar a <output-file>.rar <folder-name>
```

Mac 如何指定目录不要同步到 iCloud：在文件名加上一个「.nosync」即可

- 踩坑

问题：Mac 声音突然变小  
解决：把企业微信、微信这些可能发生过语音通话的 app 关闭

使用“钥匙串访问”信任证书
1. 打开“钥匙串访问”
通过 Spotlight 搜索： 按下 Command + 空格键 打开 Spotlight，然后输入“钥匙串访问”，按 回车 键打开应用。  
通过 Finder 路径： 打开 Finder，前往“应用程序” > “实用工具”，找到并打开“钥匙串访问”。（注：没找到）  
2. 导入证书
将证书文件（例如 .cer, .crt 或 .p12）直接拖放到“钥匙串访问”（系统->证书）窗口中。点击信任，选择始终信任。
