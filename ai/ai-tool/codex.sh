# install

rm -rf ~/.codex
mkdir ~/.codex
cd ~/.codex

cat > auth.json << 'EOF'
{
  "OPENAI_API_KEY": "key"
}
EOF

cat > config.toml << 'EOF'
model_provider = "aicodemirror"
model = "gpt-5-codex"
model_reasoning_effort = "high"
disable_response_storage = true
preferred_auth_method = "apikey"
[model_providers.aicodemirror]
name = "aicodemirror"
base_url = "https://api.aicodemirror.com/api/codex/backend-api/codex"
wire_api = "responses"
EOF

## check 

codex -V

## init 
cd your-project-folder
codex
