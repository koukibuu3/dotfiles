# !/bin/zsh

# Homebrew のインストール
. scripts/homebrew/install_brew.sh

# # zinit のインストール
# . scripts/zsh/install_zinit.sh

# zshrc にカスタム設定を追加
. scripts/zsh/add_custom_config_to_zshrc.sh

# zprofile にカスタム設定を追加（PATH 系）
. scripts/zsh/add_custom_config_to_zprofile.sh

# vimrc にカスタム設定を追加
. scripts/vim/add_custom_config_to_vimrc.sh

# Rosetta 2 のインストール
. scripts/homebrew/install_rosetta.sh

# Brewfile から formula / cask をインストール
. scripts/homebrew/install_brew_bundle.sh

# anyenv の初期設定とプラグイン追加
. scripts/anyenv/add_plugins_to_anyenv.sh

# nodenv のインストール
. scripts/anyenv/install_nodenv.sh

# nodenv にプラグインを追加
. scripts/anyenv/add_plugins_to_nodenv.sh

# Karabiner-Elements の設定ファイルを追加
. scripts/karabiner/add_complex_modifications.sh

# Ghostty の設定ファイルを追加
. scripts/ghostty/link_ghostty_config.sh

# Claude Code の設定ファイルをリンク
. scripts/claude/link_claude_config.sh

# Claude Code の marketplace 登録とプラグインのインストール
. scripts/claude/install_plugins.sh

# Claude Code の MCP サーバーを登録（要 .env.local）
. scripts/claude/setup_mcp.sh
