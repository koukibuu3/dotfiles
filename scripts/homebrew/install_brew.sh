# !/bin/zsh

# Install Homebrew
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "\033[33m🚧WARNING:\033[0m Homebrew is already installed.\n"
fi

# Homebrew のインストーラは PATH を通さない。
# ここで通さないと、後続の brew bundle / anyenv / nodenv が
# すべて「command not found」でこける。
if ! command -v brew &> /dev/null; then
  for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [ -x "$brew_bin" ]; then
      eval "$("$brew_bin" shellenv)"
      echo "\033[32m✅SUCCESS:\033[0m Loaded brew shellenv from $brew_bin\n"
      break
    fi
  done
fi

if ! command -v brew &> /dev/null; then
  echo "\033[31m❌FAILED:\033[0m brew が PATH に見つかりません。以降のインストールはスキップされます\n"
fi
