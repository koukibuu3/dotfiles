#!/bin/zsh

# ログイン時に1回だけ評価される設定。PATH の追加はここに置く。
#
# zshrc は対話シェルごとに再評価されるため、PATH の追加を zshrc に書くと
# ネストしたシェルで要素が二重三重に増えていく（実測で 1段35 → 2段76 → 3段158 要素）。

# PATH の重複を自動で除去する（先頭の出現を残す）
typeset -U path PATH

# Homebrew の場所を特定する。アーキテクチャで prefix が違う。
if [ -z "$HOMEBREW_PREFIX" ]; then
  if [ -x /opt/homebrew/bin/brew ]; then
    export HOMEBREW_PREFIX="/opt/homebrew" # Apple Silicon
  elif [ -x /usr/local/bin/brew ]; then
    export HOMEBREW_PREFIX="/usr/local" # Intel
  fi
fi

# brew の PATH と環境変数を通す。
# ~/.zprofile 側に `eval "$(brew shellenv)"` があるとは限らない（Homebrew の
# インストーラは追記しない）ため、ここで必ず通す。二重に eval されても
# typeset -U で PATH は重複しない。
if [ -n "$HOMEBREW_PREFIX" ] && [ -x "$HOMEBREW_PREFIX/bin/brew" ]; then
  eval "$("$HOMEBREW_PREFIX/bin/brew" shellenv)"
fi

# brew の git を Xcode 付属の git より優先する。
# brew shellenv は $HOMEBREW_PREFIX/bin までしか通さないので、ここで明示的に追加する。
if [ -n "$HOMEBREW_PREFIX" ] && [ -d "$HOMEBREW_PREFIX/opt/git/bin" ]; then
  export PATH="$HOMEBREW_PREFIX/opt/git/bin:$PATH"
fi
