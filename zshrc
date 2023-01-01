# !bin/zsh

# -----------------------------
# Initial Settings
# -----------------------------

## Macの更新後Gitが使えなくなった際に xcode-select --install を自動実行
[[ $(git --version | grep xcrun > /dev/null) ]] && xcode-select --install

## Homebrew
export BREW_ROOT=${BREW_ROOT:-"/opt/homebrew"}

## zplug
export ZPLUG_HOME=$BREW_ROOT/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "modules/directory", from:prezto
zplug "modules/osx", from:prezto, if:"[[ $OSTYPE == *darwin* ]]"
if ! zplug check --verbose; then zplug install;fi
zplug load #--verbose

# ---------------------------------------- #
# Path Settings
# ---------------------------------------- #

## phpenv
export PATH=$BREW_ROOT/opt/bison/bin:$PATH
export PATH=$BREW_ROOT/opt/libxml2/bin:$PATH
export PATH=$BREW_ROOT/opt/bzip2/bin:$PATH
export PATH=$BREW_ROOT/opt/curl/bin:$PATH
export PATH=$BREW_ROOT/opt/libiconv/bin:$PATH
export PATH=$BREW_ROOT/opt/krb5/bin:$PATH
export PATH=$BREW_ROOT/opt/openssl@1.1/bin:$PATH
export PATH=$BREW_ROOT/opt/icu4c/bin:$PATH
export PATH=$BREW_ROOT/opt/tidy-html5/lib:$PATH
export PKG_CONFIG_PATH=$BREW_ROOT/opt/krb5/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=$BREW_ROOT/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=$BREW_ROOT/opt/libedit/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=$BREW_ROOT/opt/libjpeg/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=$BREW_ROOT/opt/libpng/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=$BREW_ROOT/opt/libxml2/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=$BREW_ROOT/opt/libzip/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=$BREW_ROOT/opt/oniguruma/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=$BREW_ROOT/opt/openssl@1.1/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=$BREW_ROOT/opt/tidy-html5/lib/pkgconfig:$PKG_CONFIG_PATH
export PHP_RPATHS=$BREW_ROOT/opt/zlib/lib:$PHP_RPATHS
export PHP_RPATHS=$BREW_ROOT/opt/bzip2/lib:$PHP_RPATHS
export PHP_RPATHS=$BREW_ROOT/opt/curl/lib:$PHP_RPATHS
export PHP_RPATHS=$BREW_ROOT/opt/libiconv/lib:$PHP_RPATHS
export PHP_RPATHS=$BREW_ROOT/opt/libedit/lib:$PHP_RPATHS
export PHP_BUILD_CONFIGURE_OPTS="--with-bz2=$BREW_ROOT/opt/bzip2 --with-iconv=$BREW_ROOT/opt/libiconv --with-tidy=$BREW_ROOT/opt/tidy-html5 --with-external-pcre=$BREW_ROOT/opt/pcre2 --with-zip --enable-intl --with-pear"

## PostgreSQL
export PATH=/opt/homebrew/opt/postgresql@13/bin:$PATH
export LDFLAGS=-L/opt/homebrew/opt/postgresql@13/lib
export CPPFLAGS=-I/opt/homebrew/opt/postgresql@13/include
export PKG_CONFIG_PATH=/opt/homebrew/opt/postgresql@13/lib/pkgconfig

## Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

## Git
export PATH=$BREW_ROOT/opt/git/bin:$PATH

# ---------------------------------------- #
# Other Settings
# ---------------------------------------- #

## 自動補完の有効化
autoload -U promptinit; promptinit

## プロンプトの設定
PROMPT="%F{008}%* %F{002}%n %F{006}%c
%# %f"

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
alias glo='git log --pretty=short --graph'

# Vagrant aliases
alias vup='vagrant up'
alias vha='vagrant halt'
alias vst='vagrant status'
alias vsh='vagrant ssh'

# Docker aliases
alias dc='docker compose'
