# Homebrew の依存をまとめて管理する。
#
#   brew bundle install --file=~/dotfiles/Brewfile
#
# 現在インストール済みの一覧からこのファイルを作り直したい場合は `brew bundle dump`。
# ここに書いていないものを削除したい場合は `brew bundle cleanup`（--force で実行）。
#
# 間接依存（他の formula の依存として入るもの）は書かない。brew が解決する。

# ---------------------------------------- #
# Formulae
# ---------------------------------------- #

brew "git"
brew "anyenv"
brew "starship"
brew "deno"
brew "jq" # claude/statusline-command.sh と starship.toml が依存
brew "fzf" # zshrc の gsw エイリアス（ブランチ選択）が依存
brew "gh" # PR の作成に使う

# ---------------------------------------- #
# Terminal & Development
# ---------------------------------------- #

cask "ghostty" # scripts/ghostty/link_ghostty_config.sh が設定を配置する
cask "orbstack" # docker コマンドの提供元。zshrc の dc エイリアスが依存
cask "visual-studio-code"
cask "kiro-cli"
cask "postman"
cask "tableplus"

# ---------------------------------------- #
# Browser
# ---------------------------------------- #

cask "google-chrome"
cask "thebrowsercompany-dia"

# ---------------------------------------- #
# Utility
# ---------------------------------------- #

cask "karabiner-elements" # scripts/karabiner/add_complex_modifications.sh が設定を配置する
cask "raycast"
cask "1password"
cask "1password-cli"
cask "google-japanese-ime"
cask "fliqlo"

# ---------------------------------------- #
# Productivity
# ---------------------------------------- #

cask "obsidian"
cask "figma"
cask "slack"
cask "chatgpt"
cask "libreoffice"

# ---------------------------------------- #
# Fonts
# ---------------------------------------- #

# ghostty/config が CommitMono Nerd Font と HackGen Console NF を指定している
cask "font-commit-mono"
cask "font-commit-mono-nerd-font"
cask "font-hackgen-nerd"
