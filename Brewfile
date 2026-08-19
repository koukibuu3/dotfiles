# Homebrew の依存をまとめて管理する。
#
#   brew bundle install --file=~/dotfiles/Brewfile
#
# 現在インストール済みの一覧からこのファイルを作り直したい場合は `brew bundle dump`。
# ここに書いていないものを削除したい場合は `brew bundle cleanup`（--force で実行）。

# ---------------------------------------- #
# Formulae
# ---------------------------------------- #

brew "git"
brew "anyenv"
brew "starship"
brew "deno"
brew "jq"
brew "fzf" # zshrc の gsf エイリアスが依存

# ---------------------------------------- #
# Casks
# ---------------------------------------- #

cask "ghostty" # scripts/ghostty/link_ghostty_config.sh が設定を配置する
cask "karabiner-elements" # scripts/karabiner/add_complex_modifications.sh が設定を配置する
cask "raycast"
cask "google-chrome"
cask "obsidian"
cask "figma"
cask "slack"
cask "google-japanese-ime"
cask "visual-studio-code"

# ---------------------------------------- #
# Fonts
# ---------------------------------------- #

cask "font-commit-mono"
cask "font-commit-mono-nerd-font"
