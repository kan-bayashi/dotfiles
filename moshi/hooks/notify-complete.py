#!/usr/bin/env python3
"""Stop hook for Claude Code / Codex: push a completion banner via the Moshi webhook API.

Moshi's own hook turns task completion into an iOS Live Activity update only.
This script adds a regular push banner with a short summary of the turn.

Usage (from the agent's Stop hook, JSON on stdin):
    notify-complete.py --agent claude
    notify-complete.py --agent codex
    notify-complete.py --agent claude --dry-run   # print payload, do not send

Token: first line of ~/.config/moshi/webhook-token (kept out of dotfiles).
"""

import argparse
import json
import os
import subprocess
import sys
import urllib.error
import urllib.request
from datetime import datetime, timezone
from pathlib import Path

WEBHOOK_URL = "https://api.getmoshi.app/api/webhook"
USER_AGENT = "moshi-notify-complete/1.0"
TOKEN_FILE = Path.home() / ".config" / "moshi" / "webhook-token"
LOG_FILE = Path.home() / ".local" / "state" / "moshi" / "notify-complete.log"
AGENT_LABEL = {"claude": "Claude Code", "codex": "Codex"}
PROMPT_MAX = 60
RESULT_MAX = 160


def read_token() -> str:
    try:
        return TOKEN_FILE.read_text(encoding="utf-8").splitlines()[0].strip()
    except (OSError, IndexError):
        return ""


def read_stdin_json() -> dict:
    try:
        return json.loads(sys.stdin.read() or "{}")
    except json.JSONDecodeError:
        return {}


def parse_ts(value):
    if not value:
        return None
    try:
        return datetime.fromisoformat(str(value).replace("Z", "+00:00"))
    except ValueError:
        return None


def iter_jsonl(path):
    try:
        with open(path, encoding="utf-8") as fh:
            for line in fh:
                line = line.strip()
                if not line:
                    continue
                try:
                    yield json.loads(line)
                except json.JSONDecodeError:
                    continue
    except OSError:
        return


def one_line(text: str, limit: int) -> str:
    text = " ".join(text.split())
    return text if len(text) <= limit else text[: limit - 1] + "…"


def strip_preamble(text: str) -> str:
    """Drop the fixed CLAUDE.md preamble so the result line shows real content."""
    marker = "[main_output]"
    if marker in text:
        text = text.split(marker, 1)[1]
    return text.strip()


def git_branch(cwd: str) -> str:
    try:
        out = subprocess.run(
            ["git", "-C", cwd, "rev-parse", "--abbrev-ref", "HEAD"],
            capture_output=True, text=True, timeout=3,
        )
        return out.stdout.strip() if out.returncode == 0 else ""
    except (OSError, subprocess.SubprocessError):
        return ""


def summarize_claude(hook: dict) -> dict:
    """Pull title, last prompt, last assistant text and timing from the Claude transcript."""
    info = {"title": "", "prompt": "", "prompt_ts": None, "result": "", "model": ""}
    for row in iter_jsonl(hook.get("transcript_path", "")):
        kind = row.get("type")
        msg = row.get("message") or {}
        if kind == "ai-title":
            info["title"] = row.get("aiTitle", "")
        elif kind == "user" and isinstance(msg.get("content"), str):
            info["prompt"] = msg["content"]
            info["prompt_ts"] = parse_ts(row.get("timestamp"))
        elif kind == "assistant":
            info["model"] = msg.get("model") or info["model"]
            content = msg.get("content")
            if isinstance(content, list):
                texts = [c.get("text", "") for c in content if c.get("type") == "text"]
                if texts and texts[-1].strip():
                    info["result"] = texts[-1]
    info["result"] = strip_preamble(info["result"])
    return info


def summarize_codex(hook: dict) -> dict:
    """Codex hands us the last assistant message; the rollout file gives the prompt and timing."""
    info = {"title": "", "prompt": "", "prompt_ts": None,
            "result": hook.get("last_assistant_message") or "", "model": hook.get("model", "")}
    for row in iter_jsonl(hook.get("transcript_path") or ""):
        payload = row.get("payload") or {}
        if row.get("type") == "response_item" and payload.get("type") == "message" \
                and payload.get("role") == "user":
            texts = [c.get("text", "") for c in payload.get("content", [])
                     if c.get("type") == "input_text"]
            if texts:
                info["prompt"] = texts[-1]
                info["prompt_ts"] = parse_ts(row.get("timestamp"))
    return info


