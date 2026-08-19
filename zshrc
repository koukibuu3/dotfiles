#!/bin/zsh

# 対話シェルごとに評価される設定。
# PATH の追加は zprofile に置く（ここに書くとネストしたシェルで PATH が膨張する）。

# ネストしたシェルで PATH が伸びないように重複を除去する
typeset -U path PATH

# ---------------------------------------- #
# Prompt
# ---------------------------------------- #

if command -v starship > /dev/null 2>&1; then
  export STARSHIP_CONFIG="$HOME/dotfiles/starship.toml"
  eval "$(starship init zsh)"
fi

# ---------------------------------------- #
# History
# ---------------------------------------- #

# 重複をコマンド履歴に記録しない
setopt hist_ignore_dups

# コマンド履歴の保存数
HISTSIZE=30000
SAVEHIST=30000

# ---------------------------------------- #
# Other Settings
# ---------------------------------------- #

# anyenv
if command -v anyenv > /dev/null 2>&1; then
  eval "$(anyenv init -)"
fi

# Ctrl+S を vim 等に届ける (XOFF を無効化)
[ -t 0 ] && stty -ixon

# ---------------------------------------- #
# Alias Settings
# ---------------------------------------- #

# ls（カラー表示）
alias ls='ls -FG'
alias ll='ls -l'
alias la='ls -a'

# Git aliases
alias g='git'
alias gst='git status'
alias gbr='git branch'
alias gch='git checkout'
# alias gsw='git switch'
alias gco='git commit'
alias gdd='git add'
alias gsh='git push origin'
alias gll='git pull origin'
alias gre='git rebase'
alias gme='git merge'
alias glo='git log --pretty=short --graph -3'
alias gcp='git branch --show-current | tr -d "\n" | pbcopy'
alias gsw='git branch | fzf | xargs git switch'

# Docker aliases
alias dc='docker compose'

# pnpm
alias pn='pnpm'

# Other
alias c='clear'
alias h='history'
alias cc='claude --dangerously-skip-permissions'
