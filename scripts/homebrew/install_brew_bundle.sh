# !/bin/zsh

# Install formulae and casks from Brewfile
DOTFILES_DIR="$(pwd)"
[ -f "$DOTFILES_DIR/Brewfile" ] || DOTFILES_DIR="$HOME/dotfiles"
BREWFILE="$DOTFILES_DIR/Brewfile"

if ! command -v brew > /dev/null 2>&1; then
  echo "\033[33m🚧WARNING:\033[0m brew command not found. Homebrew をインストールしてから再実行してください\n"
  return 2> /dev/null || exit 0
fi

if [ ! -f "$BREWFILE" ]; then
  echo "\033[31m❌FAILED:\033[0m Brewfile not found: $BREWFILE\n"
  return 2> /dev/null || exit 0
fi

echo "Installing from Brewfile...\n"
if brew bundle install --file="$BREWFILE"; then
  echo "\033[32m✅SUCCESS:\033[0m Installed from Brewfile\n"
else
  echo "\033[31m❌FAILED:\033[0m brew bundle install\n"
fi
