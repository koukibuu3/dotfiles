# !/bin/zsh

# Link claude/* to ~/.claude/
# 実体は dotfiles 側に置き、~/.claude からシンボリックリンクを張る。
# こうすると Claude Code 側で編集した内容がそのまま dotfiles の作業ツリーに現れる。

DOTFILES_DIR="$(pwd)"
[ -d "$DOTFILES_DIR/claude" ] || DOTFILES_DIR="$HOME/dotfiles"

mkdir -p ~/.claude

# link_claude_entry <claude/ 配下の名前> [~/.claude/ 側の名前]
# 第2引数を省略した場合は同名でリンクする。
link_claude_entry() {
  src="$DOTFILES_DIR/claude/$1"
  name="${2:-$1}"
  dest="$HOME/.claude/$name"

  if [ -L "$dest" ]; then
    echo "\033[33m🚧WARNING:\033[0m $name is already a symlink in ~/.claude/ (-> $(readlink "$dest"))"
    return
  fi

  if [ -e "$dest" ]; then
    echo "\033[33m🚧WARNING:\033[0m $name already exists in ~/.claude/ (移動またはリネームしてから再実行してください)"
    return
  fi

  echo "Linking claude/$1 to ~/.claude/$name"
  ln -s "$src" "$dest"
  echo "\033[32m✅SUCCESS:\033[0m ~/.claude/$name linked"
}

link_claude_entry settings.json
link_claude_entry statusline-command.sh
link_claude_entry commands
link_claude_entry skills

# グローバルの指示ファイルは CLAUDE.md しか読まれない（AGENTS.md は user スコープでは無視される）。
# リポジトリ側と同じく実体を AGENTS.md にしておき、CLAUDE.md という名前でリンクする。
link_claude_entry AGENTS.md CLAUDE.md
