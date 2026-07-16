# claude - custom design

+ support specifying a model
+ support multi-turn conversations via `ThreadId`
+ support optional incremental output polling

## custom MCP

### install

mcp-claude

注意:  即使 Codex CLI 能看到代理变量，也不代表 STDIO MCP 子进程会自动得到全部变量。Codex 对 MCP 子进程做了环境隔离

更合适的动态转发方式是编辑 ~/.codex/config.toml 来新增 mcp

```
  [mcp_servers.mcp-claude]
  command = "/absolute/path/to/venv/bin/python"
  args = ["/absolute/path/to/mcp_server.py"]
  env_vars = [
    "CLAUDE_BIN",
    "HTTP_PROXY",
    "HTTPS_PROXY",
    "http_proxy",
    "https_proxy",
    "ALL_PROXY",
    "NO_PROXY",
  ]
```



### config

`model`: 默认 Fable 5

+ Claude Fable 5 -> claude-fable-5
+ Claude Sonnet 5 -> claude-sonnet-5
+ Claude Opus 4.8 -> claude-opus-4-8

`effort`

```

   值        含义
  ━━━━━━━━  ━━━━━━━━━━━━━━━━━━━━━━━━━━
   low       最少推理，速度快、消耗低
  ────────  ──────────────────────────
   medium    中等推理
  ────────  ──────────────────────────
   high      较强推理，当前默认值
  ────────  ──────────────────────────
   xhigh     更高推理
  ────────  ──────────────────────────
   max       最大推理投入
```

`tools`

```
常用内置工具：

   工具                                                       作用
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ━━━━━━━━━━━━━━━━━━━━━━━
   Read                                                       读取文件
  ─────────────────────────────────────────────────────────  ───────────────────────
   Grep                                                       搜索文件内容
  ─────────────────────────────────────────────────────────  ───────────────────────
   Glob                                                       查找文件
  ─────────────────────────────────────────────────────────  ───────────────────────
   Bash                                                       执行 Shell 命令
  ─────────────────────────────────────────────────────────  ───────────────────────
   Edit                                                       修改已有文件
  ─────────────────────────────────────────────────────────  ───────────────────────
   Write                                                      创建或覆盖文件
  ─────────────────────────────────────────────────────────  ───────────────────────
   WebSearch                                                  搜索互联网
  ─────────────────────────────────────────────────────────  ───────────────────────
   WebFetch                                                   读取网页
  ─────────────────────────────────────────────────────────  ───────────────────────
   Agent                                                      启动 Claude 子代理
  ─────────────────────────────────────────────────────────  ───────────────────────
   LSP                                                        代码定义、引用和诊断
  ─────────────────────────────────────────────────────────  ───────────────────────
   NotebookEdit                                               修改 Jupyter Notebook
  ─────────────────────────────────────────────────────────  ───────────────────────
   AskUserQuestion                                            向用户提问
  ─────────────────────────────────────────────────────────  ───────────────────────
   Skill                                                      调用 Claude Skill
  ─────────────────────────────────────────────────────────  ───────────────────────
   TodoWrite                                                  管理任务清单
  ─────────────────────────────────────────────────────────  ───────────────────────
   TaskCreate / TaskGet / TaskList / TaskUpdate / TaskStop    管理任务
  ─────────────────────────────────────────────────────────  ───────────────────────
   EnterPlanMode / ExitPlanMode                               切换规划模式
  ─────────────────────────────────────────────────────────  ───────────────────────
   ToolSearch                                                 搜索延迟加载的工具

  完整、动态更新的名单见 Claude Code Tools reference (https://code.claude.com/docs/en/tools-reference)。
```



`permission_mode` Available choices include:

- `default` or `manual`: read operations are allowed; edits and most commands require approval.
- `acceptEdits`: automatically allows file edits and common filesystem commands inside the working directory.
- `auto`: automatically evaluates actions with a safety classifier.
- `dontAsk`: only explicitly pre-approved tools are allowed.
- `bypassPermissions`: skips permission prompts and allows all available tools.



### claude_start

Starts a new Claude conversation.

Inputs

