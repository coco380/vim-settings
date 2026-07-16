# Vim セットアップ

VSCode の見た目ではなく、ファイル探索、検索、Git、terminal、Problems、コード移動といった開発導線を Vim で扱いやすくする設定です。

標準構成は Vim だけで起動します。CLI、plugin、language server は必要なものだけを任意で追加します。

```sh
vim -Nu ./vimrc
```

小さい画面や SSH では以下を使えます。

```sh
vim --noplugin -Nu ./vimrc.minimal
```

## 方針

1. Vim 標準機能を優先する
2. 外部依存は必須にしない
3. semantic completion や diagnostics は Coc 構成へ分離する

## ドキュメント

| 目的 | 読むもの |
|---|---|
| 導入、更新、削除、任意 CLI | [セットアップ](docs/setup.md) |
| キーバインド、Git、terminal、トラブル | [使い方](docs/usage.md) |
| LSP、補完、diagnostics | [Coc 構成](docs/coc.md) |
| VSCode との対応範囲 | [VSCode 開発体験との対応](docs/vscode-experience.md) |
| project-local LSP 設定 | [Coc templates](templates/coc/README.md) |

## 検証

```sh
tests/run.sh
```

full / minimal の起動、検索、Git、path copy、netrw、terminal、設定JSONを検証します。`git`が必要です。

## 構成

```txt
vimrc
vimrc.minimal
coc-settings.json
templates/coc/
docs/
tests/
```
