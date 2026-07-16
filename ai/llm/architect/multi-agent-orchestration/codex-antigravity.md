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





**`codex mcp-server` and `codex app-server` provide different levels of control**.

## Capability comparison

| Capability                                | `codex mcp-server`                         | `codex app-server`     |
| ----------------------------------------- | ------------------------------------------ | ---------------------- |
| Multi-turn conversation                   | Yes                                        | Yes                    |
| Preserve conversation context             | Yes, via `threadId`                        | Yes, via thread APIs   |
| Select model when starting                | Yes                                        | Yes                    |
| Change model during the same conversation | Not directly documented                    | Yes, per turn          |
| Token-by-token response streaming         | Not through the documented MCP tool result | Yes                    |
| Stream command output                     | Limited by MCP client                      | Yes                    |
| Interrupt an active turn                  | No documented MCP tool                     | Yes                    |
| Add instructions while a turn is running  | No                                         | Yes, with `turn/steer` |
| List available models                     | No dedicated MCP tool                      | Yes, with `model/list` |
| Approvals and rich UI integration         | Basic                                      | Complete               |

## Multi-turn through `codex mcp-server`

Start it with:

```
codex mcp-server
```

It exposes two MCP tools:

- `codex`: starts a new conversation
- `codex-reply`: continues the conversation using the returned `threadId`

The initial `codex` call supports `prompt`, `cwd`, `model`, `approval-policy`, `sandbox`, `developer-instructions`, `base-instructions`, and arbitrary Codex configuration overrides. 

Example initial call:

```
{
  "name": "codex",
  "arguments": {
    "prompt": "Review the cross-validation implementation.",
    "cwd": "/home/hsiong/code/project",
    "model": "<available-model-id>",
    "approval-policy": "never",
    "sandbox": "workspace-write"
  }
}
```

The result contains:

```
{
  "structuredContent": {
    "threadId": "019bbb20-bff6-7130-83aa-bf45ab33250e",
    "content": "..."
  }
}
```

Continue the same conversation with:

```
{
  "name": "codex-reply",
  "arguments": {
    "threadId": "019bbb20-bff6-7130-83aa-bf45ab33250e",
    "prompt": "Now check whether the label horizon crosses validation boundaries."
  }
}
```

This can repeat indefinitely until the thread expires or encounters context or usage limits. The official interface specifically documents `threadId` as the identifier for continuing a session. 

## Model selection limitation

The initial `codex` tool accepts:

```
{
  "model": "<model-id>"
}
```

However, the documented `codex-reply` arguments are only:

```
prompt
threadId
conversationId  // deprecated alias
```

Therefore, **you can select the model when starting the MCP conversation, but there is no documented `model` parameter for switching models through `codex-reply`**. 

To use a different model with plain MCP, the simplest method is usually to start another `codex` thread.

## Streaming limitation

`codex mcp-server` runs over a persistent MCP connection, but the documented tool response is a completed MCP result containing `structuredContent` and `content`. It does not document token-delta events such as an `agentMessage/delta` stream for the `codex` and `codex-reply` tools. 

So there are two different meanings of “streaming”:

- **Transport streaming:** the stdio MCP process remains connected.
- **Generation streaming:** individual output text deltas appear while Codex is generating.

The first is supported. For the second, use `codex app-server`.

## Real streaming with `codex app-server`

Start it with:

```
codex app-server
```

It uses bidirectional JSON-RPC over JSONL/stdin/stdout by default. It is the interface used for rich Codex clients and supports conversation history, approvals, model control, and streamed agent events. 

Its conversation structure is:

```
Thread
└── Turn
    ├── user message
    ├── agent message
    ├── command execution
    ├── file change
    └── MCP tool call
```

Start a thread:

```
{
  "method": "thread/start",
  "id": 1,
  "params": {
    "model": "<model-id>"
  }
}
```

Start a turn:

```
{
  "method": "turn/start",
  "id": 2,
  "params": {
    "threadId": "thr_123",
    "input": [
      {
        "type": "text",
        "text": "Review the cross-validation module."
      }
    ],
    "model": "<model-id>",
    "effort": "high",
    "cwd": "/home/hsiong/code/project"
  }
}
```

Then continuously read events such as:

```
{
  "method": "item/agentMessage/delta",
  "params": {
    "threadId": "thr_123",
    "turnId": "turn_456",
    "delta": "The first issue is..."
  }
}
```

App Server streams:

- `item/agentMessage/delta`
- `item/plan/delta`
- `item/reasoning/summaryTextDelta`
- `item/commandExecution/outputDelta`
- `item/started`
- `item/completed`
- `turn/completed`

This provides actual incremental answer text and command output. 

## Switching models during a conversation

App Server supports model configuration at both thread and turn level. A `turn/start` call can override:

```
{
  "model": "<model-id>",
  "effort": "medium",
  "personality": "pragmatic"
}
```

A turn-level model override becomes the default for later turns in that thread. App Server also provides `model/list` to discover available model IDs and supported reasoning-effort values dynamically. 

You can therefore do:

```
Turn A: fast model, medium effort
Turn B: stronger model, high effort
Turn C: return to a faster model
```

## Using one Codex instance to call another Codex instance

A parent Codex CLI can register a child Codex MCP server in `~/.codex/config.toml`:

```
[mcp_servers.codex_child]
command = "codex"
args = ["mcp-server"]
startup_timeout_sec = 30
tool_timeout_sec = 3600
enabled_tools = ["codex", "codex-reply"]
```

Codex supports stdio MCP commands, arguments, startup timeouts, tool timeouts, and tool allowlists in its configuration. 

Then the parent Codex can call:

```
codex_child.codex
codex_child.codex-reply
```

For your automated Codex-to-Claude or Codex-to-Codex review loop:

- Use **`codex mcp-server`** when you need simple repeated review rounds and only require the final result from each round.
- Use **`codex app-server`** when you need real-time output, model switching between turns, interruption, active-turn steering, approval handling, command-output streaming, and full thread lifecycle management.

For the workflow you described earlier—automatic multi-round review, retaining `threadId`, and exchanging conclusions—`codex mcp-server` is sufficient. For a visible live conversation interface, App Server is the better foundation.