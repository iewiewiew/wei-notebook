[TOC]

<h1 align="center">AI</h1>

> By：weimenghua  
> Date：2023.08.13  
> Description：

**参考资料**  
- [awesome-mlops](https://github.com/kelvins/awesome-mlops)
- [鱼皮 - Vibe Coding 概念大全](https://github.com/liyupi/ai-guide/blob/main/Vibe%20Coding%20%E9%9B%B6%E5%9F%BA%E7%A1%80%E6%95%99%E7%A8%8B/70%20Vibe%20Coding%20%E6%A6%82%E5%BF%B5%E5%A4%A7%E5%85%A8.md)
- [Agent-Learning-Hub](https://github.com/datawhalechina/Agent-Learning-Hub)



## VibeCoding

VibeCoding（氛围编程、沉浸式编程）是一种基于上下文感知的AI编码方式，通过分析项目环境、文件结构和代码模式来生成高度相关的代码。它不是某个具体工具，而是一种开发理念/方法。   
简单来说就是用自然语言（人话）和AI对话，让AI实现编程。

Token 是 AI 模型处理文本的基本单位/计费的基本单位。可以简单理解为 “词元”。



## AI Agent

人工智能代理(Artificial Intelligence Agent)，在LLM语境下，Agent 可以理解为某种能自主理解、规划决策、执行复杂任务的智能体。

Agent = LLM+Planning+Feedback+Tool use



## AI 工作设置概览

| 组件             | 作用                | 存储位置                                    |
| -------------- | ----------------- | --------------------------------------- |
| **Rules**      | 编码规范、项目约定、场景化行为约束 | `.cursor/rules/*.mdc`                   |
| **Skills**     | 可复用的复杂工作流         | `~/.cursor/skills/` 或 `.cursor/skills/` 或 `~/.agents/skills/` |
| **MCP**        | 连接外部服务            | `.cursor/mcp.json`                      |
| **User Rules** | 全局行为偏好            | Cursor Settings → Rules                 |
| **CLAUDE.md**  | 项目级构建/测试/架构速查     | 项目根目录                                   |



## OpenClaw

[OpenClaw 官网](https://openclaw.ai/)   
[OpenClaw 中文帮助文档](https://docs.openclaw.ai/zh-CN/start/getting-started)  
[OpenClaw 接入智谱](https://docs.bigmodel.cn/cn/guide/develop/openclaw)  

方式一：一键安装  
curl -fsSL https://openclaw.ai/install.sh | bash

方式二：npm 全局安装
npm install -g openclaw@latest

运行配置向导  
openclaw onboard --install-daemon

重新配置
openclaw config

启动 Gateway 网关
openclaw gateway --port 18789

修改配置  
/root/.openclaw/openclaw.json

建立安全隧道
ssh -N -L 18789:127.0.0.1:18789 root@127.0.0.1

浏览器打开 Dashboard
openclaw dashboard

浏览器打开 Dashboard（推荐）
openclaw dashboard --no-open

访问 URL
http://127.0.0.1:18789/#token=3b906df8a8ba1f0df6f52f821287a37a38fcd1e594db23e0

本地访问
http://127.0.0.1:18789

OpenClaw 接入飞书流程

1. 创建应用并添加机器人：登录[飞书开放平台](https://open.feishu.cn/)，进入“开发者后台”。点击“创建企业自建应用”，填写应用名称（例如“我的OpenClaw助手”）后完成创建。创建成功后，在应用详情页左侧导航栏找到“添加应用能力”，为你的应用添加机器人功能。
2. 获取应用凭证：App ID：123、App Secret：456



##  AI 产品网址

模型托管

- [HuggingFace](https://huggingface.co/)
- [GiteeAI](https://ai.gitee.com/)
- [魔搭社区](https://www.modelscope.cn/home)
- [昇思大模型平台](https://xihe.mindspore.cn/)
- [百度千帆](https://cloud.baidu.com/product/wenxinworkshop)
- [始智模型](https://wisemodel.cn/models)

AI 工具集

- [AI 工具集](https://ai-bot.cn/)
- [AI 产品库](https://top.aibase.com/)
- [AI 指令](https://www.aishort.top/)

AI 对话聊天

- [ChatGPT](https://chat.openai.com/)
- [Poe](https://poe.com/)
- [百度文心一言](https://yiyan.baidu.com/)
- [阿里通义千问](https://tongyi.aliyun.com/)
- [Moonshot Kimi](https://kimi.moonshot.cn/)
- [Gemini](https://gemini.google.com/app)
- [Coze](https://www.coze.cn/home)
- [智谱](https://bigmodel.cn/)

AI 编程工具

- [GitHub Copilot](https://docs.github.com/zh/copilot/quickstart)
- [Claude Code](https://platform.claude.com/)  
- [Cursor](https://cursor.sh/)
- [Codex](https://openai.com/zh-Hans-CN/codex/)
- [字节 Trae](https://www.trae.cn/ide/download)  [Teae官方知识库](https://lcnziv86vkx6.feishu.cn/wiki/GEEnwlfTQi8qZrkFsPycfkUKnul?fromScene=spaceOverview)
- [阿里 Qoder](https://qoder.com/)
- [腾讯 CodeBuddy](https://www.codebuddy.cn/)
- [腾讯 WorkBuddy](https://www.workbuddy.cn/)

其它



## 技术集合

### 特征工程

特征工程是指在机器学习和数据分析任务中，对原始数据进行转换、提取和选择，以创建更有信息量和预测能力的特征集合的过程。

特征工程的目的是通过对数据进行适当的预处理和特征构建，使得机器学习算法能够更好地理解数据并提取出相关的模式和信息。好的特征工程可以帮助提高模型的性能、降低过拟合的风险，并提供更好的解释性。

特征工程的步骤通常包括以下几个方面：

- 数据清洗：处理缺失值、异常值、重复值和噪声等问题，确保数据的质量和一致性。
- 特征转换：对原始数据进行转换，使其符合模型的假设或要求。常见的转换包括对数变换、标准化、归一化和离散化等。
- 特征构建：根据领域知识和数据的特点，通过组合、衍生或交互等方式创建新的特征。这可以帮助模型更好地捕捉数据中的非线性关系和交互效应。
- 特征选择：从原始特征中选择最相关和最具有预测能力的特征，以减少维度和冗余，并提高模型的泛化能力。常用的特征选择方法包括统计方法、正则化和基于模型的方法等。
- 特征缩放：对特征进行缩放，使其具有相似的尺度和范围，以便模型能够更稳定地学习和进行预测。常见的缩放方法包括标准化和归一化。


## LangChain

LangChain 是一个用于开发大语言模型（LLM）应用的开源框架。 它本身不是模型，也不是模型服务，而是一层「编排层」（orchestration layer）：把 LLM 与外部数据、工具、记忆、流程控制连接起来，让「调用一次 API 得到一段文本」升级为可用的应用。  
LangChain 是 LLM 应用的「标准件库 + 编排框架」，用统一抽象把模型、提示词、数据检索、工具调用和流程控制组装成完整应用；它擅长快速搭建和生态集成，代价是抽象层较厚——适合中等以上复杂度、需要多组件协作的场景。



## 知识碎片

研究一下 Codex + GPT-Image-2 生成图片
可以在 https://chatgpt.com/ 生成图片

图像生成模型
- GPT Image 2
- Nano Banana pro
- Seedream



使用飞书 CLI

```
# 安装cli本体
npm install -g @larksuite/cli

# 安装AI‑Agent技能（给Cursor/Claude‑Code调用飞书用）
npx skills add larksuite/cli -y -g

# 校验安装成功
lark-cli --version

# 更新版本
lark-cli update

# 卸载
npm uninstall -g @larksuite/cli

# 初始化配置
lark-cli config init

# 最简权限模式（日常个人账号）
lark-cli auth login --recommend

# 直接写入markdown正文
lark-cli docs +create \
--title "CLI创建的测试文档" \
--doc-format markdown \
--content "# 标题1\n- 条目1\n- 条目2"

```


AI 智能体专用 CLI cursor-agent

curl https://cursor.com/install -fsS | bash


```
# 交互式对话（进入AI终端）
cursor-agent

# 一次性执行指令（非交互，适合脚本）
cursor-agent "你是什么模型？"

# 指定模型、无交互输出
cursor-agent --model gpt-5.5 --print "你是什么模型？"

# 登录账号（浏览器授权）
cursor-agent login
```



## AI 发展之路

2022 年 11 月 ChatGPT 上线，引爆大家对 AI 的认知，一时之间大家都去买账号来使用，2023 年模型托管 HuggingFace 开始爆发，此时 Gitee 开始也开始做模型托管。2023 没啥印象，2024 年 MCP 发布、2025 年各家推出 Computer Use / 浏览器 Agent / Claude Code / Codex CLI，Agent 从 demo 变成能干活的东西。2025 年才是 Agent 的实用爆发年。2026 年，AI 颠覆了软件行业。