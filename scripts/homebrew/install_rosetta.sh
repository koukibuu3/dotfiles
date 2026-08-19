# !/bin/zsh

# Install Rosetta 2 (Apple Silicon のみ)
# 以前は install_brew_cask_packages.sh に混在していたが、brew とは無関係なので分離した。
if [ "$(uname -m)" != "arm64" ]; then
  echo "\033[33m🚧WARNING:\033[0m Not Apple Silicon. Skipping Rosetta.\n"
  return 2> /dev/null || exit 0
fi

# oahd デーモンの起動状態ではなく、インストールの有無を直接見る
if [ -f /Library/Apple/usr/share/rosetta/rosetta ]; then
  echo "\033[33m🚧WARNING:\033[0m Rosetta is already installed.\n"
else
  echo "Installing Rosetta..."
  softwareupdate --install-rosetta
fi
