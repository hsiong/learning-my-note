https://zhuanlan.zhihu.com/p/1928918331810886674

# install

```
curl -fsSL https://download.aicodemirror.com/env_deploy/env-install.sh | bash
npm uninstall -g @anthropic-ai/claude-code
npm install -g @anthropic-ai/claude-code
curl -fsSL https://download.aicodemirror.com/env_deploy/env-deploy.sh | bash -s -- "你的API_KEY"
claude -v
```




## init
```
cd project
claude
/init # 会自动 init
/model # change model
```

## Safe YOLO 模式
执行这个之后，Claude 会自动跳过所有权限确认，不需要你手动点允许。这对于一些重复性任务十分方便。

`claude --dangerously-skip-permissions`

## 清除聊天上下文
使用 `/clear `清除聊天上下文，避免累积过多历史信息影响效率。

## 中断操作
输错指令时，按 ESC 键立即停止 AI 当前任务。

## 上下文压缩
Claude Code提供了`/compact `，它的作用是压缩对话历史，只保留上下文摘要，从而减少 token 占用。

## **自定义命令**

**举个例子：**

假设在 `.claude/commands/` 文件夹里新建了一个 `optimize.md` 文件，里面写上：

```text
请分析并修复这个GitHub Issue：$ARGUMENTS。

按照以下步骤操作：

1. 使用`gh issue view`命令查看Issue详情
2. 理解Issue描述
3. 在代码库中搜索相关文件
4. 实施必要的修改来解决Issue
5. 编写并运行测试来验证修复
6. 确保代码通过代码风格检查和类型检查
7. 创建描述性的提交信息
8. 推送代码并创建PR

请记住所有GitHub相关操作都使用GitHub CLI工具(`gh`)来完成。
```

保存后，你就可以在 Claude Code 中执行 `/project:fix-github-issue 1234` ，让 Claude 自动修复指定的 GitHub issue。其中1234是Issue的ID，而指令中的ARGUMENTS会被自动替换成1234

你还可以把其他需求封装成命令，比如：

- `/user:write-tests` → 生成测试用例
- `/project:lint` → 按团队规范格式化代码
- `/user:explain` → 把复杂代码解释成人话