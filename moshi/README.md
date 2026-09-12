# moshi

Moshi (getmoshi.app) 関連の hooks。`setup.sh` が `~/.config/moshi/hooks` をこのディレクトリの `hooks/` に symlink する。

## hooks/notify-complete.py

Claude Code / Codex の Stop hook から Moshi の webhook API を叩き、応答完了をプッシュ通知（バナー）にする。
Moshi 標準の hook は iOS では完了を Live Activity の更新にしかしないため、その補完。

通知内容: プロジェクト名とブランチ、セッションタイトル（Claude のみ）、最後のプロンプト、最後の応答の先頭、所要時間、モデル。
Herdr か tmux の中で動いていれば、通知タップでそのセッションを開くディープリンクが付く。

### 前提

- `~/.config/moshi/webhook-token` に Moshi アプリの Settings → Push Notifications に表示される API トークンを 1 行で置く（`chmod 600`）。
  このファイルが無いマシンでは何もせず終了する。
- Python 3 のみ。外部コマンドは `git` と（tmux 内なら）`tmux`。

### 登録

Claude Code: `~/.claude/settings.json` の `hooks.Stop` に追加。

```json
{"type": "command", "command": "python3 \"$HOME\"/.config/moshi/hooks/notify-complete.py --agent claude", "async": true, "timeout": 15}
```

Codex: `~/.codex/hooks.json` の `hooks.Stop` に追加（`[features] hooks = true` が必要）。

```json
{"type": "command", "command": "python3 \"$HOME\"/.config/moshi/hooks/notify-complete.py --agent codex", "async": true, "timeout": 15}
```

### 送信に失敗したとき

送信エラーは hook を失敗させず、`~/.local/state/moshi/notify-complete.log` に 1 行ずつ残す。
API の前段は Cloudflare で、User-Agent が無い（Python 標準の）リクエストは 403 になるため、スクリプト側で独自の User-Agent を付けている。

### 動作確認

送らずに内容だけ見る。

```sh
printf '{"cwd":"%s","transcript_path":"<transcript.jsonl>"}' "$PWD" \
  | python3 ~/.config/moshi/hooks/notify-complete.py --agent claude --dry-run
```
