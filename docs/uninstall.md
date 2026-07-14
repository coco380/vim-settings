# uninstall 手順

この Vim 設定を外す手順です。

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

`coc.nvim` 中心の構成を入れた場合の削除方法は [coc.nvim 構成メモ](coc-setup.md) を確認してください。
