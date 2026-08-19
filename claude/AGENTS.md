# AGENTS.md

個人のグローバル設定。すべてのプロジェクトに適用される。

プロジェクト固有の構成・コマンド・アーキテクチャはここに書かない。
各リポジトリの `AGENTS.md` / `CLAUDE.md` を正とする。

## Conversation Guidelines

**MUST: すべてのやりとりは日本語でお願いします。**

## Documentation Guidelines

環境構築・ビルド・テスト・Lint のコマンドは各リポジトリの `README.md` を正とする。
指示ファイルに重複記載しない。

## Branch Rules

以下の分類に従ってデフォルトブランチから作業ブランチを切ってください。

ブランチ名のプレフィクスとして `feature` もしくは `bugfix` を付けてください。

- 機能修正 or 新規機能作成 : `feature/{チケットID}/{任意}`
- バグ修正: `bugfix/{チケットID}/{任意}`

`{チケットID}` の部分は作業指示のもとになる Jira, GitHub issue のIDで置き換えてください。

`{任意}` の部分はハイフン `-` 繋ぎのブランチの内容を表す簡潔な英語で置き換えてください。

## Commit Rules

1つの関心事ごとにコミットを作成してください。

コミットメッセージの1行目には修正内容を表す簡潔な文章を日本語で書いてください。

コミットの内容に沿って、以下のプレフィクスを1行目のメッセージの先頭に付けてください：

- `feat:` 新機能の追加
- `fix:` バグ修正
- `docs:` ドキュメントの変更
- `style:` コードスタイル (空白、フォーマットなど) の修正
- `refactor:` コードのリファクタリング (機能変更を伴わない変更)
- `perf:` パフォーマンスの改善
- `test:` テストコードの追加や修正
- `chore:` ビルドプロセスや補助ツール、ライブラリの変更

## Pull Request Rules

プルリクエストの作成時には必ず `.github/pull_request_template.md` のテンプレートに従ってください。

## Infrastructure & AWS CLI Rules

### Terraform Rules

**MUST: terraform applyは禁止されています。**

### AWS CLI Rules

**MUST: AWS CLIを使用する際は必ずprofileを指定してください。**

- デフォルトプロファイルの使用は禁止されています
- コマンド例: `aws --profile [profile-name] s3 ls`

**MUST: AWS CLIを使用した破壊的な操作は必ず確認を取ってください。**

- 削除操作 (delete, remove, terminate など)
- 設定変更操作 (modify, update, put など)
- データ移行操作 (copy, move, sync など)
- これらの操作を実行する前に、必ず実行内容と影響範囲を確認してください

**MUST: productionタグがついているリソースへの破壊的操作は絶対に実行してはいけません。**

- productionタグを持つリソースに対する削除、変更、移動操作は禁止
- 実行前に必ずタグを確認してください
- 例: `aws --profile [profile-name] resourcegroupstaggingapi get-resources --tag-filters Key=env,Values=production`
