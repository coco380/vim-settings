# install 手順

macOS の Vim で、このリポジトリの `vimrc` を試す手順です。

## 現在の進め方

まずは Mac 本体の Vim 設定を変更せず、リポジトリ内だけで検証します。

```sh
vim -Nu ./vimrc
```

この起動方法では `~/.vimrc` を読みません。Vim の履歴や undo などの作業データは、リポジトリ内の `.vim/state/` に保存されます。

## 事前確認

### 1. Vim の場所を確認する

```sh
which vim
```

### 2. Vim のバージョンを確認する

```sh
vim --version | head -n 1
```

この設定は Vim 9.1 で確認しています。

### 3. このリポジトリのディレクトリへ移動する

```sh
cd /path/to/vim-settings
```

確認:

```sh
ls README.md vimrc vimrc.minimal coc-settings.json
```

## repo 内で起動する

```sh
vim -Nu ./vimrc
```

起動後、以下を確認します。

- 背景が暗色になる
- 行番号と相対行番号が表示される
- `<Space>e` で explorer が開く
- `<Space>w` で保存できる
- `<Space>q` で終了できる

## Mac 本体へ反映する場合

設定内容が固まったら、`vimrc` を `~/.vimrc` として配置します。小さい画面や SSH 用の軽量設定は `vimrc.minimal` を `~/.vimrc.minimal` として配置します。

既存の `~/.vimrc` や `~/.vimrc.minimal` がある場合は、先に退避します。

```sh
backup_ts="$(date +%Y%m%d-%H%M%S)"
test -f "$HOME/.vimrc" && cp "$HOME/.vimrc" "$HOME/.vimrc.backup.$backup_ts"
test -f "$HOME/.vimrc.minimal" && cp "$HOME/.vimrc.minimal" "$HOME/.vimrc.minimal.backup.$backup_ts"
```

退避できたことを確認します。

```sh
ls "$HOME"/.vimrc*.backup.*
```

配置します。

```sh
cp vimrc "$HOME/.vimrc"
cp vimrc.minimal "$HOME/.vimrc.minimal"
```

反映後は通常どおり起動します。

```sh
vim
```

軽量設定と完全 vanilla は、必要に応じて alias を用意します。Mac 本体の shell 設定へ反映する前に、まずは直接起動で確認できます。

```sh
vim --noplugin -Nu "$HOME/.vimrc.minimal"
vim -Nu NONE -i NONE -n
```

alias 方針:

```sh
alias lvim='vim --noplugin -Nu "$HOME/.vimrc.minimal"'
alias vvim='vim -Nu NONE -i NONE -n'
```

`vim` は通常のカスタム Vim として使います。

永続化する場合は、`~/.zshrc` に同じ2行を追記します。追記後、新しい shell を開くか `source "$HOME/.zshrc"` で反映します。

```sh
type lvim
type vvim
```

反映した設定を確認します。

```sh
vim -Nu "$HOME/.vimrc" -i NONE -n -es +'qa!'
vim --noplugin -Nu "$HOME/.vimrc.minimal" -i NONE -n -es +'qa!'
```

## 任意ツール

現時点では必須ダウンロードはありません。必要になった場合だけ、以下を追加します。

| ツール | 用途 |
|---|---|
| `ripgrep` (`rg`) | 高速な全文検索 |
| `fzf` | fuzzy finder を作る場合 |
| `Node.js` / `npm` | プロジェクト側の formatter / linter |
| `glow` | Markdown preview |

`rg`、`fzf`、`glow` を入れる場合は、削除しやすい単体 binary 管理にします。詳しくは [CLI ツール管理](cli-tools.md) を確認してください。

LSP / diagnostics / rename / code action / 補完を入れる場合は、`coc.nvim` 中心の構成を候補にします。詳しくは [coc.nvim 構成メモ](coc-setup.md) を確認してください。
