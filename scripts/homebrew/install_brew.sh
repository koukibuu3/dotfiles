# !/bin/zsh

# Install Homebrew
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "\033[33m🚧WARNING:\033[0m Homebrew is already installed.\n"
fi
