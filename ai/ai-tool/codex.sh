# install


## check 
https://developers.openai.com/codex/cli

支持 homebrew & npm 安装, npm 的版本最新

codex -V

## init 
cd your-project-folder
codex

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
编辑 ~/.codex/config.toml, 加一条 blocked 规则（重点）, 在文件里 新增或修改：

```
[projects."xxx/backend-system/src/main/resources"]

trust_level = "untrusted"
```
