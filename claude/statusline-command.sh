#!/bin/sh
input=$(cat)

# RunCat Neo Custom Metrics 用のスナップショットを書き出す
echo "$input" | "$HOME/.claude/runcat-statusline.py" >/dev/null 2>&1

model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
dir=$(basename "$cwd")
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
five=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')

make_bar() {
  pct="$1"
  total=10
  filled=$(echo "$pct $total" | awk '{printf "%d", int($1 * $2 / 100 + 0.5)}')
  empty=$((total - filled))
  bar=""
  i=0
  while [ $i -lt $filled ]; do
    bar="${bar}█"
    i=$((i + 1))
  done
  i=0
  while [ $i -lt $empty ]; do
    bar="${bar}░"
    i=$((i + 1))
  done
  printf '%s' "$bar"
}

# 1行目: モデル → コンテキスト → 5hレート
line1="🤖 $model"

if [ -n "$used" ]; then
  bar=$(make_bar "$(printf '%.0f' "$used")")
  line1="$line1 | 📊 ctx:[${bar}]$(printf '%.0f' "$used")%"
fi

if [ -n "$five" ]; then
  bar=$(make_bar "$(printf '%.0f' "$five")")
  rate_label="⏱ 5h:[${bar}]$(printf '%.0f' "$five")%"
  rate_str=$(printf '\033]8;;https://claude.ai/settings/usage\033\\%s\033]8;;\033\\' "$rate_label")
  line1="$line1 | $rate_str"
fi

# 2行目: フォルダ → ブランチ名
line2="📂 $dir"

if [ -n "$cwd" ] && git -C "$cwd" rev-parse --is-inside-work-tree 2>/dev/null | grep -q true; then
  branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    changed=$(git -C "$cwd" status --porcelain --no-lock-index 2>/dev/null | wc -l | tr -d ' ')
    remote_url=$(git -C "$cwd" remote get-url origin 2>/dev/null)
    github_branch_url=""
    if [ -n "$remote_url" ]; then
      gh_path=$(echo "$remote_url" | sed -E 's|git@github\.com:(.+)\.git|\1|; s|https://github\.com/(.+)\.git|\1|; s|https://github\.com/(.+)|\1|')
      if echo "$remote_url" | grep -q "github\.com"; then
        github_branch_url="https://github.com/$gh_path/tree/$branch"
      fi
    fi
    if [ "$changed" -gt 0 ]; then
      branch_label="🌿 $branch ($changed)"
    else
      branch_label="🌿 $branch"
    fi
    if [ -n "$github_branch_url" ]; then
      git_part=$(printf '\033]8;;%s\033\\%s\033]8;;\033\\' "$github_branch_url" "$branch_label")
    else
      git_part="$branch_label"
    fi
    line2="$line2 | $git_part"
  fi
fi

printf '%s\n%s' "$line1" "$line2"
