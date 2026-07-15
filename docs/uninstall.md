# uninstall 手順

この Vim 設定を外す手順です。

## 読む順番

```txt
1. uninstall.md
2. cli-tools.md       rg / fzf / glow を入れている場合だけ
3. install.md         Tokyo Night theme plugin を入れている場合だけ
4. coc-setup.md       coc.nvim 構成を入れている場合だけ
5. troubleshooting.md 困った場合
```

まずこのファイルで `~/.vimrc`、`~/.vimrc.minimal`、Vim state、alias の削除方針を確認します。任意ツール、Tokyo Night theme plugin、coc.nvim 構成を入れている場合だけ、該当ドキュメントも確認します。

## 削除対象

最小構成を Mac 本体へ反映していた場合の削除対象:

```txt
~/.vimrc
~/.vimrc.minimal
~/.vim/state/
~/.vim/state-minimal/
```

alias を追加していた場合だけ、`~/.zshrc` から削除する行:

```sh
alias lvim='vim --noplugin -Nu "$HOME/.vimrc.minimal"'
alias vvim='vim -Nu NONE -i NONE -n'
```

任意 CLI を単体 binary として入れていた場合だけ削除するもの:

```txt
~/.local/bin/rg
~/.local/bin/fzf
~/.local/bin/glow
```

任意 plugin 構成を入れていた場合だけ削除対象になるもの:

```txt
~/.vim/pack/vendor/start/tokyonight-vim/
~/.vim/pack/vendor/start/coc.nvim/
~/.vim/coc-settings.json
~/.config/coc/
~/.cache/coc/
```

`~/.vim/`、`~/.local/bin/`、Node.js、npm、`~/.npm` は他の用途でも使われる可能性があるため、この設定の削除だけを理由に丸ごと消しません。

削除前に、対象が存在するかを確認します。

```sh
ls "$HOME/.vimrc" "$HOME/.vimrc.minimal" "$HOME/.vim/coc-settings.json"
ls "$HOME/.local/bin/rg" "$HOME/.local/bin/fzf" "$HOME/.local/bin/glow"
ls "$HOME/.vim/pack/vendor/start/tokyonight-vim" "$HOME/.vim/pack/vendor/start/coc.nvim"
```

`ls` が `No such file or directory` を出す対象は、既に存在しないため削除不要です。

## repo 内検証だけの場合

`vim -Nu ./vimrc` や `vim --noplugin -Nu ./vimrc.minimal` で試しているだけなら、Mac 本体の Vim 設定は変更されていません。

削除対象は、リポジトリ内の Vim 作業データだけです。

```sh
rm -rf .vim
```

`.vim/` は `.gitignore` で Git 管理外にしています。

## Mac 本体へ反映済みの場合

`vimrc` や `vimrc.minimal` を Mac 本体へコピー済みなら、削除前に中身を確認してください。

```sh
ls "$HOME/.vimrc"
ls "$HOME/.vimrc.minimal"
ls "$HOME/.vim/coc-settings.json"
```

この設定だけを消してよい場合:

```sh
rm -f "$HOME/.vimrc"
rm -f "$HOME/.vimrc.minimal"
rm -f "$HOME/.vim/coc-settings.json"
```

この設定で作られた Vim state も消してよい場合だけ削除します。

```sh
rm -rf "$HOME/.vim/state"
rm -rf "$HOME/.vim/state-minimal"
```

timestamp 付き backup から戻す場合は、対象を確認してからコピーします。

```sh
ls "$HOME"/.vimrc.backup.*
ls "$HOME"/.vimrc.minimal.backup.*
ls "$HOME"/.vim/coc-settings.json.backup.*
```

例:

```sh
cp "$HOME/.vimrc.backup.YYYYMMDD-HHMMSS" "$HOME/.vimrc"
cp "$HOME/.vimrc.minimal.backup.YYYYMMDD-HHMMSS" "$HOME/.vimrc.minimal"
cp "$HOME/.vim/coc-settings.json.backup.YYYYMMDD-HHMMSS" "$HOME/.vim/coc-settings.json"
```

既存の `~/.vimrc` や `~/.zshrc` に手で追記した場合は、該当箇所だけを手動で削除してください。`lvim` / `vvim` alias を追加していた場合も同様です。

```sh
alias lvim='vim --noplugin -Nu "$HOME/.vimrc.minimal"'
alias vvim='vim -Nu NONE -i NONE -n'
```

## 任意ツールを導入済みの場合

現時点の標準構成では任意ツールは必須ではありません。後から入れたものだけ削除してください。

| ツール | 削除の考え方 |
|---|---|
| `ripgrep` | 導入方法に合わせて削除します |
| `fzf` | 単体 binary と、追加していれば shell integration を削除します |
| Node.js / npm | 他の開発環境でも使うことが多いので慎重に判断します |
| `glow` | 配置した binary を削除します |

他の開発環境と共有しているツールは、この Vim 設定のためだけに削除しないでください。

`rg`、`fzf`、`glow` を単体 binary で入れた場合の削除方法は [CLI ツール管理](cli-tools.md) を確認してください。

Tokyo Night theme plugin を入れた場合は、該当 package ディレクトリだけを削除します。

```sh
rm -rf "$HOME/.vim/pack/vendor/start/tokyonight-vim"
```

`coc.nvim` 中心の構成を入れた場合の削除方法は [coc.nvim 構成メモ](coc-setup.md) を確認してください。
