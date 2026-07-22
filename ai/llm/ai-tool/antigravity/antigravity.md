# agents.md

[Mastering Antigravity & Agent.md Workflows](https://www.youtube.com/watch?v=j8wdu5VTozs) 这个社区教程详细演示了如何在 Antigravity 中设置项目目录，以及如何有效利用 `agent.md` 文件来获取稳定、高质量的代码输出。


# planb: tun + sing-box



# proxifier

Application: "Antigravity.app"; "Antigravity"; com.google.antigravity
Action: Socks5 127.0.0.1:7890

# please allow proxifier to filter network content ? macos  怎么配置

General → Login Items & Extensions 和 Network → Filters

# Antigravity cli

curl -fsSL https://antigravity.google/cli/install.sh | bash

echo 'export PATH="~/.local/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc

> mac
ln -sf ~/.local/bin/agy ~/.local/bin/antigravity
mac - antigravity - tun

> linux
sudo ln -sf /home/hsiong/.local/bin/agy /usr/local/bin/antigravity
cp [antigravity-client](ai/llm/ai-tool/antigravity/antigravity-client.json)
linux - antigravity - tun + dns

## proxy - login
must open `tun` proxy

## --yolo
antigravity --dangerously-skip-permissions    

## skill

ln -s ~/.agent/skills ~/.gemini  

## shell exec 

antigravity -p 'your prompt'