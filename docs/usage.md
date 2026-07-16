# 使い方

通常設定は Vim 本体だけで、ファイル探索、Git、terminal、quickfix を扱います。`<Space>` が Leader です。

## キーバインド

| 分類 | キー | 操作 |
|---|---|---|
| 基本 | `<Space>w` / `<Space>q` / `<Space>Q` | 保存 / 現在の buffer を閉じる / Vim を終了 |
| ファイル | `<Space>e` | `netrw` explorer をトグル(非表示なら開く、フォーカス外なら移動、フォーカス中なら閉じる) |
| 探索 | `<Space>ff` / `<Space>fr` / `<Space>fb` | project のファイルを fuzzy に `:find` / 最近使ったファイル / buffer を選択 |
| 検索 | `<Space>fw` / `<Space>fG` | 入力した語を検索 / Git 管理下のファイルを検索 |
| パス | `<Space>yp` / `<Space>yP` / `<Space>yl` | Git root 相対パス / 絶対パス / 絶対パスと行番号をコピー |
| Finder | `<Space>of` | netrw ではカーソル下のファイル、通常 buffer では現在のファイルを Finder で選択表示(macOS の `open -R`) |
| 置換 | `<Space>sr` / `<Space>sw` / `<Space>sG` | 範囲 / 単語 / Git worktree 内を置換 |
| コメント | `gcc` / `gc` / `<Space>/` | 行 / motion・選択範囲 / VSCode 風のトグル(runtime に `comment` package を同梱する Vim のみ。macOS の Vim 9.1 は同梱) |
| Git | `<Space>gg` / `<Space>gb` / `<Space>gd` / `<Space>gD` | status / blame / unified diff / side-by-side diff |
| buffer | `[b` / `]b` / `<Space>bn` / `<Space>bp` / `<Space>bd` / `<Space>bo` | 前後移動 / 次・前 / 閉じる(ウィンドウは維持し直前のファイルを表示。terminal などのパネルではウィンドウを閉じる) / 他を閉じる |
| 問題 | `[q` / `]q` / `<Space>xq` | quickfix の前後 / 開く |
| location list | `[l` / `]l` / `<Space>xl` | 前後 / 開く |
| terminal | `<Space>ot` / `<Esc><Esc>` | terminal をトグル(非表示なら開く、フォーカス外なら移動、フォーカス中なら閉じる) / normal mode へ戻る |
| window | `<C-w>` + `>` `<` `+` `-` | リサイズモードに入り、以降は単押し(押しっぱなし)で連続リサイズ。他のキーで解除 |

移動は Vim 標準の `<C-o>` と `<C-i>`、window 操作は `<C-w>` を使います。visual mode の `<` / `>` はインデント後も選択を維持します。

`<Space>ff` は現在のファイルの Git root を window-local cwd にします。Vim 9.1 の `findfunc` が使える場合は `git ls-files`(未管理ファイル含む)の一覧を `matchfuzzy()` で絞り込み、VSCode の Quick Open に近い fuzzy 検索になります。除外は `.gitignore` に従うため、Git に追跡されているファイルは `dist` などでも候補に残ります。Git 管理外では `glob()`、`findfunc` 非対応の Vim では従来の `path=.,**` を使い、これらは `wildignore` の `.git`、`.vim`、`node_modules`、`dist`、`build`、`coverage` を除外します。候補は既定で 20000 件までです(`g:quickopen_file_limit` で変更可)。

`<Space>fr` は開いている buffer と `viminfo` の履歴から最近使ったファイルを新しい順に補完します。引数なしで実行すると直前のファイルを開きます(VSCode の `Ctrl+Tab` 相当)。

quickfix の結果は Vim 同梱の `cfilter` package で絞り込めます。`:Cfilter {pattern}` で一致だけを残し、`:Cfilter! {pattern}` で除外します。

`<Space>of` の実行コマンドは `g:finder_reveal_command` で差し替えられます。list 形式(既定 `['open', '-R']`)で、末尾に対象の絶対パスが引数として追加されます。

## ウィンドウの配置とサイズ

VSCode(Cursor)のレイアウトに合わせ、各機能のウィンドウは位置とサイズを固定しています。

| ウィンドウ | 位置 | サイズ |
|---|---|---|
| explorer(`netrw`) | 左端・全高 | 32 桁 |
| 検索結果(quickfix)/ Git status | ツリーの下の共有スロット(互いに上書き) | 幅 32 桁・左列の約 50% |
| terminal | エディタの下 | エディタ幅・高さ約 30%(端末が狭い場合は縮小) |
| location list | 現在のウィンドウの下 | 高さ約 30% |
| blame などの scratch | 右側 | 80 桁 |
| side-by-side diff | エディタ領域 | 左右 50/50 |

