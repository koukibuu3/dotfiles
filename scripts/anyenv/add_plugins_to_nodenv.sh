# !/bin/zsh

# Add plugins to nodenv

if ! command -v nodenv > /dev/null 2>&1; then
  echo "\033[33m🚧WARNING:\033[0m nodenv not found. スキップします\n"
  return 2> /dev/null || exit 0
fi
if [ ! -d "$(nodenv root)/plugins" ]; then
  echo "Adding plugins to nodenv..."
  echo "Creating plugins directory, $(nodenv root)/plugins"
  mkdir $(nodenv root)/plugins
  git clone https://github.com/nodenv/nodenv-default-packages.git $(nodenv root)/plugins/nodenv-default-packages
  cat <<EOF >> $(nodenv root)/default-packages
typescript
ts-node
EOF
  echo "\033[32m✅SUCCESS:\033[0m Added plugins to nodenv\n"
else
  echo "\033[33m🚧WARNING:\033[0m nodenv plugins already exist in $(nodenv root)/plugins.\033[0m\n"
fi
