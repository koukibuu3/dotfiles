# !/bin/zsh

# Install zinit
if ! command -v zinit &> /dev/null; then
  echo "Installing zinit..."
  bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
else
  echo "\033[33m🚧WARNING:\033[0m zinit is already installed.\n"
fi