ツリーの表示中にファイルを開くと、該当ファイルの位置まで自動で展開してツリー上にカーソルを合わせます(VSCode の `explorer.autoReveal` 相当。`let g:tree_auto_reveal = 0` で無効化、手動実行は `:RevealInTree`)。netrw の tree 表示(`liststyle` 3、この設定の既定)専用で、netrw の `i` で表示形式を変えている間は動作しません。同じファイルへの連続した `BufEnter` では走査を省略します。

VSCode のサイドバーにあたる検索結果(`<Space>fw` / `<Space>fG` / `<Space>xq`)と Git status(`<Space>gg`)は、ツリーを残したままツリー下の 1 つのウィンドウを共有し、開くたびに上書きされます。ツリーが閉じているときは左端の単独カラムとして開きます。検索結果で `<CR>` を押すとエディタ側でファイルが開き、サイドバーは残ります。`<Space>e` のトグルでツリーを閉じると、スロットも一緒に閉じます。

terminal はエディタが 1 枚のとき VSCode と同じ「右側エリアの下」になります。エディタを左右分割している場合は、Vim のウィンドウモデル上、右側全体ではなくプライマリエディタの下に付きます。

`noequalalways` により、ウィンドウの開閉で全ウィンドウが均等化されることはなくなります。固定ペインは `winfixwidth` / `winfixheight` で通常の操作ではサイズを保ちますが、端末が極端に狭い場合は縮みます。閉じたウィンドウの領域は隣接ウィンドウへ渡されます。

手動リサイズは `<C-w>` の `>` `<` `+` `-` を一度押すとリサイズモードに入り、以降は `>` `<` `+` `-` の単押し(押しっぱなしのキーリピート含む)で連続して変えられます。横は 2 桁、縦は 1 行刻みで、他のキーを押すと解除されてそのキーは通常どおり動作します。`3<C-w>>` のような count も使えます。`mouse=a` のため、区切り線のマウスドラッグも可能です。

Git status・blame などの scratch は、同種のものを繰り返し開いても新しいウィンドウを積まず、既存のパネルを再利用します。side-by-side diff はどちらか一方を閉じると差分表示が終了し、ファイル側のウィンドウは通常表示に戻ります。

`<Space>fw` は `rg`、Git worktree では `git grep`、それ以外では `grepprg` を使い、結果を quickfix に表示します。

## Git と explorer

`<Space>gg` は Git status buffer を開きます。

| キー | 操作 |
|---|---|
| `a` / `r` / `R` | stage / unstage / discard |
| `<CR>` / `o` | 既存のエディタで開く / エディタ領域を split して開く |
| `d` | side-by-side diff を開く |
| `gr` | status を更新 |
| `q` | 閉じる |

`<Space>gd` は `HEAD` との unified diff を、`<Space>gD` は side-by-side diff を開きます。いずれも staged と unstaged の変更を含みます。side-by-side diff は VSCode の diff editor と同様、ファイル全体を折りたたまずに表示し、最初の差分にフォーカスします。左右のペインは縦・横ともスクロールが同期します。

`<Space>e` の `netrw` では `<CR>` で開き、`d` でディレクトリ作成、`%` でファイル作成、`D` で削除できます。

## 任意機能

LSP を導入した場合は次が使えます。設定手順は [Coc 構成](coc.md) を参照してください。

| キー | 操作 |
|---|---|
| `gd` / `gy` / `gi` / `gr` | definition / type definition / implementation / references |
| `K` | hover |
| `<Space>cr` | rename |
| `<Space>ca` | code action |
| `[d` / `]d` | diagnostic の前後移動 |
| `<Space>cf` | format |

Git hunk sign は標準構成には含めません。必要性が継続する場合だけ、`vim-gitgutter` や `fzf` などを個別に評価します。コメントのトグルと fuzzy file search は、対応する Vim(9.1 の `comment` package 同梱 runtime、`findfunc` 対応)であれば同梱機能で対応済みです。

## 困ったとき

| 状況 | 確認 |
|---|---|
| 設定が読まれているか | `:scriptnames`、`:messages` |
| ファイルが見つからない | `:set path? wildignore?`、`:pwd` |
| 検索が失敗する | `:set grepprg?`、`rg --version` |
| Git 操作が期待と違う | `:pwd`、`git status` |
| LSP が動かない | `:CocInfo`、[Coc 構成](coc.md) |

配色 plugin がない場合でも、設定は Vim 標準配色で動作します。
