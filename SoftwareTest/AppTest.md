[TOC]

<h1 align="center">AppTest</h1>

> By: weimenghua  
> Date: 2024.03.04  
> Description: App 测试  

## App 测试范围

1. 功能模块的测试

2. 交叉事件测试

- 运行时接收来电
- 运行时接收短信
- 运行时接收推送
- 运行时系统弹窗信息
- 运行时切换外部设备

3. 客户端性能测试

- CPU占用
- 内存占用
- 界面流畅度
- 流量消耗
- 电量消耗
- 启动时间

4. 服务端性能测试

- LoadRunner
- JMeter

5. 安全测试

6. 接口测试

7. 网络测试

8. 安装卸载测试

- 安装渠道
- 系统版本
- 安装方式
- 卸载方式
- 升级方式

9. 兼容性测试

- 设备型号
- 系统版本
- 屏幕尺寸
- 屏幕分辨率
- 网络类型
- 软硬件兼容性

10. 推送消息测试

- 推送消息的实现方式
- 推送消息服务端设置
- 推送消息客户端设置

11. 用户体验测试

- 界面测试
- 功能易用性测试
- 横竖屏切换
- 系统功能响应

12. 稳定性测试

- Monkey
- UICrawler
- Maxin

## App 包结构

android工程编译完成会得到我们想要的apk安装包，apk文件其实是一个压缩包，所以可以直接修改后缀名为zip或rar后能直接解压打开。

1. AndroidManifest.xml：Android主配置文件，每个应用都必须定义和包含的，它描述了应用的名字、版本、权限、引用的库文件等信息，编译过程中由文本格式转化为二进制AXML文件格式。
2. Assets文件夹：保存一些额外的资源文件，如游戏的声音文件，字体文件等等，在代码中可以用AssetManager获取assets文件夹的资源。
3. Lib文件夹：存放用C/C++编写的，用NDK编译生成的so文件，供java端调用。
4. Classes.dex：java代码编译后产生的一种类似字节码的文件，可以直接在Dalvik虚拟机上加载运行的文件，由java文件经过IDE编译生成。
5. META-INF/文件夹：存放apk签名信息，用来保证apk包的完整性和系统的安全。
6. res文件夹：资源文件，包括icon，xml文件，其中的.xml文件，在编译过程中由文本格式转化为二进制AXML文件格式。
7. Samli文件：一种类似汇编语言的文件，但比汇编简单许多，反编译classes.dex文件，就可以得到以smali为后缀的文件。

## App 打包

