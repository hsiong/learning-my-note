# Multi-Agent Orchestration

## Project Overview
This project is a research and implementation workspace for **multi-agent orchestration workflows**. It focuses on integrating **Codex** (via the Model Context Protocol - MCP) into **Antigravity** (a Gemini CLI environment) to facilitate complex, iterative collaborative tasks between AI agents.

The core objective is to move beyond single-turn interactions by establishing a "Plan -> Review -> Refine" loop, where a host agent (Antigravity) manages and critiques the outputs of specialized agents (like Codex) to achieve high-quality results in domains like financial analysis and market forecasting.

## Directory Structure
- **`codex-antigravity/`**: Contains technical documentation and configuration snippets for setting up the MCP bridge between Codex and Antigravity.

## Key Technologies & Tools
- **Model Context Protocol (MCP)**: Used as the standard for connecting AI models to external tools and enabling inter-agent communication.
- **Antigravity**: The orchestration environment (likely the Gemini CLI) that initiates tasks and performs peer review.
- **Codex (OpenAI)**: The specialized reasoning engine accessed via MCP.
- **Financial MCP Servers**: Integrated tools like `LongPort`, `Octagon`, `Stripe`, and `CoinMarket` for accessing real-time market data.

## Orchestration Workflow
The project implements a structured iterative refinement process:
1. **Initiation**: Launch a new session with a specialized agent (e.g., `codex-local`) using a task-specific prompt (like `task/finance/prompt/init.md`).
2. **Identification**: Capture the `threadId` from the initial response to maintain conversational context.
3. **Iterative Review**:
    - Host agent analyzes the proposed solution.
    - Host agent generates critical feedback or modification requests.
    - Feedback is sent back to the same `threadId` using the `codex-reply` tool.
4. **Final Output**: After a set number of rounds (e.g., 4 rounds), the workflow produces a complete transcript, a validated final plan, identified points of disagreement, and a risk assessment.

## Setup Instructions
Refer to `codex-antigravity/codex-antigravity.md` for details on:
- Starting the `codex mcp-server`.
- Configuring the `mcp_config.json` in `~/.gemini/antigravity/`.
- Utilizing the `codex` and `codex-reply` tools for session management.

# 任务要求
+ 禁止你访问 task/* 目录
+ 提交严格按照 commit english skill 要求