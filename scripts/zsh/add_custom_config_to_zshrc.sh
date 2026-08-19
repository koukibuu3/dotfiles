# !/bin/zsh

# Add custom config to zshrc if not already present
if [ ! -f ~/.zshrc ]; then
  touch ~/.zshrc
fi

if ! grep -q "Custom config" ~/.zshrc; then
  echo "Adding custom config to ~/.zshrc..."
  cat << 'EOF' >> ~/.zshrc

# Custom config
[[ -f "$HOME/dotfiles/zshrc" ]] && builtin source "$HOME/dotfiles/zshrc"
EOF
  echo "\033[32m✅SUCCESS:\033[0m Adding custom config to ~/.zshrc\n"
else
  echo "\033[33m🚧WARNING:\033[0m Custom config already exists in ~/.zshrc\n"
fi
