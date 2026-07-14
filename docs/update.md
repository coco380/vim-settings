# update 手順

この Vim 設定を更新するときの手順です。

## 読む順番

```txt
1. update.md
2. cli-tools.md       rg / fzf / glow を入れている場合だけ
3. install.md         Tokyo Night theme plugin を入れている場合だけ
4. coc-setup.md       coc.nvim 構成を入れている場合だけ
5. troubleshooting.md 困った場合
```

まずこのファイルで `vimrc`、`vimrc.minimal`、`coc-settings.json` の反映方法を確認します。任意ツール、Tokyo Night theme plugin、coc.nvim 構成を入れている場合だけ、該当ドキュメントも確認します。

## repo 内設定を更新する

このリポジトリの `vimrc` や `vimrc.minimal` を編集した後、Mac 本体の設定を読まずに確認します。

```sh
vim -Nu ./vimrc
vim --noplugin -Nu ./vimrc.minimal
```

画面を開かずに読み込みだけ確認する場合:

```sh
vim -Nu ./vimrc -i NONE -n -es +'qa!'
vim --noplugin -Nu ./vimrc.minimal -i NONE -n -es +'qa!'
```

## Mac 本体へ反映済みの場合

`~/.vimrc`、`~/.vimrc.minimal`、`~/.vim/coc-settings.json` に反映済みなら、リポジトリ側の設定をコピーします。

既存の設定を残したい場合は、コピー前に backup を作ります。

```sh
backup_ts="$(date +%Y%m%d-%H%M%S)"
test -f "$HOME/.vimrc" && cp "$HOME/.vimrc" "$HOME/.vimrc.backup.$backup_ts"
test -f "$HOME/.vimrc.minimal" && cp "$HOME/.vimrc.minimal" "$HOME/.vimrc.minimal.backup.$backup_ts"
test -f "$HOME/.vim/coc-settings.json" && cp "$HOME/.vim/coc-settings.json" "$HOME/.vim/coc-settings.json.backup.$backup_ts"
```

```sh
mkdir -p "$HOME/.vim"
cp vimrc "$HOME/.vimrc"
cp vimrc.minimal "$HOME/.vimrc.minimal"
cp coc-settings.json "$HOME/.vim/coc-settings.json"
```

反映後、通常どおり Vim を起動します。

```sh
vim
```

## 任意ツールを更新する場合

現時点では必須ダウンロードはありません。追加済みの任意ツールがある場合だけ更新します。

| ツール | 確認コマンド |
|---|---|
| Vim | `vim --version \| head -n 1` |
| `git` | `git --version` |
| `ripgrep` | `rg --version` |
| `fzf` | `fzf --version` |
| Node.js | `node -v` |
| npm | `npm -v` |
| `glow` | `glow --version` |

`rg`、`fzf`、`glow` を単体 binary で管理している場合の更新方法は [CLI ツール管理](cli-tools.md) を確認してください。

Tokyo Night theme plugin を Vim 標準 package 機能で入れている場合は、配置先の Git repository を更新します。

```sh
git -C "$HOME/.vim/pack/vendor/start/tokyonight-vim" pull --ff-only
```

`coc.nvim` 中心の構成を入れた場合の更新方法は [coc.nvim 構成メモ](coc-setup.md) を確認してください。

## プロジェクト側 language server を更新する場合

Tailwind、PHP、Astro はプロジェクト側の npm devDependency として管理します。更新は対象プロジェクト側で行います。

```sh
npm update @tailwindcss/language-server @astrojs/language-server intelephense
```

Rust は `rustup` component として管理します。

```sh
rustup update
rustup component add rust-analyzer rust-src
```
