To convert your current configuration to a shared proxy environment, move the proxy variables into the top-level `shell_environment_policy.set`. Keep only the Claude-specific variable under `mcp-claude.env`.

This shared block applies to **all subprocesses launched by Codex**, not only MCP servers. Codex does not currently provide a native “shared only among MCP servers” table. 



## Updated `config.toml`

```
[shell_environment_policy]
inherit = "core"

[shell_environment_policy.set]
HTTP_PROXY = "http://127.0.0.1:7890"
HTTPS_PROXY = "http://127.0.0.1:7890"
http_proxy = "http://127.0.0.1:7890"
https_proxy = "http://127.0.0.1:7890"
NO_PROXY = "127.0.0.1,localhost,::1"
no_proxy = "127.0.0.1,localhost,::1"


[mcp_servers.mcp-claude]
command = "/Users/vjf/Projects/python/env/bin/python"
args = [
    "/Users/vjf/Projects/github/learning-my-note/ai/llm/architect/multi-agent-orchestration/mcp-claude/mcp-claude.py",
]
tool_timeout_sec = 7500.0

[mcp_servers.mcp-claude.env]
CLAUDE_BIN = "/Users/vjf/.local/bin/claude"


[mcp_servers.codex-mcp]
command = "codex"
args = ["mcp-server"]
startup_timeout_sec = 30
tool_timeout_sec = 7500
enabled_tools = ["codex", "codex-reply"]
```

You should now delete these variables from every `[mcp_servers.xxx.env]` table:

```
HTTP_PROXY
HTTPS_PROXY
http_proxy
https_proxy
NO_PROXY
no_proxy
```