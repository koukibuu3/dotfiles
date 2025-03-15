# !bin/zsh

# -----------------------------
# Initial Settings
# -----------------------------

## Macの更新後Gitが使えなくなった際に xcode-select --install を自動実行
[[ $(git --version | grep xcrun > /dev/null) ]] && xcode-select --install

## Homebrew
export BREW_ROOT=${BREW_ROOT:-"/opt/homebrew"}

# ---------------------------------------- #
# Path Settings
# ---------------------------------------- #

## Composer
export PATH=$HOME/.composer/vendor/bin:$PATH

## Git
export PATH=$BREW_ROOT/opt/git/bin:$PATH

# ---------------------------------------- #
# Other Settings
# ---------------------------------------- #

# # Zinit
# zinit light zsh-users/zsh-syntax-highlighting
# zplugin ice atload'!_zsh_git_prompt_precmd_hook' lucid
# zplugin load woefe/git-prompt.zsh

# zinit ice pick"async.zsh" src"pure.zsh"
# zinit light sindresorhus/pure

eval "$(starship init zsh)"

# TAB補完時にハイライト表示させる
# zstyle ':completion:*' menu select

# 重複をコマンド履歴に記録しない
setopt hist_ignore_dups

# コマンド履歴の保存数
HISTSIZE=30000
SAVEHIST=30000

# anyenv
eval "$(anyenv init -)"

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
alias gsw='git switch'
alias gco='git commit'
alias gdd='git add'
alias gsh='git push origin'
alias gll='git pull origin'
alias gre='git rebase'
alias gme='git merge'
alias glo='git log --pretty=short --graph -3'
alias gcp='git branch --show-current | tr -d "\n" | pbcopy'

# Vagrant aliases
alias vup='vagrant up'
alias vha='vagrant halt'
alias vst='vagrant status'
alias vsh='vagrant ssh'

# Docker aliases
alias dc='docker compose'

# pnpm
alias pn='pnpm'

# Other
alias c='clear'
alias h='history'
alias code='cursor'
