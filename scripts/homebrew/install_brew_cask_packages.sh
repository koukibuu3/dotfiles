# !/bin/zsh

# Install brew cask packages
echo "Installing brew cask packages...\n"
brew_cask_packages=(
  karabiner-elements
  raycast
  google-chrome
  arc
  obsidian
  iterm2
  amazon-q
  figma
  docker
  slack
  notion
  google-japanese-ime
  font-commit-mono
  font-commit-mono-nerd-font
  visual-studio-code
  cursor
)

# Install rosetta
softwareupdate --install-rosetta

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
