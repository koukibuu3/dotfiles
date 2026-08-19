---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*)
description: Create a git commit
---

## Important

Please respond to me and commit messages in Japanese.

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`

## Your task

1. Analyze the diff content to understand the nature and purpose of the changes
2. Generate 3 commit message candidates based on the changes
   - Each candidate should be concise, clear, and capture the essence of the
     changes
   - Prefer Conventional Commits format (feat:, fix:, docs:, refactor:, etc.)
3. Please present one of the candidates to me and let me choose
4. Stage changes if necessary using git add
5. Execute git commit using the selected commit message
