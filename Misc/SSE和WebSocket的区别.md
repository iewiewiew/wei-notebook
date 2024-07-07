# SSE 和 WebSocket 的区别

**SSE**（Server-Sent Events，服务器发送事件）和 **WebSocket** 都是实现实时通信的技术，但设计理念和适用场景不同。

## 核心区别

| 维度 | SSE | WebSocket |
|------|-----|-----------|
| **通信方向** | 单向（服务器 → 客户端） | 双向（客户端 ↔ 服务器） |
| **协议** | 基于 HTTP（标准 HTTP 连接） | 独立协议（ws:// / wss://） |
| **传输格式** | 纯文本（必须是 UTF-8） | 文本或二进制 |
| **浏览器支持** | 原生 `EventSource` API | 原生 `WebSocket` API |
| **自动重连** | 内置支持 | 需要自行实现 |
| **消息顺序** | 保证顺序（基于文本流） | 顺序有保证，但可能被多路复用影响 |
| **连接数限制** | 每个域名 6 个（浏览器限制） | 无此限制 |
| **实现复杂度** | 简单（纯 HTTP 服务端） | 较复杂（需要握手升级协议） |

## SSE 的特点

**适用场景：**
- 实时推送通知
- 股票行情、价格更新
- 日志流
- 社交媒体信息流
- LLM 推理（如 GPT 的流式输出）

**优点：**
- 实现简单，使用标准 HTTP 协议
- 内置重连机制（`EventSource` 自动重连）
- 文本传输足够高效
- 通过标准 HTTP 代理和防火墙（无需额外配置）

**缺点：**
- 只能服务器推送，客户端不能发送数据
- 浏览器同域名限制 6 个 SSE 连接
- 不原生支持二进制数据

**示例（服务端 Node.js）：**
```js
// 服务端
res.writeHead(200, {
  'Content-Type': 'text/event-stream',
  'Cache-Control': 'no-cache',
  'Connection': 'keep-alive',
});
res.write(`data: ${JSON.stringify({ message: "hello" })}\n\n`);
```

## WebSocket 的特点

**适用场景：**
- 实时聊天/即时通讯
- 多人在线游戏
- 协同编辑（如 Google Docs）
- 实时白板/画布
- 需要双向频繁交互的应用

**优点：**
- 全双工通信，双向同时发送
- 支持二进制数据（Blob, ArrayBuffer）
- 低延迟（一次握手后，不需要 HTTP 头部开销）
- 无连接数限制

**缺点：**
- 实现复杂（需要处理握手协议、心跳、重连）
- 需要 WebSocket 服务器（如 `ws`、`Socket.IO`）
- 部分代理/防火墙可能拦截 `ws://`
- 没有内置重连

**示例（客户端）：**
```js
const ws = new WebSocket('wss://example.com/chat');
ws.onmessage = (event) => console.log(event.data);
ws.send(JSON.stringify({ type: 'message', data: 'hello' }));
```

## 做选择时的建议

| 如果你需要... | 选... |
|:---|:---|
| 服务器 → 客户端单向推送 | **SSE** |
| 客户端 → 服务器也需要发送数据 | **WebSocket** |
| 简单、快速实现 | **SSE** |
| 传输二进制数据 | **WebSocket** |
| 流式输出 LLM 推理结果 | **SSE**（OpenAI、Anthropic 都用这个） |
| 对延迟极其敏感的游戏 | **WebSocket** |
| 通过代理/防火墙工作 | **SSE** |

## 有趣的事实

许多"WebSocket"实现其实内部使用了 SSE 作为降级方案（如 `Socket.IO` 的 `xhr-polling` 模式）。而 LLM 的流式输出几乎都基于 SSE 实现——包括 OpenAI 的 `stream: true` 和 Anthropic 的 streaming API。