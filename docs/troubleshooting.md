# トラブルシュート

よくある問題と確認コマンドです。

## repo の `vimrc` が読まれているか確認したい

repo 内で次のように起動します。

```sh
vim -Nu ./vimrc
vim --noplugin -Nu ./vimrc.minimal
```

Vim 内で確認します。

```vim
:echo $MYVIMRC
:scriptnames
```

`$MYVIMRC` が空でも、`-Nu ./vimrc` で指定したファイルは読み込まれます。詳しく見る場合は `:scriptnames` を確認してください。

## 起動確認だけしたい

画面を開かずに読み込みだけ確認します。

```sh
vim -Nu ./vimrc -i NONE -n -es +'qa!'
vim --noplugin -Nu ./vimrc.minimal -i NONE -n -es +'qa!'
```

終了コードが `0` なら、少なくとも読み込み時の致命的なエラーはありません。

## 色が想定と違う

Vim 内で確認します。

```vim
:set termguicolors?
:set background?
:highlight Normal
```

端末側の色設定によって見え方が変わる場合があります。表示が崩れる場合は、一時的に true color を切って確認します。

```vim
:set notermguicolors
:redraw!
```

戻す場合:

```vim
:set termguicolors
:redraw!
```

## `<Space>e` で explorer が開かない

`netrw` が読み込めているか確認します。

```vim
:Lexplore
:scriptnames
```

`netrw` は Vim 標準 plugin です。`-u NONE` ではなく、この repo の確認では `-Nu ./vimrc` を使ってください。

## `<Space>fw` の検索が期待通りでない

現在の grep 設定を確認します。

```vim
:set grepprg?
:set grepformat?
```

`rg` がある場合は `rg --vimgrep` を使います。なければ現在ファイルまたは cwd が Git worktree 内にある場合だけ `git grep` を使います。

```sh
which rg
which git
```

検索結果は quickfix に入ります。

```vim
:copen
:cnext
:cprevious
```

## Git 系キーマップが動かない

まず Git が使えるか確認します。

```sh
git --version
git rev-parse --is-inside-work-tree
```

Vim 内では、対象ファイルを開いた状態で使います。

```vim
:GitStatus
:GitBlame
:GitDiff
```

`GitBlame` は未追跡ファイルでは失敗します。先に Git 管理下のファイルか確認してください。

```sh
git ls-files -- path/to/file
```

`GitDiff` は現在ファイルだけの diff を表示します。変更がない場合は `No git diff...` と表示されます。

`GitReplace` は置換後に自動保存しません。確認後に保存します。

```vim
:wall
```

## `<Space>om` で Markdown preview が開かない

`glow` が入っているか確認します。

```sh
which glow
glow --version
```

Vim 内では Markdown ファイルを開いた状態で使います。

```vim
:MarkdownPreview
```

未保存の新規ファイルは preview できません。先に保存してください。

## Vim の履歴や undo が repo 内にできる

これは意図した動作です。

```txt
.vim/state/
```

Mac 本体の `~/.viminfo` や `~/.vim/` をなるべく使わずに検証するため、repo 内に保存しています。`.vim/` は `.gitignore` で Git 管理外にしています。

## LSP / 補完 / diagnostics がない

repo 内の `vimrc` だけで起動している場合は未実装です。

必要な場合は [coc.nvim 構成メモ](coc-setup.md) に沿って `coc.nvim` 構成を追加します。
