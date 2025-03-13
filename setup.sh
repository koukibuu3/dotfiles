# !/bin/zsh

# Homebrew のインストール
. scripts/homebrew/install_brew.sh

# zinit のインストール
. scripts/zsh/install_zinit.sh

# zshrc にカスタム設定を追加
. scripts/zsh/add_custom_config_to_zshrc.sh

# vimrc にカスタム設定を追加
. scripts/vim/add_custom_config_to_vimrc.sh

# Homebrew パッケージのインストール
. scripts/homebrew/install_brew_packages.sh

# anyenv のインストール
. scripts/anyenv/install_anyenv.sh

# anyenv にプラグインを追加
. scripts/anyenv/add_plugins_to_anyenv.sh

# nodenv のインストール
. scripts/anyenv/install_nodenv.sh

# nodenv にプラグインを追加
. scripts/anyenv/add_plugins_to_nodenv.sh

# Homebrew Cask パッケージのインストール
. scripts/homebrew/install_brew_cask_packages.sh

# Karabiner-Elements の設定ファイルを追加
. scripts/karabiner/add_complex_modifications.sh
