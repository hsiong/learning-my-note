#!/usr/bin/env zsh

set -e

CODEX_CONFIG="${CODEX_HOME:-$HOME/.codex}/config.toml"
CODEX_BIN="$(command -v codex || true)"
PYTHON_BIN="$(command -v python3 || true)"
PROXY_VALUE="${https_proxy:-${HTTPS_PROXY:-${http_proxy:-${HTTP_PROXY:-}}}}"
NO_PROXY_VALUE="${no_proxy:-${NO_PROXY:-127.0.0.1,localhost,::1}}"

if [ -z "$CODEX_BIN" ]; then
  echo "Codex CLI was not found" >&2
  exit 1
fi

if ! "$CODEX_BIN" mcp-server --help >/dev/null 2>&1; then
  echo "codex mcp-server is not available: $CODEX_BIN" >&2
  exit 1
fi

if [ -z "$PYTHON_BIN" ]; then
  echo "python3 was not found" >&2
  exit 1
fi

if [ -z "$PROXY_VALUE" ]; then
  echo "HTTP/HTTPS proxy is not configured" >&2
  exit 1
fi

# Remove the old table so repeated runs do not create duplicate definitions.
"$CODEX_BIN" mcp remove codex-mcp >/dev/null 2>&1 || true

mkdir -p "$(dirname "$CODEX_CONFIG")"
touch "$CODEX_CONFIG"

# JSON strings are valid TOML basic strings and safely escape every value.
CODEX_BIN_TOML="$("$PYTHON_BIN" -c 'import json, sys; print(json.dumps(sys.argv[1]))' "$CODEX_BIN")"
PROXY_TOML="$("$PYTHON_BIN" -c 'import json, sys; print(json.dumps(sys.argv[1]))' "$PROXY_VALUE")"
NO_PROXY_TOML="$("$PYTHON_BIN" -c 'import json, sys; print(json.dumps(sys.argv[1]))' "$NO_PROXY_VALUE")"

{
  echo
  echo '[mcp_servers.codex-mcp]'
  echo "command = $CODEX_BIN_TOML"
  echo 'args = ["mcp-server"]'
  echo 'startup_timeout_sec = 30'
  echo 'tool_timeout_sec = 7500'
  echo 'enabled_tools = ["codex", "codex-reply"]'
  echo
  echo '[mcp_servers.codex-mcp.env]'
  echo "HTTP_PROXY = $PROXY_TOML"
  echo "HTTPS_PROXY = $PROXY_TOML"
  echo "http_proxy = $PROXY_TOML"
  echo "https_proxy = $PROXY_TOML"
  echo "NO_PROXY = $NO_PROXY_TOML"
  echo "no_proxy = $NO_PROXY_TOML"
} >> "$CODEX_CONFIG"

echo "Configured codex-mcp in $CODEX_CONFIG"
echo "Restart Codex to launch the MCP server with the updated environment"
