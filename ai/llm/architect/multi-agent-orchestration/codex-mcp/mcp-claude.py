#!/usr/bin/env python3
from __future__ import annotations

import asyncio
import json
import os
import shutil
import uuid
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

from mcp.server.fastmcp import FastMCP


mcp = FastMCP(
    "claude-review",
    instructions=(
        "Use claude_start to begin a Claude conversation. "
        "Use claude_stream_start, claude_stream_poll, and "
        "claude_stream_result when incremental output is useful. "
        "Use claude_reply with the returned session_id and the same cwd "
        "for every follow-up. Do not start a new session unless requested."
    ),
)


@dataclass
class ClaudeStreamTask:
    """Keep the unread text and final result for one streaming invocation."""

    task_id: str
    session_id: str
    cwd: Path
    status: str = "running"
    unread_text: list[str] = field(default_factory=list)
    saw_text_delta: bool = False
    result: dict[str, Any] | None = None
    error: str | None = None
    process: asyncio.subprocess.Process | None = None
    runner: asyncio.Task[None] | None = None


stream_tasks: dict[str, ClaudeStreamTask] = {}


def get_claude_bin() -> str:
    """Return the configured Claude CLI path or fail before launching a task."""
    claude_bin = os.environ.get("CLAUDE_BIN") or shutil.which("claude")

    if not claude_bin:
        raise RuntimeError(
            "Claude Code CLI was not found. "
            "Set CLAUDE_BIN to the absolute path returned by `command -v claude`."
        )

    return claude_bin


def get_working_directory(cwd: str) -> Path:
    """Resolve cwd and reject paths that cannot host a Claude invocation."""
    path = Path(cwd).expanduser().resolve()

    if not path.is_dir():
        raise ValueError(f"cwd is not a directory: {path}")

    return path


def build_claude_command(
    *,
    prompt: str,
    session_id: str,
    resume: bool,
    model: str | None,
    effort: str,
    permission_mode: str,
    max_turns: int,
    tools: str,
    include_partial_messages: bool = False,
) -> list[str]:
    """Build the shared Claude command for synchronous and streaming calls."""
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

    if include_partial_messages:
        command.append("--include-partial-messages")

    if model:
        command.extend(["--model", model])

    if resume:
        command.extend(["--resume", session_id])
    else:
        command.extend(["--session-id", session_id])

    command.append(prompt)

    return command


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
    """Run Claude synchronously and return the existing compact result."""
    workdir = get_working_directory(cwd)
    command = build_claude_command(
        prompt=prompt,
        session_id=session_id,
        resume=resume,
        model=model,
        effort=effort,
        permission_mode=permission_mode,
        max_turns=max_turns,
        tools=tools,
    )

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


async def read_stream_output(
    process: asyncio.subprocess.Process,
    stream_task: ClaudeStreamTask,
) -> str:
    """Read Claude events and append only newly emitted text to the task."""
    if process.stdout is None:
        raise RuntimeError("Claude stdout is not available")

    stdout_lines: list[str] = []

    while True:
        stdout_line = await process.stdout.readline()

        if not stdout_line:
            break

        line_text = stdout_line.decode(
            "utf-8",
            errors="replace",
        ).strip()

        if not line_text:
            continue

        stdout_lines.append(line_text)

        try:
            event = json.loads(line_text)
        except json.JSONDecodeError:
            # Preserve the complete output so the existing parser can produce
            # the same detailed invalid-JSON error after the process exits.
            continue

        if event.get("type") == "stream_event":
            stream_event = event.get("event") or {}
            delta = stream_event.get("delta") or {}
            text_delta = delta.get("text")

            if (
                stream_event.get("type") == "content_block_delta"
                and delta.get("type") == "text_delta"
                and text_delta
            ):
                stream_task.unread_text.append(text_delta)
                stream_task.saw_text_delta = True

        if event.get("type") == "assistant" and not stream_task.saw_text_delta:
            message = event.get("message") or {}

            for content in message.get("content") or []:
                assistant_text = content.get("text")

                if content.get("type") == "text" and assistant_text:
                    stream_task.unread_text.append(assistant_text)

    await process.wait()

    return "\n".join(stdout_lines).strip()


