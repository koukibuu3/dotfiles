# README

## ~/.zshrc
```
# .zshrc

# Custom config
[[ -f "$HOME/dotfiles/zshrc" ]] && builtin source "$HOME/dotfiles/zshrc"
```

## ~/.vimrc
```
" .vimrc

if filereadable(expand('~/configs/vimrc'))
    source ~/Configs/vimrc
endif
```