| Parameter         | Type  | Required | Default                              | Meaning                                           |
| ----------------- | ----- | -------- | ------------------------------------ | ------------------------------------------------- |
| `prompt`          | `str` | Yes      | —                                    | The message sent to Claude                        |
| `cwd`             | `str` | Yes      | —                                    | Absolute or relative working directory for Claude |
| `model`           | `str` | No       | `"fable"` or whatever you configured | Claude model alias or full model ID               |
| `effort`          | `str` | No       | `"high"`                             | Reasoning effort passed to `--effort`             |
| `permission_mode` | `str` | No       | `"plan"`                             | Claude Code permission mode                       |
| `max_turns`       | `int` | No       | `8`                                  | Maximum internal Claude agent turns               |
| `tools`           | `str` | No       | `"Read,Grep,Glob"`                   | Claude Code tools allowed for this invocation     |
| `timeout_seconds` | `int` | No       | `1800`                               | Process timeout in seconds                        |

Then it approximately runs:

```
claude -p \
  --output-format stream-json \
  --verbose \
  --effort high \
  --permission-mode plan \
  --max-turns 8 \
  --strict-mcp-config \
  --tools Read,Grep,Glob \
  --model fable \
  --session-id "<generated-uuid>" \
  "Review the authentication module."
```

### claude_reply

Continues an existing Claude conversation.

Inputs

| Parameter         | Type         | Required | Default            | Meaning                                                      |
| ----------------- | ------------ | -------- | ------------------ | ------------------------------------------------------------ |
| `session_id`      | `str`        | Yes      | —                  | Session ID returned by `claude_start`                        |
| `prompt`          | `str`        | Yes      | —                  | Follow-up message                                            |
| `cwd`             | `str`        | Yes      | —                  | Working directory; normally the same one used by `claude_start` |
| `model`           | `str | None` | No       | `None`             | Leave empty to retain the session model; set it to override the model |
| `effort`          | `str`        | No       | `"high"`           | Reasoning effort                                             |
| `permission_mode` | `str`        | No       | `"plan"`           | Claude Code permission mode                                  |
| `max_turns`       | `int`        | No       | `8`                | Maximum internal agent turns for this reply                  |
| `tools`           | `str`        | No       | `"Read,Grep,Glob"` | Tools allowed during this reply                              |
| `timeout_seconds` | `int`        | No       | `1800`             | Process timeout                                              |

Both tools return the same dictionary structure.

```
{
  "session_id": "c13715fe-e387-4ba3-958f-d11db8829047",
  "result": "Claude's final response",
  "partial_result_recovered": false,
  "is_error": false,
  "terminal_reason": "completed",
  "subtype": "success",
  "usage": {},
  "model_usage": {},
  "total_cost_usd": 0.0123,
  "cwd": "/home/user/project"
}
```

### claude_stream_start

Starts a new Claude conversation in the background and immediately returns a
`task_id`. It accepts the same inputs and defaults as `claude_start`.

```
{
  "task_id": "73f3ea66-bc66-4fa0-90c7-992ef57fd608",
  "session_id": "c13715fe-e387-4ba3-958f-d11db8829047",
  "status": "running",
  "cwd": "/home/user/project"
}
```

`task_id` identifies this background invocation. `session_id` still identifies
the Claude conversation and can be passed to `claude_reply` after the stream
task finishes.

### claude_stream_poll

Returns only text that has not been returned by an earlier poll for the same
task.

Inputs

| Parameter | Type  | Required | Meaning                                    |
| --------- | ----- | -------- | ------------------------------------------ |
| `task_id` | `str` | Yes      | Task ID returned by `claude_stream_start`  |

```
{
  "task_id": "73f3ea66-bc66-4fa0-90c7-992ef57fd608",
  "session_id": "c13715fe-e387-4ba3-958f-d11db8829047",
  "status": "running",
  "text": "New text emitted since the previous poll"
}
```

Each poll consumes its returned `text`. Calling it again before Claude emits
more text returns an empty string. `status` is `running`, `completed`, or
`failed`. A failed task also returns an `error` field.

### claude_stream_result

Returns the final compact result for a background invocation. If Claude is
still running, this call waits until it finishes, so polling is optional.

Inputs

| Parameter | Type  | Required | Meaning                                    |
| --------- | ----- | -------- | ------------------------------------------ |
| `task_id` | `str` | Yes      | Task ID returned by `claude_stream_start`  |

The response contains `task_id`, `status`, and the same final result fields as
`claude_start`:

