#!/bin/zsh
# セットアップの新規構築・差分更新を、偽の HOME を使って検証する。
#
#   zsh scripts/ci/verify_setup.sh
#
# 実インストール（brew bundle install / rosetta / anyenv / Claude Code）は行わない。
# 検証するのは「設定の配置」「冪等性」「シンボリックリンクであること」
# 「ログインシェルで brew の PATH が通ること」の4点。
# 過去にこの4点で新規構築が壊れたことがあるため、その回帰テストとして置いている。

set -u

REPO="${0:A:h:h:h}"
WORK="$(mktemp -d)"

pass=0
fail=0

ok() {
  print -r -- "  ✅ $1"
  ((pass++))
}

ng() {
  print -r -- "  ❌ $1"
  ((fail++))
}

# 設定を配置するスクリプト（実インストールを伴わないものだけ）
LINK_SCRIPTS=(
  scripts/zsh/add_custom_config_to_zshrc.sh
  scripts/zsh/add_custom_config_to_zprofile.sh
  scripts/vim/add_custom_config_to_vimrc.sh
  scripts/ghostty/link_ghostty_config.sh
  scripts/zed/link_zed_config.sh
  scripts/karabiner/add_complex_modifications.sh
  scripts/claude/link_claude_config.sh
)

# 配置後にシンボリックリンクであるべきパス（HOME 相対）
LINKED_PATHS=(
  .claude/settings.json
  .claude/statusline-command.sh
  .claude/commands
  .claude/skills
  .claude/CLAUDE.md
  .config/ghostty/config
  .config/zed/settings.json
  .config/karabiner/assets/complex_modifications/karabiner_fake_vim_rule.json
)

run_link_scripts() {
  local home="$1" s
  for s in "${LINK_SCRIPTS[@]}"; do
    (cd "$REPO" && HOME="$home" zsh -c ". $s") 2>&1
  done
}

