# install


## check 
https://developers.openai.com/codex/cli

支持 homebrew & npm 安装, npm 的版本最新

codex -V

## init 
cd your-project-folder
codex

### 用 AGENTS.md 反向影响 /init
vim ~/.codex/AGENTS.md
```
## AGENTS.md generation rules

When generating a new AGENTS.md:
- Always include Below Rules
```


## 历史对话
codex resume

## 常用指令 

/init 

/compact

## 强制更新

npm install -g @openai/codex --registry=https://registry.npmjs.org/
codex --version    
codex-cli 0.73.0

## 禁止读取
###
编辑 ~/.codex/config.toml, 加一条 blocked 规则（重点）, 在文件里 新增或修改：

```
[projects."xxx/backend-system/src/main/resources"]

trust_level = "untrusted"
```
### 方式2
每句指令之前加入 - 禁止读取 `*/application.yml` , `*/application-common.yml`, `.fastRequest/*`, `.mvn/*`, `.idea/*`, `config/.env.*;

## permisson error  这个一般是是 git 导致的问题
sudo chown $(whoami):$(id -gn) ~/.gitconfig

### 不行的话, 使用更强力的办法  https://www.reddit.com/r/OpenAI/comments/1n4gk3w/how_to_adjust_permissions_in_codex_so_i_can_stop/
codex --dangerously-bypass-approvals-and-sandbox  

## 完成 commit 提交
```
完成当前工作区 commit 内容  中文; 注意不是提交, 按功能整理(注意不是代码模块，整个功能链路为一个功能模块), 从改动量大到小排序, 无需指明代码文件; 整理成老板可以看懂的功能内容
```

## 新增 curd
```
已知新增表如下 xxx..  参考 xxxModule 下的现有代码(不需要全读取，两到三个表相关的bean/mapper)， 在 xxxPath 下新增 curd 代码
```


## codex mcp 

codex mcp-server

## codex api ollama

详见 ai/llm/ai-tool/abliterated.md

## skills

https://github.com/hsiong/project-codex-skills

## jetbra codex auth
The file location is:

Linux: ~/.cache/JetBrains/<product><version>/aia/codex/auth.json

macOS: ~/Library/Caches/JetBrains/<product><version>/aia/codex/auth.json

Windows: %LOCALAPPDATA%\JetBrains\<product><version>\aia\codex\auth.json

