# !/bin/zsh

# Link zed/* to ~/.config/zed/
# zed/ に置いたファイルをそのまま ~/.config/zed/ へシンボリックリンクする。
# keymap.json などを追加したくなったら zed/ に置くだけでよい。
#
# 同期しないもの:
#   - prompts/  … LMDB のバイナリDB（data.mdb / lock.mdb）。git 管理に向かない
#   - ~/Library/Application Support/Zed  … DB・ログ・拡張の実体。端末ローカル
#
# 注意: Zed が設定を書き戻す際にファイルを差し替える（symlink を通常ファイルに
# 置き換える）実装だった場合、以降 dotfiles 側に差分が現れなくなる。
# その場合は再実行時に「differs」警告が出るので気づける。

DOTFILES_DIR="$(pwd)"
[ -d "$DOTFILES_DIR/zed" ] || DOTFILES_DIR="$HOME/dotfiles"

dest_dir="$HOME/.config/zed"
mkdir -p "$dest_dir"

for src in "$DOTFILES_DIR"/zed/*; do
  [ -f "$src" ] || continue
  name="$(basename "$src")"
  dest="$dest_dir/$name"

  if [ -L "$dest" ]; then
    echo "\033[33m🚧WARNING:\033[0m $name is already a symlink in ~/.config/zed/ (-> $(readlink "$dest"))"
  elif [ -f "$dest" ] && cmp -s "$src" "$dest"; then
    # 内容が同一なら安全にシンボリックリンクへ移行する
    echo "Migrating ~/.config/zed/$name to a symlink"
    mv "$dest" "$dest.bak"
    ln -s "$src" "$dest"
    echo "\033[32m✅SUCCESS:\033[0m migrated (旧ファイルは $dest.bak)"
  elif [ -e "$dest" ]; then
    echo "\033[33m🚧WARNING:\033[0m $name already exists in ~/.config/zed/ and differs from dotfiles (手動で確認してください)"
  else
    echo "Linking zed/$name to ~/.config/zed/$name"
    ln -s "$src" "$dest"
    echo "\033[32m✅SUCCESS:\033[0m ~/.config/zed/$name linked"
  fi
done