async def run_stream_claude(
    *,
    stream_task: ClaudeStreamTask,
    command: list[str],
    timeout_seconds: int,
) -> None:
    """Run one background Claude process and store its terminal result."""
    stderr_reader: asyncio.Task[bytes] | None = None

    try:
        process = await asyncio.create_subprocess_exec(
            *command,
            cwd=str(stream_task.cwd),
            stdin=asyncio.subprocess.DEVNULL,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
        )
        stream_task.process = process

        if process.stderr is None:
            raise RuntimeError("Claude stderr is not available")

        stderr_reader = asyncio.create_task(process.stderr.read())

        try:
            stdout_text = await asyncio.wait_for(
                read_stream_output(
                    process=process,
                    stream_task=stream_task,
                ),
                timeout=timeout_seconds,
            )
        except asyncio.TimeoutError as exc:
            raise RuntimeError(
                f"Claude timed out after {timeout_seconds} seconds"
            ) from exc

        stderr = await stderr_reader
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
            session_id=stream_task.session_id,
            cwd=stream_task.cwd,
        )

        if stderr_text:
            result["warning"] = stderr_text[:2000]

        if process.returncode != 0:
            result["exit_code"] = process.returncode

        stream_task.result = result
        stream_task.status = "completed"
    except asyncio.CancelledError:
        stream_task.error = "Claude stream task was cancelled"
        stream_task.status = "failed"
        raise
    except Exception as exc:
        stream_task.error = str(exc)
        stream_task.status = "failed"
    finally:
        process = stream_task.process

        if process is not None and process.returncode is None:
            process.kill()
            await process.wait()

        if stderr_reader is not None and not stderr_reader.done():
            stderr_reader.cancel()

            try:
                await stderr_reader
            except asyncio.CancelledError:
                pass

        stream_task.process = None


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
async def claude_stream_start(
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
    Start a Claude conversation in the background.

    Poll task_id for unread text, then request the final result.
    """
    session_id = str(uuid.uuid4())
    task_id = str(uuid.uuid4())
    workdir = get_working_directory(cwd)
    command = build_claude_command(
        prompt=prompt,
        session_id=session_id,
        resume=False,
        model=model,
        effort=effort,
        permission_mode=permission_mode,
        max_turns=max_turns,
        tools=tools,
        include_partial_messages=True,
    )
    stream_task = ClaudeStreamTask(
        task_id=task_id,
        session_id=session_id,
        cwd=workdir,
    )
    stream_tasks[task_id] = stream_task
    stream_task.runner = asyncio.create_task(
        run_stream_claude(
            stream_task=stream_task,
            command=command,
            timeout_seconds=timeout_seconds,
        )
    )

    return {
        "task_id": task_id,
        "session_id": session_id,
        "status": stream_task.status,
        "cwd": str(workdir),
    }


@mcp.tool()
async def claude_stream_poll(task_id: str) -> dict[str, Any]:
    """Return and consume text emitted since the previous poll."""
    stream_task = stream_tasks.get(task_id)

    if stream_task is None:
        raise ValueError(f"Unknown Claude stream task: {task_id}")

    unread_text = "".join(stream_task.unread_text)
    stream_task.unread_text.clear()
    response = {
        "task_id": task_id,
        "session_id": stream_task.session_id,
        "status": stream_task.status,
        "text": unread_text,
    }

    if stream_task.error:
        response["error"] = stream_task.error

    return response


@mcp.tool()
async def claude_stream_result(task_id: str) -> dict[str, Any]:
    """Wait for a stream task and return its final compact result once."""
    stream_task = stream_tasks.get(task_id)

    if stream_task is None:
        raise ValueError(f"Unknown Claude stream task: {task_id}")

    runner = stream_task.runner

    if runner is not None:
        # A caller cancelling this request must not cancel the Claude process.
        await asyncio.shield(runner)

    stream_tasks.pop(task_id, None)

    if stream_task.error:
        raise RuntimeError(stream_task.error)

    if stream_task.result is None:
        raise RuntimeError("Claude stream task finished without a result")

    return {
        "task_id": task_id,
        "status": stream_task.status,
        **stream_task.result,
    }


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