```
{
  "task_id": "73f3ea66-bc66-4fa0-90c7-992ef57fd608",
  "status": "completed",
  "session_id": "c13715fe-e387-4ba3-958f-d11db8829047",
  "result": "Claude's final response",
  "partial_result_recovered": false,
  "is_error": false,
  "terminal_reason": "completed",
  "subtype": "success",
  "usage": {},
  "model_usage": {},
  "total_cost_usd": 0.0123,
  "cwd": "/home/user/project"
}
```

The final result is removed from the MCP server after it is returned, so call
`claude_stream_result` once per `task_id`. Stream tasks are stored in memory;
restarting the MCP server invalidates unfinished and uncollected task IDs.

Typical flow:

```
claude_stream_start -> claude_stream_poll (zero or more times)
                    -> claude_stream_result
                    -> claude_reply (optional, using session_id)
```

### test in codex

#### codex mcp get mcp-claude

```
codex 
/mcp

you would see 
  • mcp-claude
    • Auth: Unsupported
    • Tools: claude_reply, claude_start, claude_stream_poll,
             claude_stream_result, claude_stream_start
```

#### Complete streaming test

```
Call claude_stream_start using:

- cwd: the current absolute working directory
- model: claude-sonnet-5
- effort: high
- permission_mode: plan
- max_turns: 1
- prompt:
  Explain the purpose of the current project in three short paragraphs.

Save task_id and session_id from the response.
Call claude_stream_poll with task_id until status is completed or failed.
Print the text returned by each poll without repeating earlier text.
Call claude_stream_result once with task_id and print its final result.
```

#### Complete multi-turn test with Fable 5

```
Call claude_start using:

- cwd: the current absolute working directory
- model: claude-sonnet-5
- effort: high
- permission_mode: plan
- max_turns: 1
- prompt:
  Remember test_number=7391. What model are you—Sonnet, Fable, or Opus?

after print, Call claude_reply using:

- the previous session_id
- the same cwd
- permission_mode: plan
- max_turns: 1
- prompt:
  Return (the test_number +1) as FABLE_REPLY_OK_code from the previous turn. 
  Reply with exactly: FABLE_REPLY_OK_code <code>

print each call returned session_id and return result
```

#### Verify model and effort

Do not use Claude's natural-language answer as evidence of the active effort
level. A reply such as `medium` can be incorrect even when the CLI sent
`--effort high`. Verify the API request metadata recorded by Claude Code
instead.

Use the `session_id` returned by `claude_start` to locate its telemetry event:

```shell
session_id="<session_id returned by claude_start>"
telemetry_file="$(
  rg -l --fixed-strings \
    "\"session_id\":\"${session_id}\"" \
    ~/.claude/telemetry \
  | head -n 1
)"

jq '
  select(
    .event_data.event_name == "tengu_api_query"
    and .event_data.model == "claude-sonnet-5"
  )
  | .event_data.additional_metadata
  | @base64d
  | fromjson
  | {
      model,
      thinkingType,
      effortValue,
      permissionMode
    }
' "$telemetry_file"
```

Expected fields for the test above:

```json
{
  "model": "claude-sonnet-5",
  "thinkingType": "adaptive",
  "effortValue": "high",
  "permissionMode": "plan"
}
```

The `tengu_api_query` event is the runtime evidence that Claude Code sent the
requested model and effort to the API. Only print the selected metadata above;
do not copy the complete telemetry event because it contains unrelated local
account and environment metadata. If no matching file exists under
`~/.claude/telemetry`, Claude Code did not retain a failed telemetry batch for
that session, so this local inspection method is unavailable for that run.

### other issues

#### `max_turns: 1` partial result recovery

In plan mode, Claude can emit a complete text response and then call
`ExitPlanMode`. The tool call consumes the only available turn, so Claude Code
ends with `error_max_turns` and leaves the final result field empty.

The MCP wrapper consumes Claude Code's `stream-json` output. When the final
result is empty but an earlier assistant event already contains text, the
wrapper returns that text and sets:

```json
{
  "result": "The text Claude emitted before the tool call",
  "partial_result_recovered": true,
  "is_error": true,
  "terminal_reason": "max_turns",
  "subtype": "error_max_turns",
  "exit_code": 1
}
```

This preserves the caller's `max_turns: 1` limit and does not convert the CLI
failure into a false success. Callers can use the recovered text while still
checking `partial_result_recovered`, `is_error`, and `terminal_reason`. The same
`session_id` remains resumable with `claude_reply`.


## Cli

To specify a model for Claude, you must do so through the CLI rather than MCP.

