 **If Codex CLI is already installed and `codex mcp-server` exists, you do not need to install any additional MCP package.**

But it is not simply asking Codex to execute an ordinary `codex` shell command. You should register another Codex process as an MCP server once:

`codex mcp add codex-mcp -- codex mcp-server`


> refer: [text](../mcp/share-mcp-config.md)

Open the Codex configuration:

`vim ~/.codex/config.toml`

```
[mcp_servers.codex-mcp]
command = "codex"
args = ["mcp-server"]
startup_timeout_sec = 30
tool_timeout_sec = 3600
enabled_tools = ["codex", "codex-reply"]
```



