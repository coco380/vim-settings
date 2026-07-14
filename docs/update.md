# update 手順

この Vim 設定を更新するときの手順です。

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