1. 打包平台
[蒲公英](https://www.pgyer.com/user/login)
[fir](https://www.betaqr.com/)

2. app 打包命令
[flutter官网](https://flutterchina.club/using-packages/)

```text
flutter packages get

pod install
```

当我们新建一个Podfile文件运行后，会自动生成一个Podfile.lock文件，Podfile.lock文件里存储着我们已经安装的依赖库(pods)的版本。
当我们第一次运行Podfile时，如果对依赖库不指定版本的话，cocoapods会安装最新的版本，同时将pods的版本记录在Podfile.lock文件中。
这个文件会保持对每个pod已安装版本的跟踪，并且锁定这些版本。再执行pod install的话，只会处理没有记录在Podfile.lock中的依赖库，会查找匹配Podfile中描述的版本。
对于已经记录在Podfile.lock的依赖库，会下载Podfile.lock文件中记录的版本，而不会检查是否有更新。
当然，如果你约束了pods的版本的话，会按照你指定的版本进行安装，同时也会更新Podfile.lock记录的信息。
pod install使用场景:

1. 新创建工程. 第一次引入pod库时。
2. 修改了Podfile文件，添加或删除了所依赖的pod库时。
3. 团队中新人拉取工程后获取pod库时。
4. 团队中. 不同开发者要同步对pod库的依赖时。
4.1. 有人改变了依赖关系，删除或增加pod时。
4.2. 有人执行了pod update,此时他的Podfile.lock文件中的跟踪版本就已经变更，此时，其他人只要pod install就能更新为和Podfile.lock文件中的版本。
4.3. 如果Podfile和Podfile.lock的记录相冲突，Podfile文件中指定了低于Podfile.lock中记录的版本。会以Podfile文件为准，并在获取成功后更新Podfile.lock文件。

## App 二次打包

二次打包概念：对已经进行过加密编译发布的apk文件，进行自己的修改之后，再次签名打包发布的过程称为二次打包。
二次打包能做什么：对移动应用进行破解、再篡改或插入恶意代码、最后生成一个新应用的过程。通常不法分子更为青睐市面上下载量最火爆的APP进行二次打包，这些APP拥有大量的用户集群，通过插入广告、木马、病毒的方式窃取用户隐私、吸资扣费、耗费流量成功的可能性大。像保卫萝卜、植物大战僵尸等曾经火爆的APP，都无一例外地遭遇过"二次打包"。一旦安装了"二次打包"的软件，手机用户就会遭遇频繁的广告骚扰和流量损失。

检测是否可二次打包方法：
利用二次打包工具对APP进行二次打包，看APP能否成功打包运行，如果重新打包后无法运行程序说明有防二次打包安全措施。
百度下载AndroidKiller二次打包工具，下载完成后解压打开AndroidKiller.exe应用程序，并将xxx.apk拖入到AndroidKiller界面中，会进行反编译。
Android Killer是一款可以对APK进行反编译的工具，它能够对反编译后的Smali文件进行修改，并将修改后的文件进行打包。

修复方法：
采用签名的方法进行保护。建议客户端使用从属方证书进行签名后进行发布而不是使用第三方开发商的证书进行签名，以防开发商内部监管异常，证书滥用的情况出现。

## App 马甲包

App马甲包意思就是利用各大应用市场规则漏洞，通过技术手段，多次上架同一款产品的方法。马甲包和主产品包拥有同样的内容和功能，除了icon和应用名称不能完全一致，其他基本都是一样的。那么开发者为什么要做马甲包呢？主要来说有以下两个原因：

1. 获取客户，增加关键词覆盖量.马甲包可以有效的进行拉新引流。另外一方面是增加关键词的覆盖量，众所周知，单个App只能在后台填写100个字符的关键词，每多一个App就意味着可以再填100字符的关键词，从而达到增加关键词覆盖量的目的。
2. 抵抗风险。第二个好处，就是让自己的这款产品有更高的风险承受能力，任何一款产品都会不断更新，增添新的内容、功能。如果我们直接在主包上更新，一旦新功能不被用户接受那就损失大了，我们前期大量投资带来的用户将会流失，这对很多产品开发者来说是不可承受之痛。这时候使用马甲包，则可以随意测试新功能，好的功能就在主包上迭代，不好的也无所谓，所以马甲包就承担了“背锅”的角色。更有甚者，如果某些功能不小心触犯了“规定”，导致主包被下架，马甲包也可以承担挽回流量损失的重任。

## 反编译工具

### 1. AXMLPrinter2.jar

下载静态分析工具之-AXMLPrinter2.jar，进入cmd（AXMLPrinter2.jar所在路径）  

1. 执行：java  -jar AXMLPrinter2.jar AndroidManifest.xml>AndroidManifest.txt （注：可将需要解析的xml放到和jar同级目录下）
2. 执行：java -jar AXMLPrinter2.jar AndroidManifest.xml

### 2. dex2jar

dex2jar 作用：将 apk 反编译成 java 源码（classes.dex转化成jar文件）  
下载dex2jar：<http://soft.onlinedown.net/soft/989451.htm>  |  <https://sourceforge.net/projects/dex2jar/>  
进入cmd（d2j-dex2jar.bat 所在路径）  
执行：d2j-dex2jar.bat classes.dex，得到classes-dex2jar.jar （强制覆盖：d2j-dex2jar.bat classes.dex --force）  
执行（绝对路径）：/dex2jar-2.0/dex2jar-2.0/d2j-dex2jar.bat  /dex2jar-2.0/classes.dex

### 3. 通过jd-gui查看classes-dex2jar.jar

下载地址：<https://java-decompiler.github.io/>
把classes-dex2jar.jar放到jd-gui，即可编译出源代码
