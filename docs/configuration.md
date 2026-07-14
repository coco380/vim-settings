# 設定概要

`vimrc` と `vimrc.minimal` の主な内容とキーバインド方針です。

## `vimrc` の概要

現在の `vimrc` は、追加ダウンロードなしで動く Vim 標準機能ベースの設定です。LSP / 補完 / diagnostics は、必要に応じて `coc.nvim` 構成で追加します。

- `mapleader` は `<Space>`
- file explorer は Vim 標準の `netrw`
- 検索は Vim の `:grep` を使います
- `rg` があれば `rg --vimgrep` を使います
- `rg` がなく、現在ファイルまたは cwd が Git worktree 内であれば `git grep` を使います
- statusline は plugin なしで自前設定します
- colorscheme plugin は使わず、VSCode 風の dark highlight を自前定義します
- terminal は Vim の `:terminal` を使います
- Markdown preview は `glow` がある場合だけ `:terminal` で表示します
- undo / swap / viminfo は repo 内の `.vim/state/` 配下へ保存します

`coc.nvim` 導入後は、保存時に Prettier 対象 filetype と Rust の整形、ESLint fix、import 整理を実行します。PHP は保存時整形の対象外です。Prettier 対象 filetype の整形には、対象プロジェクト側の Prettier 設定ファイルが必要です。

## `vimrc.minimal` の概要

`vimrc.minimal` は、SSH や小さい画面向けの軽量設定です。通常の `vimrc` から、装飾、plugin 連携、Markdown preview、Git scratch command、固定 signcolumn、相対行番号を外しています。`lvim` alias では `--noplugin` も付け、後から入れた plugin を自動ロードしません。

残すもの:

- 行番号
- 検索設定
- indent / filetype
- clipboard
- undo / swap / viminfo の state 保存先
- `<Space>w` / `<Space>q` / `<Space>e` など最小限の keymap

`vimrc.minimal` の `<Space>e` は `:edit` を開始するだけです。`--noplugin` で起動するため、netrw の file explorer は前提にしません。

使い分け:

```sh
vim
lvim
vvim
```

- `vim`: 通常のカスタム Vim
- `lvim`: `vim --noplugin -Nu ~/.vimrc.minimal` の軽量 Vim
- `vvim`: `vim -Nu NONE -i NONE -n` の完全 vanilla Vim

## キーバインド方針

基本操作は Vim の標準コマンドに寄せます。

- 保存は `:write` に対応する `<Space>w`
- 終了は `:quit` / `:qall` に対応する `<Space>q` / `<Space>Q`
- window 操作は Vim 標準の `<C-w>` 系を使います
- バッファ移動は `[b` / `]b` と `<Space>b...` を使います
- file explorer は `<Space>e` で `netrw` を開きます
- 検索は `<Space>fw` で `:grep`、ファイル移動は `<Space>ff` で `:find` を開始します

## Git CLI 操作

Git 操作は plugin なしで、`git` CLI を呼び出します。

- `<Space>fG` は Git 管理下ファイルだけを検索します
- `<Space>sG` は Git 管理下ファイルだけを確認付き置換します
- `<Space>gg` は `git status --short --branch` を scratch buffer に表示します
- `<Space>gb` は現在ファイルの `git blame` を scratch buffer に表示します
- `<Space>gd` は現在ファイルの `git diff` を scratch buffer に表示します

scratch buffer は確認用の一時バッファです。元のファイルは変更しません。

現在ファイルに対する blame / diff は、ファイルの場所から Git worktree root を解決して実行します。

`<Space>sG` は置換後に自動保存しません。内容を確認してから `:wall` などで保存します。

## repo 内だけで検証する理由

今は Mac 本体の Vim 設定を変更せず、リポジトリ内だけで設定を検証します。

```sh
vim -Nu ./vimrc
```

この起動方法では `~/.vimrc` を読みません。Vim が作る履歴や undo なども `.vim/state/` に保存します。

## 外部ツール / plugin の考え方

まず plugin なしで起動できる状態を維持します。その上で、必要な機能だけ CLI ツールや `coc.nvim` 構成として追加します。

| 欲しい機能 | 候補 |
|---|---|
| 高速な全文検索 | `ripgrep` |
| fuzzy finder | `fzf` |
| Markdown preview | `glow` |
| formatter / linter | プロジェクト側の npm script |
| LSP / 補完 / diagnostics | `coc.nvim` |

`coc.nvim` 構成の管理方針は [coc.nvim 構成メモ](coc-setup.md) にまとめています。
