# セットアップ

macOS と Vim 9.1 以上を推奨します。標準構成に追加ダウンロードは不要です。

## 試す

リポジトリ内で起動します。Vimのstateはこのリポジトリの`.vim/`へ保存され、Git管理外です。

```sh
vim -Nu ./vimrc
vim --noplugin -Nu ./vimrc.minimal
tests/run.sh
```

読み込みだけを確認する場合:

```sh
vim -Nu ./vimrc -i NONE -n -es +'qa!'
vim --noplugin -Nu ./vimrc.minimal -i NONE -n -es +'qa!'
```

## Macへ反映する

`~/.vimrc`、`~/.vimrc.minimal`、`~/.vim/coc-settings.json`を使っていないことを確認してから実行します。

```sh
backup_ts="$(date +%Y%m%d-%H%M%S)"
test -f "$HOME/.vimrc" && cp "$HOME/.vimrc" "$HOME/.vimrc.backup.$backup_ts"
test -f "$HOME/.vimrc.minimal" && cp "$HOME/.vimrc.minimal" "$HOME/.vimrc.minimal.backup.$backup_ts"
test -f "$HOME/.vim/coc-settings.json" && cp "$HOME/.vim/coc-settings.json" "$HOME/.vim/coc-settings.json.backup.$backup_ts"

mkdir -p "$HOME/.vim"
cp vimrc "$HOME/.vimrc"
cp vimrc.minimal "$HOME/.vimrc.minimal"
cp coc-settings.json "$HOME/.vim/coc-settings.json"
```

反映後の確認:

```sh
vim -Nu "$HOME/.vimrc" -i NONE -n -es +'qa!'
vim --noplugin -Nu "$HOME/.vimrc.minimal" -i NONE -n -es +'qa!'
```

通常は`vim`で起動します。任意で以下のaliasを`~/.zshrc`へ追加できます。

```sh
alias lvim='vim --noplugin -Nu "$HOME/.vimrc.minimal"'
alias vvim='vim -Nu NONE -i NONE -n'
```

更新時も、リポジトリで`tests/run.sh`を実行してから同じコピー手順を使います。

## 任意のCLI

| ツール | 使う機能 |
|---|---|
| `git` | Git status、diff、Git検索 |
| `rg` | 高速なworkspace search |
| `fzf` | fuzzy finderを追加する場合 |
| Node.js / npm | Coc、project formatter / linter |
| `rustup` | Rust language server |

`rg` と `fzf` は GitHub Releases から対象architectureのarchiveを取得し、binaryだけを`~/.local/bin`へ置く方針です。checksumを確認してから展開・配置します。

```sh
mkdir -p "$HOME/.local/bin"
cp path/to/binary "$HOME/.local/bin/<tool>"
chmod +x "$HOME/.local/bin/<tool>"
```

Release pages:

- [ripgrep](https://github.com/BurntSushi/ripgrep/releases)
- [fzf](https://github.com/junegunn/fzf/releases)

更新はbinaryを置き換え、削除は対象binaryだけを`rm -f`します。`fzf`のshell integrationを追加する場合も、`~/.zshrc`への追記は手動で行います。

Tokyo Night pluginは任意です。未導入でも内蔵fallbackで起動します。

```sh
git clone https://github.com/ghifarit53/tokyonight-vim \
  "$HOME/.vim/pack/vendor/start/tokyonight-vim"
```

## 削除と復元

repo内で試しただけなら、削除対象は`.vim/`だけです。

```sh
rm -rf .vim
```

Macへ反映した場合は、この設定が所有するファイルだけを削除します。

```sh
rm -f "$HOME/.vimrc" "$HOME/.vimrc.minimal" "$HOME/.vim/coc-settings.json"
rm -rf "$HOME/.vim/state" "$HOME/.vim/state-minimal"
```

必要ならtimestamp付きbackupをコピーして戻します。`~/.vim/`、`~/.local/bin/`、`~/.config/`、`~/.cache/`、Node.js、npmは他用途と共有し得るため、ディレクトリ単位では削除しません。Cocを導入した場合の削除は[Coc 構成](coc.md)を参照してください。
