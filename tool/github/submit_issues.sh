#!/bin/bash

# GitHub Personal Access Token (需要具有 repo 权限)
GITHUB_TOKEN="ghp_xxx"

# 目标仓库 (格式: owner/repo)
REPO="hsiong/project-fast-api"

# API 端点
API_URL="https://api.github.com/repos/$REPO/issues"

# 检查是否设置了 Token
if [ -z "$GITHUB_TOKEN" ]; then
    echo "错误: 请在执行此脚本前，在此脚本中填入您的 GITHUB_TOKEN"
    exit 1
fi

# 检查是否安装了 jq 工具 (用于安全构建 JSON)
if ! command -v jq > /dev/null 2>&1; then
    echo "错误: 未找到 'jq' 命令。请先安装它 (例如: sudo apt install jq)"
    exit 1
fi

# issue 文件所在的目录 (相对于本脚本)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ISSUE_DIR="$DIR/issue"

if [ ! -d "$ISSUE_DIR" ]; then
    echo "错误: 找不到目录 $ISSUE_DIR"
    exit 1
fi

echo "开始读取并提交 $ISSUE_DIR 中的 issue 草稿..."
echo "================================================="

parse_title_from_filename() {
    local filename="$1"
    local name="${filename##*/}"
    local prefix
    local rest

    name="${name%.md}"
    if [[ "$name" == *"-"* ]]; then
        prefix="${name%%-*}"
        rest="${name#*-}"
        rest="${rest//-/ }"
        printf "%s: %s\n" "$prefix" "$rest"
    else
        printf "%s\n" "${name//-/ }"
    fi
}

for file in "$ISSUE_DIR"/*.md; do
    if [ ! -f "$file" ]; then
        echo "没有找到 markdown 文件。"
        break
    fi

    # 文件名由标题 replaceFirst(":", "-").replace(" ", "-") 生成，这里反向解析标题
    TITLE=$(parse_title_from_filename "$file")
    
    # 标题来自文件名，正文保留 markdown 文件完整内容
    BODY=$(cat "$file")

    echo "正在提交: $TITLE"

    # 使用 jq 安全地构建 JSON 载荷
    JSON_PAYLOAD=$(jq -n \
        --arg title "$TITLE" \
        --arg body "$BODY" \
        '{title: $title, body: $body}')

    # 发送请求到 GitHub API
    RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_URL" \
        -H "Authorization: Bearer $GITHUB_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        -d "$JSON_PAYLOAD")

    # 分离响应体和状态码
    HTTP_CODE=$(echo "$RESPONSE" | tail -n 1)
    BODY_RESP=$(echo "$RESPONSE" | sed '$d')

    if [[ "$HTTP_CODE" -eq 201 ]]; then
        ISSUE_URL=$(echo "$BODY_RESP" | jq -r .html_url)
        echo "✅ 成功创建 Issue: $TITLE"
        echo "🔗 链接: $ISSUE_URL"
    else
        echo "❌ 创建失败: $TITLE"
        echo "HTTP 状态码: $HTTP_CODE"
        echo "API 响应: $(echo "$BODY_RESP" | jq -r .message 2>/dev/null || echo "$BODY_RESP")"
    fi
    echo "-------------------------------------------------"
    
    # 稍微暂停一下，避免触发 API 频率限制
    sleep 1
done

echo "执行完毕！"
