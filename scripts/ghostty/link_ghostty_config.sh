# !/bin/zsh

# Add ghostty/config to ~/.config/ghostty/
if [ ! -f ~/.config/ghostty/config ]; then
  echo "Adding config to ~/.config/ghostty/"
  mkdir -p ~/.config/ghostty
  ln ghostty/config ~/.config/ghostty/config
  echo "\033[32m✅SUCCESS:\033[0m config added to ~/.config/ghostty/"
else
  echo "\033[33m🚧WARNING:\033[0m config already exists in ~/.config/ghostty/"
fi
