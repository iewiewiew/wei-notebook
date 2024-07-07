[TOC]

<h1 align="center">AI</h1>

> By：weimenghua  
> Date：2023.08.13  
> Description：AI 产品

**参考资料**  
- [awesome-mlops](https://github.com/kelvins/awesome-mlops)
- [Huggingface 官网](https://huggingface.co/)
- [Huggingface github](https://github.com/huggingface)
- [HuggingFace 在线教程](https://huggingface.co/learn/nlp-course/chapter1/1)

  


## 语言模型

GPT 的实现原理

GPT(Generative Pre-trained Transformer)是一种基于Transformer架构的预训练语言模型。下面是GPT的主要实现原理：

1. **Transformer架构：** GPT基于Transformer模型，该模型由Vaswani等人于2017年提出。Transformer使用了注意力机制，可以在输入序列中捕捉全局依赖关系，而无需依赖循环神经网络(RNN)或卷积神经网络(CNN)。它包括编码器和解码器，但在GPT中主要使用了编码器部分。
2. **自注意力机制(Self-Attention)：** 这是Transformer的关键组件。自注意力机制允许模型在处理输入序列时关注输入中的不同位置，而不是像传统的固定窗口大小的滑动窗口一样。这有助于捕捉长距离的依赖关系。
3. **多头注意力(Multi-Head Attention)：** 为了增加模型的表达能力，多头注意力允许模型使用多个注意力头来学习不同的关注权重。
4. **位置编码：** 由于Transformer没有固有的序列顺序概念，位置编码被引入以为模型提供关于单词在序列中位置的信息。
5. **层标准化(Layer Normalization)：** 在每个子层输出后应用层标准化，有助于训练过程的稳定性。
6. **预训练和微调：** GPT是一个预训练语言模型。在预训练阶段，模型通过大规模的文本语料库学习语言的统计结构。在微调阶段，模型根据特定任务的标注数据进行微调，以适应具体应用领域的需求。
7. **层级结构：** GPT采用了多层的Transformer结构，通常包括数十甚至数百个Transformer层，使得模型可以学习复杂的语言表示。
8. **掩码机制：** 在预训练中，为了确保模型只能依赖之前的词来预测下一个词，使用了遮蔽机制，即将未来的词掩盖掉。
9. **位置嵌入：** 在输入词嵌入中加入位置嵌入，以区分不同位置的词。

总体而言，GPT通过Transformer的结构和预训练的方式，使得模型能够捕捉自然语言中的复杂语法和语义关系。这种通用的预训练框架使得GPT在各种自然语言处理任务中取得了良好的性能。

ChatGPT 是 OpenAI 公司推出的聊天机器人模型，**Chat**是聊天，GPT的全称：**“GenerativePre-trainedTransformer”**，翻译为中文为**“生成型预训练变换模型”**。



## 特征工程

特征工程是指在机器学习和数据分析任务中，对原始数据进行转换、提取和选择，以创建更有信息量和预测能力的特征集合的过程。

特征工程的目的是通过对数据进行适当的预处理和特征构建，使得机器学习算法能够更好地理解数据并提取出相关的模式和信息。好的特征工程可以帮助提高模型的性能、降低过拟合的风险，并提供更好的解释性。

特征工程的步骤通常包括以下几个方面：
- 数据清洗：处理缺失值、异常值、重复值和噪声等问题，确保数据的质量和一致性。
- 特征转换：对原始数据进行转换，使其符合模型的假设或要求。常见的转换包括对数变换、标准化、归一化和离散化等。
- 特征构建：根据领域知识和数据的特点，通过组合、衍生或交互等方式创建新的特征。这可以帮助模型更好地捕捉数据中的非线性关系和交互效应。
- 特征选择：从原始特征中选择最相关和最具有预测能力的特征，以减少维度和冗余，并提高模型的泛化能力。常用的特征选择方法包括统计方法、正则化和基于模型的方法等。
- 特征缩放：对特征进行缩放，使其具有相似的尺度和范围，以便模型能够更稳定地学习和进行预测。常见的缩放方法包括标准化和归一化。



## 知识碎片

###  AI 产品网址

模型托管

- [HuggingFace](https://huggingface.co/)
- [GiteeAI](https://ai.gitee.com/)
- [魔搭社区](https://www.modelscope.cn/home)
- [昇思大模型平台](https://xihe.mindspore.cn/)
- [百度千帆](https://cloud.baidu.com/product/wenxinworkshop)
- [始智模型](https://wisemodel.cn/models)
- [OpenCSG](https://portal.opencsg.com/models)
- [TensorFlow Hub](https://tfhub.dev/)
- [Kaggle](https://www.kaggle.com/)
- [Swanhub](https://swanhub.co/)
- [Replicate](https://replicate.com/)

AI 工具集

- [AI 工具集](https://ai-bot.cn/)
- [每日 AI 快讯热闻](https://ai-bot.cn/daily-ai-news/)
- [AI 导航](https://www.ainavpro.com/)
- [AI 产品库](https://top.aibase.com/)
- [AI 指令](https://www.aishort.top/)

AI 对话聊天

- [ChatGPT](https://chat.openai.com/)
- [GPTStore](https://gptstore.ai/)
- [Poe](https://poe.com/)
- [geekgpt](https://chat1.geekgpt.org/)
- [百度文心一言](https://yiyan.baidu.com/)
- [阿里通义千问](https://tongyi.aliyun.com/)
- [Moonshot Kimi](https://kimi.moonshot.cn/)
- [Gemini](https://gemini.google.com/app)
- [Coze](https://www.coze.cn/home)

AI 编程工具

- [GitHub Copilot](https://docs.github.com/zh/copilot/quickstart)
- [Cursor](https://cursor.sh/)
- [copilot.microsoft](https://copilot.microsoft.com/)

AI 搜素引擎

- [新一代 AI 搜索引擎](https://devv.ai/)

其它

- [MidJourney](https://www.midjourney.com/)，需要先注册 [Discord](https://discord.com/)，[MidJourney 官方使用手册](https://midjourney.gitbook.io/docs/)
- [Perplexity](https://www.perplexity.ai/)
- [Pika](https://pika.art/waitlist)
- [DreamStudio](https://beta.dreamstudio.ai/generate)
- [Prompt](https://www.promptingguide.ai/zh)
- [sora](https://openai.com/sora)
- ChatGPT插件：Sider、Glarity

### AI Agent

人工智能代理(Artificial Intelligence Agent)，在LLM语境下，Agent 可以理解为某种能自主理解、规划决策、执行复杂任务的智能体。

**Agent = LLM+Planning+Feedback+Tool use**

### 临时记录

[AI 编程助手 Windsurf](https://codeium.com/windsurf)

[AI UI 界面](https://cherry-ai.com/download)

Vibe Coding（氛围编程、沉浸式编程）
