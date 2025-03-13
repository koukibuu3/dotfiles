# !/bin/zsh

# Install anyenv
if command -v anyenv &>/dev/null; then
  echo "\033[33m🚧WARNING:\033[0m anyenv is already installed.\n"
else
  echo "Installing anyenv..."
  anyenv install --init
  echo "\033[32m✅SUCCESS:\033[0m Installed anyenv\n"
  source ~/.zshrc
fi
