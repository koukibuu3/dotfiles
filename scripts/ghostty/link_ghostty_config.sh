# !/bin/zsh

# Link ghostty/config to ~/.config/ghostty/
# ハードリンク（ln）ではなくシンボリックリンクを張る。
# ハードリンクだと git pull でリポジトリ側のファイルが差し替わった時点でリンクが切れ、
# 以降 ~/.config 側が古い内容のまま取り残される。

DOTFILES_DIR="$(pwd)"
[ -f "$DOTFILES_DIR/ghostty/config" ] || DOTFILES_DIR="$HOME/dotfiles"

src="$DOTFILES_DIR/ghostty/config"
dest="$HOME/.config/ghostty/config"

mkdir -p "$(dirname "$dest")"

if [ -L "$dest" ]; then
  echo "\033[33m🚧WARNING:\033[0m config is already a symlink in ~/.config/ghostty/ (-> $(readlink "$dest"))"
elif [ -f "$dest" ] && cmp -s "$src" "$dest"; then
  # 旧方式（ハードリンク）で内容が同一なら、安全にシンボリックリンクへ移行する
  echo "Migrating ~/.config/ghostty/config to a symlink"
  mv "$dest" "$dest.bak"
  ln -s "$src" "$dest"
  echo "\033[32m✅SUCCESS:\033[0m migrated (旧ファイルは $dest.bak)"
elif [ -e "$dest" ]; then
  echo "\033[33m🚧WARNING:\033[0m config already exists in ~/.config/ghostty/ and differs from dotfiles (手動で確認してください)"
else
  echo "Linking ghostty/config to ~/.config/ghostty/config"
  ln -s "$src" "$dest"
  echo "\033[32m✅SUCCESS:\033[0m config linked to ~/.config/ghostty/"
fi