def format_duration(start) -> str:
    if not start:
        return ""
    seconds = int((datetime.now(timezone.utc) - start).total_seconds())
    if seconds < 0:
        return ""
    minutes, sec = divmod(seconds, 60)
    hours, minutes = divmod(minutes, 60)
    if hours:
        return f"{hours}時間{minutes}分"
    if minutes:
        return f"{minutes}分{sec}秒"
    return f"{sec}秒"


def deep_link():
    workspace = os.environ.get("HERDR_WORKSPACE_ID")
    if workspace:
        url = f"moshi://herdr?workspace={workspace}"
        if os.environ.get("HERDR_TAB_ID"):
            url += f"&tab={os.environ['HERDR_TAB_ID']}"
        if os.environ.get("HERDR_PANE_ID"):
            url += f"&pane={os.environ['HERDR_PANE_ID']}"
        return {"type": "url", "url": url}
    if os.environ.get("TMUX"):
        try:
            session = subprocess.run(["tmux", "display-message", "-p", "#S"],
                                     capture_output=True, text=True, timeout=3).stdout.strip()
        except (OSError, subprocess.SubprocessError):
            session = ""
        if session:
            return {"type": "url", "url": f"moshi://tmux?session={session}"}
    return None


def build_payload(agent: str, hook: dict, token: str) -> dict:
    cwd = hook.get("cwd") or os.getcwd()
    project = os.path.basename(cwd.rstrip("/")) or cwd
    info = summarize_claude(hook) if agent == "claude" else summarize_codex(hook)

    header = project
    branch = git_branch(cwd)
    if branch:
        header += f" ({branch})"
    title = f"{header} · {AGENT_LABEL.get(agent, agent)} 完了"

    lines = []
    if info["title"]:
        lines.append(one_line(info["title"], PROMPT_MAX))
    if info["prompt"]:
        lines.append("Q: " + one_line(info["prompt"], PROMPT_MAX))
    if info["result"]:
        lines.append("A: " + one_line(info["result"], RESULT_MAX))
    footer = [p for p in (format_duration(info["prompt_ts"]), info["model"]) if p]
    if footer:
        lines.append(" · ".join(footer))
    message = "\n".join(lines) or "応答が完了しました"

    payload = {"token": token, "title": title, "message": message, "unified": True}
    link = deep_link()
    if link:
        payload["data"] = link
    return payload


def log_failure(reason: str) -> None:
    try:
        LOG_FILE.parent.mkdir(parents=True, exist_ok=True)
        with open(LOG_FILE, "a", encoding="utf-8") as fh:
            fh.write(f"{datetime.now().isoformat(timespec='seconds')} {reason}\n")
    except OSError:
        pass


def send(payload: dict) -> None:
    body = json.dumps(payload, ensure_ascii=False).encode("utf-8")
    # Cloudflare in front of the API rejects Python's default User-Agent with 403 (error 1010).
    headers = {"Content-Type": "application/json", "User-Agent": USER_AGENT}
    req = urllib.request.Request(WEBHOOK_URL, data=body, headers=headers, method="POST")
    try:
        urllib.request.urlopen(req, timeout=5).read()
    except urllib.error.HTTPError as exc:
        log_failure(f"HTTP {exc.code}: {exc.read(200)!r}")
    except Exception as exc:  # never fail the agent's hook because of a push
        log_failure(f"{type(exc).__name__}: {exc}")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--agent", choices=sorted(AGENT_LABEL), required=True)
    parser.add_argument("--dry-run", action="store_true", help="print the payload instead of sending")
    args = parser.parse_args()

    token = read_token()
    if not token and not args.dry_run:
        return 0
    hook = read_stdin_json()
    if hook.get("stop_hook_active"):
        return 0
    payload = build_payload(args.agent, hook, token or "<no token>")
    if args.dry_run:
        shown = dict(payload, token="***")
        print(json.dumps(shown, ensure_ascii=False, indent=2))
        return 0
    send(payload)
    return 0


if __name__ == "__main__":
    sys.exit(main())
