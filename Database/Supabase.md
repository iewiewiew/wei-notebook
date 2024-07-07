[TOC]

<h1 align="center">Supabase</h1>

> By：weimenghua  
> Date：2026.05.21  
> Description：



## Supabase 简介

[Supabase 官网](https://supabase.com/)

Supabase = 开源 PostgreSQL + 自动 API + 认证 + 实时 + 存储 + 边缘函数 + AI 向量，是现代全栈开发的高效 “后端瑞士军刀”，兼顾速度、开源、SQL 强大、无锁定四大核心价值。

一句话总结：PostgreSQL 是底层数据库，Supabase 是基于 PostgreSQL 封装的一站式后端平台。



## 操作远端数据库

```
npx supabase db --help
npx supabase db query --help

先登录 Supabase 账号
npx supabase login

初始化（只运行一次）
npx supabase init

链接云端数据库
示例：supabase link --project-ref 项目ID

执行命令（有效）
示例：psql "your_connection_string"
```
