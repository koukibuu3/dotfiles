# !/bin/zsh

# Add custom config to vimrc if not already present
if [ ! -f ~/.vimrc ]; then
  touch ~/.vimrc
fi

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
