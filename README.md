# Vim セットアップ

macOS に、TypeScript / Astro / React / React Router v8 / v7 / Remix v3 beta / Rust / Tailwind CSS / SCSS 向けの Vim 環境を作るための設定一式です。

## 現在の進め方

まずは Mac 本体の Vim 設定を変更せず、このリポジトリ内の `vimrc` だけを使って検証します。

```sh
vim -Nu ./vimrc
```

この起動方法では `~/.vimrc` を読まず、リポジトリ内の `vimrc` だけを読み込みます。設定内容が固まったら、最終的に Mac 本体の Vim 設定へ反映します。

SSH や小さい画面向けには、軽量設定の `vimrc.minimal` も用意します。

```sh
vim --noplugin -Nu ./vimrc.minimal
vim -Nu NONE -i NONE -n
```

このリポジトリは、まず Vim 標準機能と必要最小限の CLI で動く設定を整えます。LSP / 補完 / diagnostics が必要な場合は、`coc.nvim` 中心の構成を追加します。

## この設定でできること

- VSCode 風の暗色テーマ
- `<Space>` leader の基本キーマップ
- Vim 標準の `netrw` によるファイル explorer
- Vim 標準の buffer / window / terminal 操作
- `rg`、または Git worktree 内で `git grep` が使える場合の quickfix 検索
- plugin なしの Git status / blame / diff 表示
- `glow` がある場合の plugin なし Markdown preview
- repo 内 `.vim/` への Vim 作業データ保存
- `coc.nvim` 構成を追加する場合の LSP / 補完 / diagnostics 設定

## 対象環境と前提

- macOS 前提です
- Homebrew は使いません
- Vim 9.1 で確認しています
- 現時点では必須ダウンロードはありません

詳しくは [前提要件](docs/requirements.md) を確認してください。

## 最短セットアップ

現時点では、リポジトリ内で検証します。

```sh
vim -Nu ./vimrc
```

最終的に設定内容が固まったら、Mac 本体の Vim 設定へ反映します。

候補の配置先は以下です。

```txt
~/.vimrc
~/.vimrc.minimal
```

起動 alias は以下の方針です。

```sh
alias lvim='vim --noplugin -Nu "$HOME/.vimrc.minimal"'
alias vvim='vim -Nu NONE -i NONE -n'
```

通常のカスタム Vim は `vim` のまま使います。

## ドキュメント

### 手順別に読む順番

#### 新規 install

最小構成だけ入れる場合:

```txt
1. docs/requirements.md
2. docs/install.md
3. docs/keybindings.md
4. docs/troubleshooting.md
```

任意 CLI や LSP / 補完まで含めて入れる場合:

```txt
1. docs/requirements.md
2. docs/install.md
3. docs/cli-tools.md
4. docs/coc-setup.md
5. docs/keybindings.md
6. docs/troubleshooting.md
```

作成・変更されるファイルは [install 手順](docs/install.md) の「影響範囲」で確認します。

#### update

```txt
1. docs/update.md
2. docs/cli-tools.md    必要な場合だけ
3. docs/coc-setup.md    coc.nvim 構成を入れている場合だけ
4. docs/troubleshooting.md
```

#### uninstall

```txt
1. docs/uninstall.md
2. docs/cli-tools.md    任意 CLI を入れている場合だけ
3. docs/coc-setup.md    coc.nvim 構成を入れている場合だけ
4. docs/troubleshooting.md
```

削除対象は [uninstall 手順](docs/uninstall.md) の「削除対象」で確認します。

| 目的 | ドキュメント |
|---|---|
| 必要なツールを確認する | [前提要件](docs/requirements.md) |
| 新規にセットアップする | [install 手順](docs/install.md) |
| 更新する | [update 手順](docs/update.md) |
| 削除する | [uninstall 手順](docs/uninstall.md) |
| キーバインドを確認する | [主なキーバインド](docs/keybindings.md) |
| 設定の考え方を確認する | [設定概要](docs/configuration.md) |
| CLI ツールの入れ方・消し方を確認する | [CLI ツール管理](docs/cli-tools.md) |
| plugin 導入候補を確認する | [Plugin 導入判断メモ](docs/plugin-evaluation.md) |
| coc.nvim 構成の管理方針を確認する | [coc.nvim 構成メモ](docs/coc-setup.md) |
| Markdown preview を使う | [Markdown プレビュー CLI](docs/markdown-preview.md) |
| 困ったときに確認する | [トラブルシュート](docs/troubleshooting.md) |

`docs/` 配下には、現在の Vim 検証構成と、必要になった場合の外部 CLI 候補をまとめています。

## ファイル構成

```txt
vimrc
vimrc.minimal
coc-settings.json
.gitignore
README.md
docs/
```

現在の検証で使うのは `vimrc` です。小さい画面や SSH では `--noplugin` 付きで `vimrc.minimal` を使えます。`coc.nvim` 構成を入れる場合は `coc-settings.json` も使います。
