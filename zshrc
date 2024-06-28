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

## PostgreSQL
export PATH=/opt/homebrew/opt/postgresql@13/bin:$PATH
export LDFLAGS=-L/opt/homebrew/opt/postgresql@13/lib
export CPPFLAGS=-I/opt/homebrew/opt/postgresql@13/include
export PKG_CONFIG_PATH=/opt/homebrew/opt/postgresql@13/lib/pkgconfig

## Git
export PATH=$BREW_ROOT/opt/git/bin:$PATH

# ---------------------------------------- #
# Other Settings
# ---------------------------------------- #

# Zinit
zinit light zsh-users/zsh-syntax-highlighting
zplugin ice atload'!_zsh_git_prompt_precmd_hook' lucid
zplugin load woefe/git-prompt.zsh

zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# # Theming variables for primary prompt
# ZSH_THEME_GIT_PROMPT_PREFIX="["
# ZSH_THEME_GIT_PROMPT_SUFFIX="] "
# ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
# ZSH_THEME_GIT_PROMPT_DETACHED="%{$fg_bold[cyan]%}:"
# ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
# ZSH_THEME_GIT_PROMPT_UPSTREAM_SYMBOL="%{$fg_bold[yellow]%}⟳ "
# ZSH_THEME_GIT_PROMPT_UPSTREAM_NO_TRACKING="%{$fg_bold[red]%}!"
# ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX="%{$fg[red]%}(%{$fg[yellow]%}"
# ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX="%{$fg[red]%})"
# ZSH_THEME_GIT_PROMPT_BEHIND="↓"
# ZSH_THEME_GIT_PROMPT_AHEAD="↑"
# ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}✖"
# ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}●"
# ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[red]%}✚"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="…"
# ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}⚑"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔"

# # Theming variables for the secondary prompt
# ZSH_THEME_GIT_PROMPT_SECONDARY_PREFIX=""
# ZSH_THEME_GIT_PROMPT_SECONDARY_SUFFIX=""
# ZSH_THEME_GIT_PROMPT_TAGS_SEPARATOR=", "
# ZSH_THEME_GIT_PROMPT_TAGS_PREFIX="🏷 "
# ZSH_THEME_GIT_PROMPT_TAGS_SUFFIX=""
# ZSH_THEME_GIT_PROMPT_TAG="%{$fg_bold[magenta]%}"

# setopt prompt_subst #プロンプト表示する度に変数を展開

# precmd () {
#   if [ -n "$(git status --short 2>/dev/null)" ];then
#     export GIT_HAS_DIFF="✗"
#     export GIT_NON_DIFF=""
#   else
#     export GIT_HAS_DIFF=""
#     export GIT_NON_DIFF="✔"
#   fi
#   # git管理されているか確認
#   git status --porcelain >/dev/null 2>&1
#   if [ $? -ne 0 ];then
#     export GIT_HAS_DIFF=""
#     export GIT_NON_DIFF=""
#   fi
#   export BRANCH_NAME=$(git branch --show-current 2>/dev/null)
# }

# プロンプトの設定
# PROMPT="%F{008}%* %F{002}%n %F{006}%c
# %# %f"

# PROMPT=${PROMPT}'%F{green}  ${BRANCH_NAME} ${GIT_NON_DIFF}%F{red}${GIT_HAS_DIFF} 
# %f$ '

# TAB補完時にハイライト表示させる
zstyle ':completion:*' menu select

# 重複をコマンド履歴に記録しない
setopt hist_ignore_dups

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
