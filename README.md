# README

## Quick Start

```sh
sh setup.sh
```

## zsh

`~/.zshrc` と `~/.zprofile` はツール（Kiro CLI / Docker / OrbStack / Ghostty）が
自動追記するため実体はホームに残し、dotfiles 側のファイルを source する形で共有している。

| 置き場所 | 内容 |
| --- | --- |
| `zshrc`（共有） | alias、`setopt`、履歴設定、starship / anyenv の init |
| `zprofile`（共有） | PATH の追加 |
| `~/.zshrc.local`（**git 管理しない**） | トークンなどの秘密情報 |
| `~/.zshrc` / `~/.zprofile`（未管理） | ツールの自動追記分と、上記を source する行 |

### PATH は zprofile に置く

`zshrc` は対話シェルごとに再評価されるため、PATH の追加を `zshrc` に書くと
ネストしたシェルで要素が増え続ける。ログイン時1回だけ評価される `zprofile` に置き、
あわせて `typeset -U path PATH` で重複を除去している。

`zprofile` は `HOMEBREW_PREFIX` を使うので、`~/.zprofile` 側の
`eval "$(brew shellenv)"` より後に source する必要がある。

### 秘密情報

`~/.zshrc.local` に置き、`~/.zshrc` から source する。
このリポジトリには持ち込まない（`.gitignore` にも保険として入れてある）。

## Claude Code

`claude/` 配下に実体を置き、`~/.claude/` からシンボリックリンクを張って共有している。
Claude Code 側で skills や settings を編集すると、そのまま `claude/` の作業ツリーに差分として現れるので、
`git commit` するだけで他端末に引き継げる。

| dotfiles | リンク先 |
| --- | --- |
| `claude/settings.json` | `~/.claude/settings.json` |
| `claude/statusline-command.sh` | `~/.claude/statusline-command.sh` |
| `claude/commands/` | `~/.claude/commands` |
| `claude/skills/` | `~/.claude/skills` |
| `claude/AGENTS.md` | `~/.claude/CLAUDE.md` |

CLI（`~/.local/share/claude/`）とデスクトップアプリ同梱版
（`~/Library/Application Support/Claude/claude-code/`）は別バイナリだが、
どちらも `~/.claude/` を読み、シンボリックリンクも辿る。

### グローバルの指示ファイル

実体は `claude/AGENTS.md` だが、リンク名は `CLAUDE.md` にしている。
**user スコープでは `CLAUDE.md` しか読まれず、`~/.claude/AGENTS.md` は無視される**ため
（リポジトリ側と違い `AGENTS.md` はフォールバックされない）、リポジトリと同じ流儀で
実体を `AGENTS.md` に置き、名前だけ `CLAUDE.md` に見せている。

グローバルなので**全プロジェクトに効く**。プロジェクト固有の構成・コマンド・
アーキテクチャは書かず、各リポジトリの `AGENTS.md` / `CLAUDE.md` に残す。

プラグインは `claude/settings.json` の `enabledPlugins` が有効化状態を持ち、
取得元の marketplace 登録とインストールは `scripts/claude/install_plugins.sh` が再現する。

### 管理しないもの

`~/.claude.json` は OAuth アカウント、machineID、全プロジェクトの履歴に加えて、
`mcpServers` の認証情報を **平文** で持つため、リポジトリには含めない。
`~/.claude/` 配下の `history.jsonl` / `projects/` / `sessions/` / `session-env/` /
`shell-snapshots/` / `security/` / `backups/` / `cache/` / `plugins/` も端末ローカルの状態なので対象外。

### 新しい端末でのセットアップ

1. Claude Code をインストールして `claude` にログインする
2. `cp .env.local.example .env.local` して、1Password などから認証情報を埋める
3. MCP サーバーを使う場合は `anyinc/dev-mcp-servers` を clone してビルドしておく
4. `sh setup.sh` を実行する

`.env.local` は `.gitignore` 対象。ここに実値を書き、リポジトリには `.env.local.example` だけを置く。

### MCP の認証情報をローテートしたとき

`.env.local` を書き換えたうえで、`--force` を付けて再登録する。
`--force` なしだと登録済みのサーバーはスキップされるため、`~/.claude.json` 側が古い値のまま残る。

```sh
cd ~/dotfiles && zsh scripts/claude/setup_mcp.sh --force
```

`CLAUDE_MCP_FORCE=1` でも同じ。`setup.sh` 経由でまとめて流したい場合はこちらを使う。

### なぜ ~/.claude.json に実値を書いているのか

Claude Code は MCP の `env` に書いた `${VAR}` を起動時に展開するが、展開元は
**親プロセスの環境変数**か **`settings.json` の `env`** に限られる（`~/.claude/settings.local.json` は
user スコープでは読まれない）。前者はデスクトップアプリからの起動が zshrc を経由しないため効かず、
後者はコミット対象のファイルなので秘密を置けない。
また変数が未設定でもエラーにならずリテラル `${VAR}` がそのまま渡るため、失敗が分かりにくい。

よって `${VAR}` 参照は採らず、`.env.local` を単一の正として `~/.claude.json` に実値を流し込む方式にしている。
