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

## codex close codex_apps

sublime ~/.codex/config.toml
```
[features]
apps = false
```


## codex api ollama

详见 ai/llm/ai-tool/abliterated.md

## skills

https://github.com/hsiong/project-codex-skills

## jetbra codex auth
The file location is:

Linux: ~/.cache/JetBrains/<product><version>/aia/codex/auth.json

macOS: ~/Library/Caches/JetBrains/<product><version>/aia/codex/auth.json

Windows: %LOCALAPPDATA%\JetBrains\<product><version>\aia\codex\auth.json

## statusline

+ five-hour-limit
+ weekly-limit

## image 2.0 shell exec

hermes: https://mp.weixin.qq.com/s/npmrEL8vpnavUm1A8-u-2w

codex exec \
  -m gpt-5.5 \
  -c model_reasoning_effort="medium" \
  --image "/Users/vjf/Desktop/ref1.png" \
  --image "/Users/vjf/Desktop/ref2.jpg" \
  --skip-git-repo-check \
  --ephemeral \
  --sandbox workspace-write \
  "$PROMPT"

> --ephemeral means: run this Codex task without saving the Codex session/rollout records to disk.
> --image "/Users/vjf/Desktop/ref2.jpg" means: reference the image file "/Users/vjf/Desktop/ref2.jpg" in the task prompt.
    > You can also do this in one flag:   --image "/Users/vjf/Desktop/ref1.png,/Users/vjf/Desktop/ref2.jpg" \
> size: Generate a new image at size 1536x864.  
    '''
    4) Valid size rules

    For gpt-image-2, arbitrary resolutions such as 1536x864 are supported, but width and height must both be divisible by 16, the aspect ratio must be between 1:3 and 3:1, resolutions above 2560x1440 are experimental, and the current maximum supported resolution is 3840x2160.【turn185857view4†L1036-L1043】

    So these are valid examples:

    1024x1024
    1536x1024
    1536x864
    1024x1536
    2048x2048

    These are invalid examples:

    1000x1000
    1920x1080
    4000x2000
    '''

# reinstall 

npm uninstall -g @openai/codex
npm install -g @openai/codex@0.142.5

codex --version
which -a codex

## mac reinstall
brew uninstall --cask codex
npm install -g @openai/codex@0.142.5
codex --version