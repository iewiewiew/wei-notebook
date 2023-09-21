[TOC]

<h1 align="center">SVN 集中式版本控制系统</h1>

> By：weimenghua  
> Date：2023.09.25  
> Description：

**参考资料**  
[subversion 官网](https://subversion.apache.org/)  
[Gitee SVN支持](https://help.gitee.com/enterprise/code-manage/%E4%BB%A3%E7%A0%81%E6%89%98%E7%AE%A1/%E4%BB%A3%E7%A0%81%E4%BB%93%E5%BA%93/Gitee%20SVN%E6%94%AF%E6%8C%81)



安装 SVN：`brew install subversion`

使用 SVN
```

svnadmin create svn-demo

获取仓库代码
svn checkout --username <username> --password <password> <repository_url>
svn checkout <repository_url>
<repository_url> 有两种方式
svn://gitee.com/iewiewiew/wei-demo-001
svn+ssh://gitee.com/iewiewiew/wei-demo-001

# 需要密码
svn checkout svn://gitee.com/iewiewiew/wei-demo-001

# 通过 SSH 免密登录
svn checkout svn://gitee.com/iewiewiew/wei-demo-001

echo "test" > SVNReadMe.md

#svn add SVNReadMe.md
#svn add * --force类似于git add -A
svn add * --force

更新工作副本
svn update .

提交修改，等于 git push
svn commit -m "first svn commit"

查看本地工作目录信息
svn info

查看修改历史
svn log

列出版本库中的目录内容
svn list svn://gitee.com/iewiewiew/wei-demo-001

导出仓库指定分支的所有文件，不含版本控制信息：
svn export svn://gitee.com/iewiewiew/wei-demo-001 wei-demo-001
```

存储svn信息：`/Users/menghuawei/.subversion`  
密码缓存：`/Users/menghuawei/.subversion/auth/svn.simple`
