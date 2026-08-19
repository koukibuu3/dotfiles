# !/bin/zsh

# Add custom config to zprofile if not already present
# PATH の追加はログイン時1回だけ評価される zprofile 側で行う。
# Homebrew の HOMEBREW_PREFIX を使うため、`eval "$(brew shellenv)"` より後に置く必要がある。
if [ ! -f ~/.zprofile ]; then
  touch ~/.zprofile
fi

if ! grep -q "Custom config" ~/.zprofile; then
  echo "Adding custom config to ~/.zprofile..."
  cat << EOF >> ~/.zprofile

# Custom config
[[ -f "$HOME/dotfiles/zprofile" ]] && builtin source "$HOME/dotfiles/zprofile"
EOF
  echo "\033[32m✅SUCCESS:\033[0m Adding custom config to ~/.zprofile\n"
else
  echo "\033[33m🚧WARNING:\033[0m Custom config already exists in ~/.zprofile\n"
fi
