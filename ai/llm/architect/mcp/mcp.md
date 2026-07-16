
## multi-agent-orchestration

https://github.com/hsiong/multi-agent-orchestration


## codex mcp 

codex mcp-server

# mcp market

official site: https://github.com/modelcontextprotocol/servers
https://github.com/appcypher/awesome-mcp-servers
https://mcpmarket.com/tools/skills

## Codex MCP 与 `shell_environment_policy`

`shell_environment_policy.set` 不会给 MCP server 进程注入环境变量，至少在
`codex-cli 0.144.4` 中明确如此。

正确区分如下：

- `shell_environment_policy`：控制 Codex 执行 Shell 或 tool command 时的环境。
- `mcp_servers.<name>.env`：直接给指定 MCP server 设置环境变量。
- `mcp_servers.<name>.env_vars`：从 Codex 自身的启动环境转发指定变量给 MCP server。

运行态检查结果：

- Codex 父进程存在代理变量。
- `mcp-claude.py` 进程没有代理变量。
- `codex mcp-server` 进程同样没有代理变量。
- `codex mcp get mcp-claude` 显示 Claude MCP 环境中只有 `CLAUDE_BIN`。
- Claude MCP 请求返回 `403 Request not allowed`；终端带代理调用成功；终端去掉代理后同样返回 403。

因此，“顶层 shared block 会应用到所有 Codex subprocess，包括 MCP”不适用于
当前实现。STDIO MCP 需要通过各自的 `env` 或 `env_vars` 配置环境变量。

显式配置 `env` 最可靠：

```toml
[mcp_servers.mcp-claude.env]
CLAUDE_BIN = "/Users/vjf/.local/bin/claude"
HTTP_PROXY = "http://127.0.0.1:7890"
HTTPS_PROXY = "http://127.0.0.1:7890"
http_proxy = "http://127.0.0.1:7890"
https_proxy = "http://127.0.0.1:7890"
NO_PROXY = "127.0.0.1,localhost,::1"
no_proxy = "127.0.0.1,localhost,::1"
```

也可以在 `[mcp_servers.mcp-claude]` 下转发 Codex 启动环境中已有的变量：

```toml
env_vars = [
    "HTTP_PROXY",
    "HTTPS_PROXY",
    "http_proxy",
    "https_proxy",
    "NO_PROXY",
    "no_proxy",
]
```

但 `env_vars` 要求启动 Codex 的真实父环境已经导出这些变量；
`shell_environment_policy.set` 中的值不能作为 `env_vars` 的来源。因此需要代理的
MCP 推荐使用显式 `env`，修改配置后重启 Codex，让 MCP 进程重新创建。

### `codex mcp-server` 的两层环境

`codex mcp-server` 需要区分服务器进程和它内部执行的命令：

- Codex 启动 `codex mcp-server` 时，不会把 `shell_environment_policy.set`
  注入 MCP server 自身的进程环境。
- `codex mcp-server` 内部的 Codex agent 执行 Shell 或 tool command 时，会读取
  同一份 Codex 配置，并自动把 `shell_environment_policy.set` 应用到该命令环境。

在 `codex-cli 0.144.4` 的实际验证中，`codex mcp-server` 进程自身没有代理变量，
但通过该 MCP 启动的 Codex agent 执行环境检查时，`HTTP_PROXY`、
`HTTPS_PROXY`、`http_proxy`、`https_proxy`、`NO_PROXY` 和 `no_proxy` 均存在。

因此，如果代理只供 Codex agent 执行的 Shell 命令使用，顶层
`shell_environment_policy.set` 会自动生效；如果 `codex mcp-server` 进程自身也
必须使用代理，则仍需在 `[mcp_servers.codex-mcp.env]` 中显式设置，或在
`[mcp_servers.codex-mcp]` 中使用 `env_vars` 转发 Codex 启动环境里的变量。

官方配置说明：<https://learn.chatgpt.com/docs/extend/mcp>
