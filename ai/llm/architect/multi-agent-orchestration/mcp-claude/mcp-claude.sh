#!/usr/bin/env zsh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VENV_PYTHON="$HOME/Projects/python/env/bin/python"

# Make it executable:
chmod +x "$SCRIPT_DIR/mcp-claude.py"

# requirements
if [ ! -x "$VENV_PYTHON" ]; then
  echo "venv python not found: $VENV_PYTHON" >&2
  exit 1
fi

source "$HOME/Projects/python/env/bin/activate"
"$VENV_PYTHON" -m pip install --upgrade pip
"$VENV_PYTHON" -m pip install "mcp>=1.27,<2"

# Register it in Codex.
CODEX_CONFIG="${CODEX_HOME:-$HOME/.codex}/config.toml"
CLAUDE_BIN="$(command -v claude)"
MCP_SERVER="$SCRIPT_DIR/mcp-claude.py"
HTTPS_PROXY_VALUE="${https_proxy:-${HTTPS_PROXY:-}}"

if [ -z "$HTTPS_PROXY_VALUE" ]; then
  echo "https proxy is not configured" >&2
  exit 1
fi

# Remove the old table first so appending the new table does not create a
# duplicate mcp_servers.mcp-claude definition.
codex mcp remove mcp-claude 2>/dev/null || true

mkdir -p "$(dirname "$CODEX_CONFIG")"
touch "$CODEX_CONFIG"

# JSON strings are valid TOML basic strings and safely escape paths and values.
VENV_PYTHON_TOML="$("$VENV_PYTHON" -c 'import json, sys; print(json.dumps(sys.argv[1]))' "$VENV_PYTHON")"
MCP_SERVER_TOML="$("$VENV_PYTHON" -c 'import json, sys; print(json.dumps(sys.argv[1]))' "$MCP_SERVER")"
CLAUDE_BIN_TOML="$("$VENV_PYTHON" -c 'import json, sys; print(json.dumps(sys.argv[1]))' "$CLAUDE_BIN")"
HTTPS_PROXY_TOML="$("$VENV_PYTHON" -c 'import json, sys; print(json.dumps(sys.argv[1]))' "$HTTPS_PROXY_VALUE")"

{
  echo
  echo '[mcp_servers.mcp-claude]'
  echo "command = $VENV_PYTHON_TOML"
  echo "args = [$MCP_SERVER_TOML]"
  echo 'tool_timeout_sec = 7500'
  echo
  echo '[mcp_servers.mcp-claude.env]'
  echo "CLAUDE_BIN = $CLAUDE_BIN_TOML"
} >> "$CODEX_CONFIG"
