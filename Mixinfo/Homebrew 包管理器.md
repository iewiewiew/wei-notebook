[TOC]

<h1 align="center">Homebrew 包管理器</h1>

> By：weimenghua
> Date：2023.06.30
> Description：

**参考资料**  
[Homebrew 官网](https://brew.sh/)  
[Homebrew 源码](https://github.com/Homebrew)



### Homebrew 简介
Homebrew formula 是Homebrew 包管理器的一种形式，它是一种简单的脚本或模板，用于在 Homebrew 中安装软件包。Homebrew formula 包含有关软件包的信息，例如软件包的名称、版本、来源、依赖关系和安装过程等。



### Homebrew 安装  
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

安装软件包
```
brew install <formula>
```


### Homebrew formula
Homebrew formula 的地址在 Homebrew 官方 GitHub 仓库中，官方仓库的地址是 https://github.com/Homebrew/homebrew-core。  
在 homebrew-core 仓库中，所有的 formula 文件都存储在 Formula 目录下。你可以使用以下命令在本地查看 Homebrew 的 formula：  
```
cd $(brew --repo)/Library/Taps/homebrew/homebrew-core/Formula/
ls
```