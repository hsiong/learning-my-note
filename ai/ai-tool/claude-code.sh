
# install

curl -fsSL https://download.aicodemirror.com/env_deploy/env-install.sh | bash
npm uninstall -g @anthropic-ai/claude-code
npm install -g @anthropic-ai/claude-code
curl -fsSL https://download.aicodemirror.com/env_deploy/env-deploy.sh | bash -s -- "你的API_KEY"
claude -v


## init
cd project
claude
/init # 会自动 init
/model # change model