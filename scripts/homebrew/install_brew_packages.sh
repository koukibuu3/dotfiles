# !/bin/zsh

# Install brew packages
echo "Installing brew packages...\n"
brew_packages=(
  git
  anyenv
  starship
  deno
  jq
)
for package in ${brew_packages[@]}; do
  if brew list -1 | grep -q "^${package}$"; then
    echo "\033[33m🚧WARNING:\033[0m ${package} is already installed.\n"
  else
    echo "Installing ${package}..."
    brew install ${package}
    echo "\033[32m✅SUCCESS:\033[0m Installed ${package}\n"
  fi
done
