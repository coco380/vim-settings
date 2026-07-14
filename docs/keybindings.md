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
| `<Space>gg` | `git status --short --branch` を scratch buffer に表示する |
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
| `<C-w>=` | ウィンドウサイズを揃える |

### ターミナル

| キー | 何をするか |
|---|---|
| `<Space>ot` | ターミナルを開く |
| `<Space>om` | `glow` で Markdown preview を開閉する |
| terminal mode で `<Esc><Esc>` | terminal normal mode に戻る |

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

`coc.nvim`、`vim-gitgutter`、`vim-commentary` 導入後は、`vimrc` 内の guarded keymap が有効になります。plugin がない状態では読み飛ばします。
