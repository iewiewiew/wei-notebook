[TOC]

<h1 align="center">如何实现 Token 中转站</h1>

> By：weimenghua  
> Date：2026.11.14  
> Description：API 网关形态的模型调用转售服务，核心是统一入口、协议适配、多上游调度与计量计费



## 本质定位

中转站是 LLM API 网关：对外暴露 OpenAI 兼容端点，对内聚合多上游，统一完成鉴权、协议适配、调度与计费。



## 整体架构

```
Client
  │  HTTPS / SSE
  ▼
接入层 ── 鉴权 ── 配额限流
  │
  ▼
协议适配（请求映射）
  │
  ▼
路由调度 ──► 上游密钥池 ──► Provider API
  ▲                              │
  └──── 协议适配（响应映射）◄─────┘
  │
  └──► 计量计费（异步落账）
```



## 核心模块

### 接入层

- TLS 终止、HTTP/2、SSE 长连接
- 签发自有 Key（`sk-xxx`），仅存哈希，调用时校验
- 限流维度：RPM、TPM、并发信号量、单 Key 余额

### 协议适配

请求侧：

- `system` 位置差异：OpenAI 置于 messages，Anthropic 为顶层字段
- `max_tokens` 的必填性与默认值不同
- `tools`、`tool_choice`、`response_format` 能力差异，不支持项需降级剥离

响应侧：

- 统一为 OpenAI 结构，或按端点决定输出格式
- 流式 `delta` 字段逐块映射
- 上游错误码归一化为统一错误体

### 上游调度

- 密钥池：多 Provider、多账号、多 Key
- 策略：加权轮询、最少在途、按会话亲和
- 故障：429 冷却、5xx 换 Key 重试、连续失败熔断
- 亲和性约束：要命中上游 prompt cache，同一前缀必须固定在同一账号

### 流式转发

- 逐块解析 `data: {...}`，边转边发，不可缓冲
- 终止标记 `[DONE]`
- 用量在末块；OpenAI 需请求携带 `stream_options.include_usage`

### 计量计费

- 优先读上游 `usage`，缺失时用本地 tokenizer 估算
- 预扣 + 结算：按 `max_tokens` 冻结额度，结束后按实际用量退差
- 扣减原子性：Redis Lua 脚本或 `INCRBYFLOAT`
- 账本为不可变流水，便于对账与退款

### 缓存

- 精确匹配：`hash(model + messages + params)`
- 透传上游 prompt cache（Anthropic `cache_control`、OpenAI 自动）
- 语义缓存：向量近邻 + 阈值，存在答错风险

### 可观测

- 指标：QPS、首字延迟、端到端延迟分位、错误率、单位成本
- 日志需脱敏或提供关闭开关，网关可见全部 prompt



## 数据模型

| 表 | 关键字段 |
|---|---|
| api_key | id, key_hash, user_id, quota, status |
| upstream_account | id, provider, credential, weight, status, cooldown_until |
| ledger | id, key_id, request_id, model, prompt_tokens, completion_tokens, cost, created_at |



## 最小实现

- 接入与转发：Nginx / OpenResty 或 Go 单服务
- 计数与限流：Redis
- Key、账号、账本：PostgreSQL
- 单机起步即可，瓶颈在协议适配而非并发



## 现成方案：new-api

one-api 的活跃分支，Go（Gin + GORM）实现，可直接作为基座二次开发。

- 渠道管理：一个上游账号为一个渠道，覆盖 OpenAI、Anthropic、Gemini、Azure、DeepSeek 等
- 令牌分发：签发自有 Key，支持额度、过期时间、模型白名单
- 调度：多渠道路由，支持加权随机与失败重试
- 计费：按分组倍率与模型单价扣额度，记录调用日志
- 部署：Docker 单容器，数据库可选 SQLite / MySQL，Redis 非必需

```bash
docker run -d --name new-api -p 3000:3000 -v /data/new-api:/data calciumion/new-api:latest
```

二次开发通常改三处：协议适配层、计费策略、路由调度。



## 关键难点

1. 流式与计费一致性：用量后置返回，需预扣与异步结算配合
2. 协议语义不等价：工具调用、多模态、结构化输出需按 Provider 维护能力矩阵
3. 并发超卖：冻结与扣减必须原子
4. 缓存亲和与负载均衡冲突：需按会话哈希路由



## 合规与风险

- 转售通常违反上游服务条款，账号封禁为常态
- 网关侧可见完整 prompt，敏感数据等同明文
- 预付余额无监管保障
