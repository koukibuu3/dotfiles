# !/bin/zsh

# Install Homebrew
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "\033[33m🚧WARNING:\033[0m Homebrew is already installed.\n"
fi

# Install zinit
if ! command -v zinit &> /dev/null; then
  echo "Installing zinit..."
  bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
else
  echo "\033[33m🚧WARNING:\033[0m zinit is already installed.\n"
fi

# Add custom config to zshrc if not already present
if ! grep -q "Custom config" ~/.zshrc; then
  echo "Adding custom config to ~/.zshrc..."
  cat <<EOF >> ~/.zshrc

# Custom config
[[ -f "$HOME/dotfiles/zshrc" ]] && builtin source "$HOME/dotfiles/zshrc"
EOF
  echo "\033[32m✅SUCCESS:\033[0m Adding custom config to ~/.zshrc\n"
else
  echo "\033[33m🚧WARNING:\033[0m Custom config already exists in ~/.zshrc\n"
fi


# Add vimrc to ~/.vimrc if not already present
if ! grep -q "Custom config" ~/.vimrc; then
  echo "Adding custom config to ~/.vimrc..."
  cat <<EOF >> ~/.vimrc

" Custom config
if filereadable(expand('~/dotfiles/vimrc'))
    source ~/dotfiles/vimrc
endif
EOF
  echo "\033[32m✅SUCCESS:\033[0m Adding custom config to ~/.vimrc.\n"
else
  echo "\033[33m🚧WARNING:\033[0m Custom config already exists in ~/.vimrc.\n"
fi

# Install brew packages
brew_packages=(
  git
  anyenv
  deno
  jq
)
echo "Installing brew packages...\n"
for package in ${brew_packages[@]}; do
  if brew list -1 | grep -q "^${package}\$"; then
    echo "\033[33m🚧WARNING:\033[0m ${package} is already installed.\n"
  else
    echo "Installing ${package}..."
    brew install ${package}
    echo "\033[32m✅SUCCESS:\033[0m Installed ${package}\n"
  fi
done

# Install anyenv
if command -v anyenv &>/dev/null; then
  echo "\033[33m🚧WARNING:\033[0m anyenv is already installed.\n"
else
  echo "Installing anyenv..."
  anyenv install --init
  echo "\033[32m✅SUCCESS:\033[0m Installed anyenv\n"
  source ~/.zshrc
fi

# Add plugins to anyenv
if [ ! -d "$(anyenv root)/plugins" ]; then
  echo "Adding plugins to anyenv..."
  echo "Creating plugins directory, $(anyenv root)/plugins"
  mkdir -p $(anyenv root)/plugins
  git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
  echo "\033[32m✅SUCCESS:\033[0m Added plugins to anyenv\n"
else
  echo "\033[33m🚧WARNING:\033[0m anyenv plugins already exist in $(anyenv root)/plugins.\n"
fi

# Install nodenv
if command -v nodenv &>/dev/null; then
  echo "\033[33m🚧WARNING:\033[0m nodenv is already installed.\n"
else
  echo "Installing nodenv via anyenv..."
  anyenv install nodenv
  echo "\033[32m✅SUCCESS:\033[0m Installed nodenv\n"
  source ~/.zshrc
fi

# Add plugins to nodenv
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
  echo "\033[33m🚧WARNING:\033[0m nodenv plugins already exist in $(nodenv root)/plugins.\n"
fi

# Install brew cask packages
brew_cask_packages=(
  cursor
  obsidian
  raycast
  warp
  karabiner-elements
  google-japanese-ime
  figma
)
echo "Installing brew cask packages...\n"
for package in ${brew_cask_packages[@]}; do
  if brew list --cask $package &>/dev/null; then
    echo "\033[33m🚧WARNING:\033[0m $package is already installed.\n"
  else
    echo "Installing ${package}..."
    if brew install --cask $package; then
      echo "\033[32m✅SUCCESS:\033[0m Installed $package\n"
    else
      echo ""
    fi
  fi
done
