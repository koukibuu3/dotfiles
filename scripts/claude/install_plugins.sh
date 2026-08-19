# !/bin/zsh

# Claude Code の marketplace 登録とプラグインのインストール
# どのプラグインを有効にするかは claude/settings.json の enabledPlugins が持つので、
# ここでは「取得元の登録」と「インストール」だけを再現する。

if ! command -v claude > /dev/null 2>&1; then
  echo "\033[33m🚧WARNING:\033[0m claude command not found. Claude Code をインストールしてから再実行してください"
  return 2> /dev/null || exit 0
fi

add_marketplace() {
  echo "Adding marketplace: $1"
  claude plugin marketplace add "$1" \
    && echo "\033[32m✅SUCCESS:\033[0m marketplace $1 added" \
    || echo "\033[33m🚧WARNING:\033[0m marketplace $1 already added or failed"
}

install_plugin() {
  echo "Installing plugin: $1"
  claude plugin install "$1" \
    && echo "\033[32m✅SUCCESS:\033[0m plugin $1 installed" \
    || echo "\033[33m🚧WARNING:\033[0m plugin $1 already installed or failed"
}

add_marketplace anthropics/claude-plugins-official
add_marketplace anyinc/agent-skills

install_plugin slack@claude-plugins-official
install_plugin atlassian@claude-plugins-official
install_plugin agent-skills@anyinc
