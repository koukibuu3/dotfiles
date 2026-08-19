# !/bin/zsh

# Link karabiner_fake_vim_rule.json to ~/.config/karabiner/assets/complex_modifications/
# ハードリンク（ln）ではなくシンボリックリンクを張る。
# ハードリンクだと git pull でリポジトリ側のファイルが差し替わった時点でリンクが切れ、
# 以降 ~/.config 側が古い内容のまま取り残される。

DOTFILES_DIR="$(pwd)"
[ -f "$DOTFILES_DIR/karabiner_fake_vim_rule.json" ] || DOTFILES_DIR="$HOME/dotfiles"

src="$DOTFILES_DIR/karabiner_fake_vim_rule.json"
dest="$HOME/.config/karabiner/assets/complex_modifications/karabiner_fake_vim_rule.json"

mkdir -p "$(dirname "$dest")"

if [ -L "$dest" ]; then
  echo "\033[33m🚧WARNING:\033[0m karabiner_fake_vim_rule.json is already a symlink (-> $(readlink "$dest"))"
elif [ -f "$dest" ] && cmp -s "$src" "$dest"; then
  # 旧方式（ハードリンク）で内容が同一なら、安全にシンボリックリンクへ移行する
  echo "Migrating karabiner_fake_vim_rule.json to a symlink"
  mv "$dest" "$dest.bak"
  ln -s "$src" "$dest"
  echo "\033[32m✅SUCCESS:\033[0m migrated (旧ファイルは $dest.bak)"
elif [ -e "$dest" ]; then
  echo "\033[33m🚧WARNING:\033[0m karabiner_fake_vim_rule.json already exists and differs from dotfiles (手動で確認してください)"
else
  echo "Linking karabiner_fake_vim_rule.json to ~/.config/karabiner/assets/complex_modifications/"
  ln -s "$src" "$dest"
  echo "\033[32m✅SUCCESS:\033[0m karabiner_fake_vim_rule.json linked"
fi
