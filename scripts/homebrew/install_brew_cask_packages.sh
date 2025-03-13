# !/bin/zsh

# Install brew cask packages
echo "Installing brew cask packages...\n"
brew_cask_packages=(
  cursor
  obsidian
  raycast
  warp
  amazon-q
  karabiner-elements
  google-japanese-ime
  figma
  docker
  slack
  arc
  google-chrome
  notion
  font-commit-mono
)
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
