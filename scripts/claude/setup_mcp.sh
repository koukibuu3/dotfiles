# !/bin/zsh

# user スコープの MCP サーバーを登録する。
# 認証情報は ~/dotfiles/.env.local（.gitignore 対象）から読み込む。
# ~/.claude.json には平文で認証情報が書き込まれるため、そのファイル自体は絶対にコミットしないこと。
#
# 通常は登録済みのサーバーをスキップする。認証情報をローテートしたときは強制再登録する：
#   CLAUDE_MCP_FORCE=1 zsh scripts/claude/setup_mcp.sh
#   zsh scripts/claude/setup_mcp.sh --force
#
# ${VAR} 参照を ~/.claude.json に残す方式は採らない。Claude Code は MCP の env を展開するが、
# 展開元は親プロセスの環境変数か settings.json の env に限られる（settings.local.json は user
# スコープでは読まれない）。前者は GUI 起動が zshrc を通らないため効かず、後者はコミット対象の
# ファイルなので秘密を置けない。よって実値を ~/.claude.json に持たせ、.env.local を正とする。

DOTFILES_DIR="$(pwd)"
[ -d "$DOTFILES_DIR/claude" ] || DOTFILES_DIR="$HOME/dotfiles"
ENV_FILE="$DOTFILES_DIR/.env.local"

FORCE=0
[ "$CLAUDE_MCP_FORCE" = "1" ] && FORCE=1
for arg in "$@"; do
  [ "$arg" = "--force" ] && FORCE=1
done

if ! command -v claude > /dev/null 2>&1; then
  echo "\033[33m🚧WARNING:\033[0m claude command not found. Claude Code をインストールしてから再実行してください"
  return 2> /dev/null || exit 0
fi

if [ ! -f "$ENV_FILE" ]; then
  echo "\033[33m🚧WARNING:\033[0m .env.local not found. .env.local.example をコピーして値を埋めてから再実行してください"
  echo "  cp .env.local.example .env.local"
  return 2> /dev/null || exit 0
fi

set -a
. "$ENV_FILE"
set +a

: "${DEV_MCP_SERVERS_DIR:=$HOME/Repos/anyinc/dev-mcp-servers}"
: "${OBSIDIAN_VAULT_DIR:=$HOME/Notes}"

add_mcp() {
  name="$1"
  shift

  if claude mcp get "$name" > /dev/null 2>&1; then
    if [ "$FORCE" != "1" ]; then
      echo "\033[33m🚧WARNING:\033[0m mcp server $name already registered (--force で再登録)"
      return
    fi

    echo "Removing mcp server: $name (--force)"
    if ! claude mcp remove "$name" --scope user > /dev/null 2>&1; then
      echo "\033[31m❌FAILED:\033[0m mcp server $name の削除に失敗したため再登録を中止します"
      return
    fi
  fi

  echo "Adding mcp server: $name"
  claude mcp add --scope user "$name" "$@" \
    && echo "\033[32m✅SUCCESS:\033[0m mcp server $name added" \
    || echo "\033[31m❌FAILED:\033[0m mcp server $name"
}

# --- qast-knowledge-mcp / mysql-research-mcp ---
# どちらも anyinc/dev-mcp-servers のビルド成果物を直接叩くので、
# 先に clone + install + build しておく必要がある。
if [ -d "$DEV_MCP_SERVERS_DIR" ]; then
  add_mcp qast-knowledge-mcp \
    -e QAST_LOGIN_ID="$QAST_LOGIN_ID" \
    -e QAST_LOGIN_PASSWORD="$QAST_LOGIN_PASSWORD" \
    -e QAST_APP_KEY="$QAST_APP_KEY" \
    -- node "$DEV_MCP_SERVERS_DIR/packages/qast-knowledge-mcp/dist/index.js"

  add_mcp mysql-research-mcp \
    -e DB_HOST="$DB_HOST" \
    -e DB_PORT="$DB_PORT" \
    -e DB_USER="$DB_USER" \
    -e DB_PASSWORD="$DB_PASSWORD" \
    -e DB_NAME="$DB_NAME" \
    -- node "$DEV_MCP_SERVERS_DIR/packages/mysql-research-mcp/dist/index.js"
else
  echo "\033[33m🚧WARNING:\033[0m $DEV_MCP_SERVERS_DIR not found. anyinc/dev-mcp-servers を clone + build してから再実行してください"
fi

# --- obsidian-mcp-tools ---
# Obsidian の MCP Tools プラグインが入っていればバイナリが存在する。
OBSIDIAN_MCP_BIN="$OBSIDIAN_VAULT_DIR/.obsidian/plugins/mcp-tools/bin/mcp-server"
if [ -x "$OBSIDIAN_MCP_BIN" ]; then
  add_mcp obsidian-mcp-tools \
    --transport stdio \
    -e OBSIDIAN_API_KEY="$OBSIDIAN_API_KEY" \
    -- "$OBSIDIAN_MCP_BIN"
else
  echo "\033[33m🚧WARNING:\033[0m $OBSIDIAN_MCP_BIN not found. Obsidian の MCP Tools プラグインを入れてから再実行してください"
fi
