### 直接把 Codex 接进 Antigravity

这是最省事、最像你要的。

#### 第一步：先在本机确认 Codex MCP 能启动

```
codex mcp-server
```

或者按 OpenAI 的示例，用 `npx` 起：

```
npx -y codex mcp-server
```

OpenAI 官方给的 Agents SDK 示例就是这么起的。

#### 第二步：把它加到 Antigravity 的 MCP 配置

Antigravity 官方写的是：

- 进 **Manage MCP Servers**
- 点 **View raw config**
- 改 `mcp_config.json`
- 配置文件位置在 `~/.gemini/antigravity/mcp_config.json`。

你可以先按这种本地 stdio 方式配：

```
{
  "mcpServers": {
    "codex-local": {
      "command": "npx",
      "args": ["-y", "codex", "mcp-server"]
    }
  }
}
```

如果你本机已经全局装好了，也可以试：

```
{
  "mcpServers": {
    "codex-local": {
      "command": "codex",
      "args": ["mcp-server"]
    }
  }
}
```

然后回 Antigravity 刷新 MCP。

------

## 这样接上以后，Antigravity 能怎么调

Codex MCP 官方暴露的是这两个核心工具：

- `codex(prompt, ...)`：开启一个新会话
- `codex-reply(threadId, prompt)`：继续同一个会话

而且 `codex` 的返回里会带 `structuredContent.threadId`，就是你后续多轮来回要用的线程 ID。

所以你要的流程其实正好能成立：

1. Antigravity 调 `codex`
2. 拿到第一版方案 + `threadId`
3. Antigravity 自己评审
4. 再调 `codex-reply(threadId=..., prompt="这是我的修改意见...")`
5. 再拿 Codex 回复继续评审
6. 循环 3～5 轮
7. 最后输出完整 transcript

这已经是你要的“Antigravity 里发起、Codex 参与多轮对话”的最直接做法。



Antigravity should call the MCP tool with arguments equivalent to:

```
{
  "mcpServers": {
    "codex-sol-high": {
      "command": "codex",
      "args": [
        "-m",
        "gpt-5.6-sol",
        "-c",
        "model_reasoning_effort=high",
        "mcp-server"
      ]
    },
    "codex-55-xhigh": {
      "command": "codex",
      "args": [
        "-m",
        "gpt-5.5",
        "-c",
        "model_reasoning_effort=xhigh",
        "mcp-server"
      ]
    },
    "codex-luna-medium": {
      "command": "codex",
      "args": [
        "-m",
        "gpt-5.6-luna",
        "-c",
        "model_reasoning_effort=medium",
        "mcp-server"
      ]
    }
  }
}
```