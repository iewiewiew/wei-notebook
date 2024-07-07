[TOC]

<h1 align="center">AI</h1>

> By：weimenghua  
> Date：2023.08.13  
> Description：AI 产品

**参考资料**  
- [awesome-mlops](https://github.com/kelvins/awesome-mlops)



## AI 技能

[鱼皮 - Vibe Coding 概念大全](https://github.com/liyupi/ai-guide/blob/main/Vibe%20Coding%20%E9%9B%B6%E5%9F%BA%E7%A1%80%E6%95%99%E7%A8%8B/70%20Vibe%20Coding%20%E6%A6%82%E5%BF%B5%E5%A4%A7%E5%85%A8.md)

### VibeCoding

VibeCoding（氛围编程、沉浸式编程）是一种基于上下文感知的AI编码方式，通过分析项目环境、文件结构和代码模式来生成高度相关的代码。它不是某个具体工具，而是一种开发理念/方法。   
简单来说就是用自然语言（人话）和AI对话，让AI实现编程。

Token 是 AI 模型处理文本的基本单位。你可以简单理解为 “词块”。



### AI 工作设置概览

| 组件           | 作用                               | 存储位置                                 |
| -------------- | ---------------------------------- | ---------------------------------------- |
| **Rules**      | 编码规范、项目约定、场景化行为约束 | `.cursor/rules/*.mdc`                    |
| **Skills**     | 可复用的复杂工作流                 | `~/.cursor/skills/` 或 `.cursor/skills/` |
| **MCP**        | 连接外部服务                       | `.cursor/mcp.json`                       |
| **User Rules** | 全局行为偏好                       | Cursor Settings → Rules                  |
| **CLAUDE.md**  | 项目级构建/测试/架构速查           | 项目根目录                               |



### AI Agent

人工智能代理(Artificial Intelligence Agent)，在LLM语境下，Agent 可以理解为某种能自主理解、规划决策、执行复杂任务的智能体。

**Agent = LLM+Planning+Feedback+Tool use**





### OpenClaw

[OpenClaw 官网](https://openclaw.ai/)   
[OpenClaw 中文帮助文档](https://docs.openclaw.ai/zh-CN/start/getting-started)  
[OpenClaw 接入智谱](https://docs.bigmodel.cn/cn/guide/develop/openclaw)  
[OpenClaw 接入阿里千问](https://chat.qwen.ai/authorize?user_code=NI5JCJB0&client=qwen-code)

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
- [每日 AI 快讯热闻](https://ai-bot.cn/daily-ai-news/)
- [AI 导航](https://www.ainavpro.com/)
- [AI 产品库](https://top.aibase.com/)
- [AI 指令](https://www.aishort.top/)

AI 对话聊天

- [ChatGPT](https://chat.openai.com/)
- [Poe](https://poe.com/)
- [geekgpt](https://chat1.geekgpt.org/)
- [百度文心一言](https://yiyan.baidu.com/)
- [阿里通义千问](https://tongyi.aliyun.com/)
- [Moonshot Kimi](https://kimi.moonshot.cn/)
- [Gemini](https://gemini.google.com/app)
- [Coze](https://www.coze.cn/home)
- [智谱](https://bigmodel.cn/)

AI 编程工具

- [GitHub Copilot](https://docs.github.com/zh/copilot/quickstart)
- [Cursor](https://cursor.sh/)
- [Windsurf](https://codeium.com/windsurf)
- [copilot.microsoft](https://copilot.microsoft.com/)  
- [Trae](https://www.trae.cn/ide/download)  [Teae官方知识库](https://lcnziv86vkx6.feishu.cn/wiki/GEEnwlfTQi8qZrkFsPycfkUKnul?fromScene=spaceOverview)
- [qoder](https://qoder.com/)
- [CodeBuddy](https://www.codebuddy.ai/)



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

## 创建智能体

例子：
名称：小程序经理（weapp-product-manager）
提示词：你是一位资深的微信小程序产品经理，拥有丰富的微信生态产品规划、用户体验设计和数据分析经验。你精通微信小程序的框架限制、审核规范、用户场景和商业变现模式，能够在微信生态的独特环境中创造优秀的产品体验。
何时调用：Use this agent when designing WeChat Mini Program features, defining user stories, planning release roadmaps, analyzing user behavior within mini programs, or coordinating cross-functional teams for mini program development. <example><context>The user needs to design a new feature for their WeChat Mini Program.</context>user: "我想为电商小程序设计一个会员积分系统，需要考虑用户体验和微信生态限制。" <commentary>Since this involves mini program feature design with WeChat ecosystem constraints.</commentary> assistant: "我将使用小程序经理来设计符合微信生态的会员积分系统。"</example> <example><context>The user wants to analyze mini program user data.</context>user: "我们的小程序用户留存率下降了，如何分析原因？" <commentary>Since this requires analyzing WeChat Mini Program user behavior and retention.</commentary> assistant: "让我使用小程序经理来分析你的小程序用户留存数据。"</example> <example><context>The user needs to plan a mini program development roadmap.</context>user: "我们需要制定下个季度的小程序功能开发计划，如何排优先级？" <commentary>Since this involves mini program roadmap planning and feature prioritization.</commentary> assistant: "我会用小程序经理来帮你制定符合业务目标的小程序开发路线图。"</example>




## 临时记录

安装 Claude Code
npm install -g @anthropic-ai/claude-code

查看版本
claude --version

替换为你的代理地址端口，注意是 7897 不是 7890
export HTTP_PROXY=http://127.0.0.1:7897
export HTTPS_PROXY=http://127.0.0.1:7897

在终端启用，首次登录需要跳转到登录页面
claude

Mac claude code 客户端如何添加 api key