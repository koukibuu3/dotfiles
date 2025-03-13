# !/bin/zsh

# Install nodenv
if command -v nodenv &>/dev/null; then
  echo "\033[33m🚧WARNING:\033[0m nodenv is already installed.\n"
else
  echo "Installing nodenv via anyenv..."
  anyenv install nodenv
  echo "\033[32m✅SUCCESS:\033[0m Installed nodenv\n"
  source ~/.zshrc
fi
