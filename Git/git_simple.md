# Git 代码管理常用命令

## 基础配置

### 用户信息配置
```bash
# 设置用户名
git config --global user.name "Your Name"

# 设置邮箱
git config --global user.email "your.email@example.com"

# 查看配置
git config --list

# 查看特定配置
git config user.name
```

### 初始化仓库
```bash
# 初始化本地仓库
git init

# 克隆远程仓库
git clone <repository_url>

# 克隆指定分支
git clone -b <branch_name> <repository_url>
```

## 文件操作

### 添加文件
```bash
# 添加单个文件
git add <file_name>

# 添加所有文件
git add .

# 添加指定类型的文件
git add *.js

# 交互式添加
git add -i
```

### 提交更改
```bash
# 提交更改（需要先 add）
git commit -m "commit message"

# 提交所有更改（包括已跟踪的文件）
git commit -am "commit message"

# 修改最后一次提交
git commit --amend

# 修改最后一次提交信息
git commit --amend -m "new commit message"
```

### 查看状态
```bash
# 查看工作区状态
git status

# 查看简短状态
git status -s

# 查看文件差异
git diff

# 查看已暂存的差异
git diff --cached

# 查看提交历史
git log

# 查看简洁的提交历史
git log --oneline

# 查看图形化提交历史
git log --graph --oneline --all
```

## 分支管理

### 查看分支
```bash
# 查看本地分支
git branch

# 查看所有分支（包括远程）
git branch -a

# 查看远程分支
git branch -r
```

### 创建和切换分支
```bash
# 创建新分支
git branch <branch_name>

# 创建并切换到新分支
git checkout -b <branch_name>

# 切换到分支（新版本 Git）
git switch <branch_name>

# 创建并切换到新分支（新版本 Git）
git switch -c <branch_name>

# 切换到上一个分支
git checkout -
```

### 删除分支
```bash
# 删除本地分支
git branch -d <branch_name>

# 强制删除本地分支
git branch -D <branch_name>

# 删除远程分支
git push origin --delete <branch_name>
```

### 合并分支
```bash
# 合并分支到当前分支
git merge <branch_name>

# 合并时禁用快进模式
git merge --no-ff <branch_name>

# 取消合并
git merge --abort
```

## 远程仓库

### 查看远程仓库
```bash
# 查看远程仓库
git remote

# 查看远程仓库详细信息
git remote -v

# 查看远程仓库详细信息
git remote show origin
```

### 添加和删除远程仓库
```bash
# 添加远程仓库
git remote add <remote_name> <repository_url>

# 删除远程仓库
git remote remove <remote_name>

# 修改远程仓库 URL
git remote set-url <remote_name> <new_url>
```

### 推送和拉取
```bash
# 推送到远程仓库
git push <remote_name> <branch_name>

# 推送到远程仓库（设置上游）
git push -u <remote_name> <branch_name>

# 拉取远程更改
git pull <remote_name> <branch_name>

# 获取远程更改（不合并）
git fetch <remote_name>

# 获取所有远程更改
git fetch --all
```

## 撤销操作

### 撤销工作区更改
```bash
# 撤销工作区更改
git checkout -- <file_name>

# 撤销所有工作区更改
git checkout -- .

# 使用 restore（新版本 Git）
git restore <file_name>
```

### 撤销暂存区
```bash
# 撤销暂存区（文件回到工作区）
git reset HEAD <file_name>

# 撤销所有暂存区
git reset HEAD .

# 使用 restore（新版本 Git）
git restore --staged <file_name>
```

### 撤销提交
```bash
# 撤销最后一次提交（保留更改）
git reset --soft HEAD~1

# 撤销最后一次提交（不保留更改）
git reset --hard HEAD~1

# 撤销到指定提交
git reset --hard <commit_id>
```

## 标签管理

### 创建标签
```bash
# 创建轻量标签
git tag <tag_name>

# 创建附注标签
git tag -a <tag_name> -m "tag message"

# 在指定提交创建标签
git tag -a <tag_name> <commit_id>
```

### 查看和删除标签
```bash
# 查看标签列表
git tag

# 查看标签详细信息
git show <tag_name>

# 删除本地标签
git tag -d <tag_name>

# 删除远程标签
git push origin --delete <tag_name>
```

### 推送标签
```bash
# 推送指定标签
git push origin <tag_name>

# 推送所有标签
git push origin --tags
```

## 储藏（Stash）

### 储藏更改
```bash
# 储藏当前更改
git stash

# 储藏并添加描述
git stash save "stash message"

# 查看储藏列表
git stash list

# 应用储藏
git stash apply

# 应用并删除储藏
git stash pop

# 删除储藏
git stash drop

# 清空所有储藏
git stash clear
```

## 高级操作

### 查看文件历史
```bash
# 查看文件提交历史
git log <file_name>

# 查看文件的修改记录
git blame <file_name>

# 查看文件的每一行最后一次修改
git log -p <file_name>
```

### 比较差异
```bash
# 比较工作区和暂存区
git diff

# 比较暂存区和仓库
git diff --cached

# 比较两个分支
git diff <branch1> <branch2>

# 比较两个提交
git diff <commit1> <commit2>
```

### 搜索
```bash
# 搜索提交信息
git log --grep="search term"

# 搜索代码内容
git log -S "search term"

# 搜索文件内容
git grep "search term"
```

## 常用技巧

### 忽略文件
创建 `.gitignore` 文件来忽略不需要版本控制的文件：
```
# 忽略所有 .log 文件
*.log

# 忽略 node_modules 目录
node_modules/

# 忽略所有 .env 文件
.env
```

### 子模块
```bash
# 添加子模块
git submodule add <repository_url> <path>

# 初始化子模块
git submodule init

# 更新子模块
git submodule update

# 更新所有子模块
git submodule update --init --recursive
```

### 重写历史
```bash
# 交互式 rebase
git rebase -i HEAD~3

# 修改提交信息
git rebase -i HEAD~3
# 在编辑器中将要修改的提交前的 'pick' 改为 'edit'
# 然后执行: git commit --amend
# 最后执行: git rebase --continue
```

