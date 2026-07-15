#!/usr/bin/env python3
from __future__ import annotations

import asyncio
import json
import os
import shutil
import uuid
from pathlib import Path
from typing import Any

from mcp.server.fastmcp import FastMCP


mcp = FastMCP(
    "claude-review",
    instructions=(
        "Use claude_start to begin a Claude conversation. "
        "Use claude_reply with the returned session_id and the same cwd "
        "for every follow-up. Do not start a new session unless requested."
    ),
)


def get_claude_bin() -> str:
    claude_bin = os.environ.get("CLAUDE_BIN") or shutil.which("claude")

    if not claude_bin:
        raise RuntimeError(
            "Claude Code CLI was not found. "
            "Set CLAUDE_BIN to the absolute path returned by `command -v claude`."
        )

    return claude_bin


def get_working_directory(cwd: str) -> Path:
    path = Path(cwd).expanduser().resolve()

    if not path.is_dir():
        raise ValueError(f"cwd is not a directory: {path}")

    return path


def compact_result(
    payload: dict[str, Any],
    session_id: str,
    cwd: Path,
) -> dict[str, Any]:
    """
    Return only fields Codex needs.

    Avoid returning Claude's full event stream because that wastes
    Codex context tokens.
    """
    return {
        "session_id": (
            payload.get("session_id")
            or payload.get("sessionId")
            or session_id
        ),
        "result": payload.get("result") or payload.get("message") or "",
        "partial_result_recovered": payload.get(
            "partial_result_recovered",
            False,
        ),
        "is_error": payload.get("is_error"),
        "api_error_status": payload.get("api_error_status"),
        "terminal_reason": payload.get("terminal_reason"),
        "stop_reason": payload.get("stop_reason"),
        "subtype": payload.get("subtype"),
        "usage": payload.get("usage"),
        "model_usage": (
            payload.get("modelUsage")
            or payload.get("model_usage")
        ),
        "total_cost_usd": (
            payload.get("total_cost_usd")
            or payload.get("totalCostUSD")
        ),
        "cwd": str(cwd),
    }


def parse_stream_payload(stdout_text: str) -> dict[str, Any]:
    """
    Extract the final result and recover text emitted before a turn limit.

    Claude can emit a useful text block and then call a tool such as
    ExitPlanMode. With max_turns exhausted, the final result is empty even
    though the preceding assistant event contains the response.
    """
    result_payload: dict[str, Any] | None = None
    assistant_texts: list[str] = []

    for line_number, line in enumerate(stdout_text.splitlines(), start=1):
        if not line.strip():
            continue

        try:
            event = json.loads(line)
        except json.JSONDecodeError as exc:
            raise ValueError(
                f"Claude returned invalid stream JSON on line {line_number}"
            ) from exc

        if event.get("type") == "assistant":
            message = event.get("message") or {}

            for content in message.get("content") or []:
                text = content.get("text")

                if content.get("type") == "text" and text:
                    assistant_texts.append(text)

        if event.get("type") == "result":
            result_payload = event

    if result_payload is None:
        raise ValueError("Claude stream did not contain a result event")

    if not result_payload.get("result") and assistant_texts:
        # Preserve the model's already-emitted response without converting
        # error_max_turns into a false success.
        result_payload["result"] = "\n\n".join(assistant_texts)
        result_payload["partial_result_recovered"] = True

    return result_payload


async def invoke_claude(
    *,
    prompt: str,
    cwd: str,
    session_id: str,
    resume: bool,
    model: str | None,
    effort: str,
    permission_mode: str,
    max_turns: int,
    tools: str,
    timeout_seconds: int,
) -> dict[str, Any]:
    workdir = get_working_directory(cwd)

    if not 1 <= max_turns <= 100:
        raise ValueError("max_turns must be between 1 and 100")

    command = [
        get_claude_bin(),
        "-p",
        "--output-format",
        "stream-json",
        "--verbose",
        "--effort",
        effort,
        "--permission-mode",
        permission_mode,
        "--max-turns",
        str(max_turns),

        # Do not load Claude's configured MCP servers.
        # This reduces unnecessary tool schemas and avoids recursion.
        "--strict-mcp-config",

        # Default is read-only repository inspection.
        "--tools",
        tools,
    ]

    if model:
        command.extend(["--model", model])

    if resume:
        command.extend(["--resume", session_id])
    else:
        command.extend(["--session-id", session_id])

    command.append(prompt)

    process = await asyncio.create_subprocess_exec(
        *command,
        cwd=str(workdir),
        # Claude inspects piped stdin even when a positional prompt is given.
        # Close stdin explicitly so it does not wait for the MCP transport.
        stdin=asyncio.subprocess.DEVNULL,
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.PIPE,
    )

    try:
        stdout, stderr = await asyncio.wait_for(
            process.communicate(),
            timeout=timeout_seconds,
        )
    except asyncio.TimeoutError:
        process.kill()
        await process.wait()
        raise RuntimeError(
            f"Claude timed out after {timeout_seconds} seconds"
        )

    stdout_text = stdout.decode(
        "utf-8",
        errors="replace",
    ).strip()

    stderr_text = stderr.decode(
        "utf-8",
        errors="replace",
    ).strip()

    try:
        payload = parse_stream_payload(stdout_text)
    except ValueError as exc:
        if process.returncode != 0:
            error_text = stderr_text or stdout_text or "No output"

            raise RuntimeError(
                f"Claude exited with code {process.returncode}: "
                f"{error_text[:4000]}"
            ) from exc

        raise RuntimeError(
            f"Claude returned invalid JSON: {stdout_text[:4000]}"
        ) from exc

    result = compact_result(
        payload=payload,
        session_id=session_id,
        cwd=workdir,
    )

    if stderr_text:
        result["warning"] = stderr_text[:2000]

    if process.returncode != 0:
        result["exit_code"] = process.returncode

    return result


@mcp.tool()
async def claude_start(
    prompt: str,
    cwd: str,
    model: str = "sonnet",
    effort: str = "high",
    permission_mode: str = "plan",
    max_turns: int = 8,
    tools: str = "Read,Grep,Glob",
    timeout_seconds: int = 1800,
) -> dict[str, Any]:
    """
    Start a new Claude conversation.

    model accepts aliases such as opus, sonnet, haiku, and fable,
    or a full model ID.
    """
    session_id = str(uuid.uuid4())

    return await invoke_claude(
        prompt=prompt,
        cwd=cwd,
        session_id=session_id,
        resume=False,
        model=model,
        effort=effort,
        permission_mode=permission_mode,
        max_turns=max_turns,
        tools=tools,
        timeout_seconds=timeout_seconds,
    )


@mcp.tool()
async def claude_reply(
    session_id: str,
    prompt: str,
    cwd: str,
    model: str | None = None,
    effort: str = "high",
    permission_mode: str = "plan",
    max_turns: int = 8,
    tools: str = "Read,Grep,Glob",
    timeout_seconds: int = 1800,
) -> dict[str, Any]:
    """
    Continue an existing Claude conversation.

    Use the same cwd as claude_start.

    Omit model to continue with the model used by the previous turn.
    Pass a model to switch or explicitly pin it.
    """
    return await invoke_claude(
        prompt=prompt,
        cwd=cwd,
        session_id=session_id,
        resume=True,
        model=model,
        effort=effort,
        permission_mode=permission_mode,
        max_turns=max_turns,
        tools=tools,
        timeout_seconds=timeout_seconds,
    )


if __name__ == "__main__":
    mcp.run(transport="stdio")