```
claude -p \
  --model claude-opus-4-8 \
  --effort high \
  --permission-mode plan \
  --max-turns 20 \
  --output-format json \
  "Review this suspected defect independently..."
```





> # claude 不使用 mcp
>
> Claude's MCP does not support specifying a model, nor does it support multi-turn conversations via `ThreadId`.
>
> ## codex 如何安装 claude mcp 
>
> ```
> CLAUDE_BIN="$(command -v claude)"
> codex mcp add claude-code -- "$CLAUDE_BIN" mcp serve
> codex mcp list
> ```
>
> 
>
> ## MCP connection parameters
>
> You can configure the Codex-side MCP connection with:
>
> ```
> vim ~/.codex/config.toml
> ```
>
> For example:
>
> ```
> [mcp_servers.claude-code]
> command = "/absolute/path/to/claude"
> args = ["mcp", "serve"]
> 
> enabled = true
> required = false
> 
> startup_timeout_sec = 30
> tool_timeout_sec = 1800
> 
> default_tools_approval_mode = "prompt"
> ```
>
> Codex supports MCP settings including `command`, `args`, `env`, `env_vars`, `cwd`, startup timeout, tool timeout, enabled tools, disabled tools, and approval policies. 
>
> You can also pass environment variables:
>
> ```
> [mcp_servers.claude-code.env]
> MY_VARIABLE = "value"
> ```
>



## kill claude mcp

```
   操作                    MCP 服务    Claude 长任务
  ──────────────────────  ──────────  ────────────────────────────────────────
   正常退出 Codex          通常退出    流式任务通常被清理，但同步任务不够可靠
  ──────────────────────  ──────────  ────────────────────────────────────────
   kill MCP_PID            退出        不保证同步退出
  ──────────────────────  ──────────  ────────────────────────────────────────
   杀 MCP 进程组           退出        一并退出
  ──────────────────────  ──────────  ────────────────────────────────────────
   到达 timeout_seconds    继续运行    被代码 kill
```

  - mcp-claude.py 是 MCP 服务进程，每个 Codex 会话通常启动一个，即使闲置也一直存在。
  -   关闭 Codex 终端后的行为：
        
      - 正常退出 Codex：STDIO 关闭，MCP 服务会退出；流任务被取消时，代码会主动 kill Claude 子进程，见 mcp-claude.py:430 和 mcp-claude.py:441。
      - 强制杀掉、系统崩溃等异常退出：不能绝对保证子进程立即消失，需要用上面的命令复查。
      - 当前流任务只保存在 MCP 进程内存中，见 mcp-claude.py:44。MCP 一旦退出，task_id 和未领取结果都会丢失，文档也明确说明了这一点：/Users/vjf/Projects/github/
        learning-my-note/ai/llm/architect/multi-agent-orchestration/codex-claude.md:258。



进入目录：

```bash

cd ~/Projects/github/learning-my-note/ai/llm/architect/multi-agent-orchestration/mcp-claude

```



查看 MCP 数量：

```bash

pgrep -f '[m]cp-claude\.py' | wc -l

```



查看具体进程和运行时间：

```bash

ps -axo pid,ppid,etime,command | rg '[m]cp-claude\.py'

```



查看当前真正执行中的 Claude 长任务

```bash

ps -axo pid,ppid,etime,command | rg '[c]laude -p'

```



杀掉 MCP：

```bash

pkill -TERM -f '[m]cp-claude\.py'

```



如果普通终止无效，再强制杀掉：

```bash

pkill -KILL -f '[m]cp-claude\.py'

```



但是，只杀 MCP 进程不一定能清理正在运行的 Claude 子进程。

更稳妥的方式是杀掉整个 MCP 进程组。当前环境中，MCP 的 PGID 等于自己的 PID，可以连同 Claude 子进程一起终止：

```bash

for pid in $(pgrep -f '[m]cp-claude\.py'); do

  pgid="$(ps -o pgid= -p "$pid" | tr -d ' ')"



  if [ "$pgid" = "$pid" ]; then

    kill -TERM -- "-$pgid"

  else

    echo "跳过 PID=$pid：PGID=$pgid，不是独立进程组"

  fi

done

```

这会终止：

```text

mcp-claude.py

└── claude -p

    └── Claude 启动的其他子进程

```

不会杀掉手动启动且不属于这些进程组的 Claude。