# ---------------------------------------- #
print -r -- "== 1. 構文チェック =="
# ---------------------------------------- #
for f in "$REPO"/zshrc "$REPO"/zprofile "$REPO"/setup.sh "$REPO"/scripts/*/*.sh; do
  if zsh -n "$f" 2>/dev/null; then
    ok "syntax ${f#$REPO/}"
  else
    ng "syntax ${f#$REPO/}"
  fi
done

# ---------------------------------------- #
print -r -- "== 2. Brewfile =="
# ---------------------------------------- #
if ! command -v brew > /dev/null 2>&1; then
  ng "brew が見つからない（このテストは Homebrew を前提にしている）"
else
  entries="$(brew bundle list --all --file="$REPO/Brewfile" 2>/dev/null | grep -c .)"
  if [ "$entries" -gt 0 ]; then
    ok "Brewfile をパースできる（$entries エントリ）"
  else
    ng "Brewfile をパースできない"
  fi
fi

# ---------------------------------------- #
print -r -- "== 3. 新規構築 =="
# ---------------------------------------- #
FRESH="$WORK/fresh"
mkdir -p "$FRESH"
ln -s "$REPO" "$FRESH/dotfiles" # 新端末で ~/dotfiles を clone した状態を再現

out="$(run_link_scripts "$FRESH")"
if print -r -- "$out" | grep -q 'WARNING'; then
  ng "新規構築で WARNING が出た:"
  print -r -- "$out" | grep 'WARNING' | sed 's/^/       /'
else
  ok "新規構築が警告なしで完了"
fi

for p in "${LINKED_PATHS[@]}"; do
  if [ -L "$FRESH/$p" ]; then
    ok "symlink $p"
  elif [ -e "$FRESH/$p" ]; then
    ng "$p が存在するがシンボリックリンクでない（ハードリンクだと git pull で差分が届かない）"
  else
    ng "$p が作られていない"
  fi
done

for f in .zshrc .zprofile .vimrc; do
  n="$(grep -c 'Custom config' "$FRESH/$f" 2>/dev/null)" || true
  n="${n:-0}"
  [ "$n" = "1" ] && ok "$f の Custom config が1回" || ng "$f の Custom config が $n 回"
done

# ---------------------------------------- #
print -r -- "== 4. 差分更新（再実行の冪等性） =="
# ---------------------------------------- #
out2="$(run_link_scripts "$FRESH")"
warns="$(print -r -- "$out2" | grep -c 'WARNING')"
if [ "$warns" -eq "${#LINKED_PATHS[@]}" ] || [ "$warns" -ge 8 ]; then
  ok "再実行で全件スキップ（WARNING $warns 件）"
else
  ng "再実行時の WARNING が $warns 件しかない（スキップされていない項目がある）"
fi

for f in .zshrc .zprofile .vimrc; do
  n="$(grep -c 'Custom config' "$FRESH/$f" 2>/dev/null)" || true
  n="${n:-0}"
  [ "$n" = "1" ] && ok "$f が再実行後も1回" || ng "$f が再実行後に $n 回に増えた"
done

# ---------------------------------------- #
print -r -- "== 5. ハードリンクからの移行 =="
# ---------------------------------------- #
MIG="$WORK/migrate"
mkdir -p "$MIG/.config/ghostty"
ln "$REPO/ghostty/config" "$MIG/.config/ghostty/config" # 旧方式（ハードリンク）を再現
(cd "$REPO" && HOME="$MIG" zsh -c '. scripts/ghostty/link_ghostty_config.sh') > /dev/null 2>&1
if [ -L "$MIG/.config/ghostty/config" ] && [ -f "$MIG/.config/ghostty/config.bak" ]; then
  ok "既存のハードリンクをシンボリックリンクへ移行し .bak を残す"
else
  ng "ハードリンクからの移行に失敗"
fi

# ---------------------------------------- #
print -r -- "== 6. ログインシェル =="
# ---------------------------------------- #
shell_env="$(env -i HOME="$FRESH" TERM=xterm SHELL=/bin/zsh /bin/zsh -lic '
  print -r -- "HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-}"
  print -r -- "BREW=$(command -v brew || print none)"
  print -r -- "PATH=$PATH"
  print -r -- "ALIAS_DC=$(alias dc 2>/dev/null || print none)"
' 2>/dev/null)"

prefix="$(print -r -- "$shell_env" | sed -n 's/^HOMEBREW_PREFIX=//p')"
[ -n "$prefix" ] && ok "HOMEBREW_PREFIX が設定される（$prefix）" \
  || ng "HOMEBREW_PREFIX が設定されない"

brewpath="$(print -r -- "$shell_env" | sed -n 's/^BREW=//p')"
[ "$brewpath" != "none" ] && ok "brew が PATH で解決できる（$brewpath）" \
  || ng "brew が PATH で解決できない（新端末でセットアップが丸ごとスキップされる）"

pathline="$(print -r -- "$shell_env" | sed -n 's/^PATH=//p')"
if [ -n "$prefix" ] && print -r -- "$pathline" | tr ':' '\n' | grep -qx "$prefix/bin"; then
  ok "PATH に \$HOMEBREW_PREFIX/bin が含まれる"
else
  ng "PATH に \$HOMEBREW_PREFIX/bin が含まれない"
fi

if print -r -- "$pathline" | tr ':' '\n' | grep -q '='; then
  ng "PATH に不正な要素がある（= を含む）"
else
  ok "PATH に不正な要素がない"
fi

dups="$(print -r -- "$pathline" | tr ':' '\n' | sort | uniq -d | wc -l | tr -d ' ')"
[ "$dups" = "0" ] && ok "PATH に重複がない" || ng "PATH に重複が $dups 件ある"

print -r -- "$shell_env" | grep -q "^ALIAS_DC=dc=" \
  && ok "dotfiles/zshrc が読み込まれている（dc エイリアス）" \
  || ng "dotfiles/zshrc が読み込まれていない"

# ---------------------------------------- #
print -r -- ""
print -r -- "== 結果: $pass passed / $fail failed =="
print -r -- "作業ディレクトリ: $WORK"
[ "$fail" -eq 0 ] || exit 1
