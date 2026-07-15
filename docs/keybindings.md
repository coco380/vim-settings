# 主なキーバインド

Leader キーは `<Space>` です。

この一覧は通常の `vimrc` 向けです。`lvim` で使う `vimrc.minimal` は小さい画面向けに keymap を絞っており、`<Space>e` は netrw explorer ではなく `:edit` の開始だけを行います。

## 現在使えるもの

### 基本操作

| キー | 何をするか |
|---|---|
| `<Space>w` | 保存する |
| `<Space>q` | 確認付きで終了する |
| `<Space>Q` | 確認付きで全終了する |
| `<Space>nh` | 検索ハイライトを消す |

### ファイル / 検索

| キー | 何をするか |
|---|---|
| `<Space>e` | Vim 標準の `netrw` explorer を開く |
| `<Space>ff` | `:find` を開始する |
| `<Space>fw` | `:grep` を開始する |
| `<Space>fG` | Git 管理下ファイルだけを文字検索する |
| `<Space>yp` | 現在ファイルの相対パスをコピーする |
| `<Space>yP` | 現在ファイルの絶対パスをコピーする |
| `<Space>yl` | 現在ファイルの絶対パスと行番号をコピーする |

`<Space>fw` は、実行時に検索方法を選びます。`rg` があれば `rg --vimgrep`、なければ現在ファイルまたは cwd が Git worktree 内にある場合だけ `git grep` を使います。`git grep` に切り替える場合は window-local cwd を Git root に移します。どちらも使えない場合は Vim 標準の grep 設定に従います。

`<Space>fG` は `git grep -I --fixed-strings` ベースです。未追跡ファイルとバイナリファイルは対象外です。

### 置換

| キー | 何をするか |
|---|---|
| `<Space>sr` | 現在ファイルまたは選択範囲で確認付き置換を始める |
| `<Space>sw` | カーソル下の単語を確認付き置換する |
| `<Space>sG` | Git 管理下ファイルだけを確認付き置換する |

`<Space>sG` は対象ファイルを arglist に入れて `:%s///gce` を確認付きで実行します。置換後は自動保存しないため、内容を確認してから `:wall` などで保存してください。

### Git

| キー | 何をするか |
|---|---|
| `<Space>gg` | `git status` を scratch buffer に表示し、その場で stage / unstage / discard / diff を行う |
| `<Space>gb` | 現在ファイルの `git blame` を scratch buffer に表示する |
| `<Space>gd` | 現在ファイルの `git diff` を scratch buffer に表示する |

`<Space>gb` と `<Space>gd` は、読み込み済みの通常ファイルに対して使います。現在ファイルの場所から Git worktree root を解決して実行するため、Vim の起動時 cwd が別の場所でも使えます。未追跡ファイルでは blame は失敗します。

### バッファ / ウィンドウ

| キー | 何をするか |
|---|---|
| `[b` | 前のバッファへ移動する |
| `]b` | 次のバッファへ移動する |
| `<Space>bn` | 次のバッファへ移動する |
| `<Space>bp` | 前のバッファへ移動する |
| `<Space>bd` | 現在のバッファを閉じる |
| `<Space>bo` | 他の通常バッファを閉じる |
| `<C-w>w` | 次のウィンドウへ移動する |
| `<C-w>v` | 縦分割する |
| `<C-w>s` | 横分割する |
| `<C-w>h` | 左のウィンドウへ移動する |
| `<C-w>j` | 下のウィンドウへ移動する |
| `<C-w>k` | 上のウィンドウへ移動する |
| `<C-w>l` | 右のウィンドウへ移動する |
| `<C-w>=` | 可能な範囲でウィンドウサイズを揃える |
| `<C-w>>` / `<C-w><` | 現在ウィンドウの幅を広げる / 狭める |
| `<C-w>+` / `<C-w>-` | 現在ウィンドウの高さを広げる / 狭める |

`<C-w>` 系は Vim 標準です。この repo 独自の key ではありません。

### ターミナル

| キー | 何をするか |
|---|---|
| `<Space>ot` | ターミナルを開く |
| `<Space>om` | `glow` で Markdown preview を開閉する |
| terminal mode で `<Esc><Esc>` | terminal normal mode に戻る |

terminal mode から戻る Vim 標準操作は `Ctrl-\ Ctrl-n` です。`<Esc><Esc>` はこの repo の追加です。

## この repo 固有

以下は Vim 標準そのままではなく、この repo の `vimrc` / `vimrc.minimal` で追加している key です。

### 通常時

| キー | 何をするか |
|---|---|
| `<Space>w` | 保存する |
| `<Space>q` | 確認付きで終了する |
| `<Space>Q` | 確認付きで全終了する |
| `<Space>nh` | 検索ハイライトを消す |
| `<Space>e` | `vimrc` では `netrw` を開く。`vimrc.minimal` では `:edit` 開始 |
| `<Space>fw` | project 向け grep を開始する |
| `<Space>fG` | Git 管理下ファイルだけを文字検索する |
| `<Space>ff` | `:find` を開始する |
| `<Space>yp` | 現在ファイルの相対パスをコピーする |
| `<Space>yP` | 現在ファイルの絶対パスをコピーする |
| `<Space>yl` | 現在ファイルの絶対パスと行番号をコピーする |
| `<Space>sr` | 確認付き置換を始める |
| `<Space>sw` | カーソル下単語を確認付き置換する |
| `<Space>sG` | Git 管理下ファイルだけを確認付き置換する |
| `<Space>gg` | Git status scratch buffer を開く |
| `<Space>gb` | Git blame scratch buffer を開く |
| `<Space>gd` | Git diff scratch buffer を開く |
| `<Space>bn` / `<Space>bp` / `<Space>bd` / `<Space>bo` | バッファ移動 / 削除 |
| `<Space>ot` | ターミナルを開く |
| `<Space>om` | `glow` で Markdown preview を開閉する |

### Git status buffer

`<Space>gg` で開く scratch buffer だけで有効になる key です。

| キー | 何をするか |
|---|---|
| `a` | stage |
| `r` | unstage |
| `R` | 確認付きで discard |
| `d` | 現在行の file の diff を開く |
| `<CR>` | 現在行の file を開く |
| `o` | 現在行の file を split で開く |
| `gr` | status を再読込する |
| `q` | buffer を閉じる |

### terminal mode

| キー | 何をするか |
|---|---|
| `<Esc><Esc>` | terminal normal mode に戻る |

## 未実装

以下は、repo 内の `vimrc` だけでは未実装です。`coc.nvim` 構成を入れる場合に追加します。

| キー | 何をするものか | 現時点の扱い |
|---|---|---|
| `<Space>/` | コメント切り替え | `vim-commentary` 導入後に追加 |
| `<Space>fg` / `<Space>fb` / `<Space>fr` / `<Space>fl` | fuzzy finder | `fzf` を使う場合に検討 |
| `gd` / `gr` / `K` | LSP 移動 / 参照 / hover | `coc.nvim` 導入後に追加 |
| `<Space>ca` / `<Space>cr` / `<Space>cf` | code action / rename / format | `coc.nvim` 導入後に追加 |
| `<Space>xx` / `[d` / `]d` | diagnostics | `coc.nvim` 導入後に追加 |
| `<Space>hs` / `<Space>hp` / `<Space>hn` | Git hunk 操作 | `vim-gitgutter` 導入後に追加 |

`coc.nvim` を入れると LSP 系 keymap が有効になります。`vim-commentary` と `vim-gitgutter` は導入検討項目として `vimrc` 内に guarded keymap だけ残してあります。plugin がない状態では読み飛ばします。
