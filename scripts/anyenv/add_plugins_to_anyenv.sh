# !/bin/zsh

# Add plugins to anyenv

if ! command -v anyenv > /dev/null 2>&1; then
  echo "\033[33m🚧WARNING:\033[0m anyenv not found. スキップします\n"
  return 2> /dev/null || exit 0
fi
anyenv install --init
source ~/.zshrc
if [ ! -d "$(anyenv root)/plugins" ]; then
  echo "Adding plugins to anyenv..."
  echo "Creating plugins directory, $(anyenv root)/plugins"
  mkdir -p $(anyenv root)/plugins
  git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
  echo "\033[32m✅SUCCESS:\033[0m Added plugins to anyenv\n"
else
  echo "\033[33m🚧WARNING:\033[0m anyenv plugins already exist in $(anyenv root)/plugins.\n"
fi
