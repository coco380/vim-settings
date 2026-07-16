# VSCode 開発体験との対応

この設定は VSCode のレイアウトや装飾ではなく、ファイルを探す、変更箇所へ移動する、問題を確認する、差分を見る、terminal を使う、といった開発フローを対象にします。

比較基準は 2026-07-15 時点の VSCode 公式ドキュメントです。

- [User interface](https://code.visualstudio.com/docs/editing/userinterface)
- [Code navigation](https://code.visualstudio.com/docs/editing/editingevolved)
- [Basic editing](https://code.visualstudio.com/docs/editing/codebasics)
- [Core editor features](https://code.visualstudio.com/docs/core-editor/overview)

## 標準構成で対応するもの

| VSCode の導線 | Vim での対応 | 差分 |
|---|---|---|
| Explorer (`Cmd+B` トグル) | `<Space>e` の `netrw` トグル。ファイルを開くと自動で該当位置を展開・表示(`explorer.autoReveal` 相当) | tree 表示と基本的なファイル操作に限定 |
| Quick Open (`Cmd+P`) | `<Space>ff` の fuzzy `:find`(`findfunc` + `matchfuzzy()`) | Git 管理下では `git ls-files` の一覧を fuzzy 絞り込み。`findfunc` 非対応の Vim では prefix / wildcard completion |
| Quick Open の MRU / `Ctrl+Tab` | `<Space>fr` の最近使ったファイル。引数なしで直前のファイル | editor group 単位の履歴は持たない |
| Open Editors | `<Space>fb` の `:buffer` completion、`[b` / `]b` | preview editor は持たない |
| Back / Forward | Vim 標準の `<C-o>` / `<C-i>` | jumplist を利用 |
| Command Palette | Vim 標準の `:` と command-line completion(fuzzy) | 説明文による検索はしない |
| Search(sidebar) | `<Space>fw` と quickfix。結果はツリー下のスロットに表示、`<CR>` でエディタに開く。`:Cfilter` で絞り込み | `rg`、Git worktree では `git grep`、それ以外は `grepprg` を利用 |
| Problems | `<Space>xq` / `[q` / `]q`、location list は `<Space>xl` / `[l` / `]l` | VSCode は下部パネルだが、quickfix ウィンドウは 1 つのため Search と同じツリー下スロットに統一。compiler / LSP は別途必要 |
| Source Control(sidebar) | `<Space>gg` をツリー下スロットに表示。`d` の diff はエディタ側に開き status は残る。blame、unified diff、side-by-side diff(全体表示・最初の差分にフォーカス・縦横スクロール同期) | commit、branch、remote 操作は terminal の Git に委ねる |
| Integrated Terminal (``Ctrl+` `` トグル) | `<Space>ot` のトグル。エディタの下(サイドバーの右) | 単一 terminal buffer を再利用。エディタを左右分割中はプライマリエディタの下に付く |
| Toggle Line Comment (`Cmd+/`) | `gcc` / `gc` / `<Space>/`(Vim 同梱 `comment` package) | runtime に同梱する Vim のみ(macOS の Vim 9.1 は同梱)。`'commentstring'` に依存し、block comment の toggle は行わない |
| Reveal in Finder | `<Space>of`(netrw ではカーソル下、通常 buffer では現在ファイル) | macOS の `open -R` を利用。`g:finder_reveal_command` を list 形式(例 `['xdg-open']`。末尾に対象パスが引数として追加)で差し替え可能だが、`xdg-open` などは選択表示ではなく対象を開く動作になる |
| Copy Path | `<Space>yp` / `<Space>yP` / `<Space>yl` | relative path は現在ファイルの Git root 基準 |
| External file changes | `autoread` と `checktime` | 未保存の変更は自動で破棄しない |
| Text completion | Vim 標準の insert mode `<C-n>` / `<C-p>` | semantic completion ではない |
| Matching bracket | Vim 標準の `%` と `MatchParen` | bracket pair colorization は行わない |
| Indent / Outdent で選択維持 | visual mode の `<` / `>` に `gv` を付加 | multi-cursor は対象外のまま |
| Sidebar / Panel のサイズ・位置の固定 | `noequalalways` + `winfixwidth` / `winfixheight`。sidebar 左端 32 桁(ツリー+下側の共有スロット)、terminal はエディタ下・高さ約 30%(Cursor 実測比) | 通常サイズでは維持されるが、極端に狭い端末では縮む |
| ウィンドウ境界のドラッグ | `<C-w>` 後のリサイズモード(キー押しっぱなしで連続リサイズ)と `mouse=a` のマウスドラッグ | ピクセル単位ではなく桁・行単位 |

`<Space>e` と `<Space>ot` は VSCode の sidebar / panel トグルに合わせ、非表示なら開く、フォーカス外ならフォーカス、フォーカス中なら閉じる、と動きます。

`<Space>ff` は実行時に window-local cwd を現在ファイルの Git rootへ移します。Vim 9.1 の `findfunc` が使える場合は `git ls-files --cached --others --exclude-standard` の結果を `matchfuzzy()` で絞り込み、`.gitignore` を尊重した fuzzy 検索になります。VSCode の `search.exclude` と異なり、Git に追跡されているファイルは除外されません。Git 管理外では `glob()` を使い、`wildignore` の `.git`、`.vim`、`node_modules`、`dist`、`build`、`coverage` を除外します。`findfunc` 非対応の Vim では従来の `path=.,**` に戻ります。候補は既定で 20000 件までです(`g:quickopen_file_limit`)。対話的に候補一覧を眺めながら選ぶ picker UI が必要な場合だけ `fzf` を任意導入します。

## 任意構成で対応するもの

| VSCode の機能 | 追加するもの | この repo での位置づけ |
|---|---|---|
| semantic completion / signature help | `coc.nvim` + language server | 任意 |
| definition / references / implementation | `coc.nvim` + language server | 任意 |
| rename / code action / format | `coc.nvim` + formatter / language server | 任意 |
| diagnostics / inline warning | `coc.nvim` + linter / language server | 任意 |
| fuzzy symbol search / picker UI | `fzf` または Coc list | 任意。fuzzy file search 自体は標準構成の `<Space>ff` が対応 |
| Git hunk sign / hunk action | `vim-gitgutter` など | 導入候補に留める |

導入手順は [Coc 構成](coc.md) を参照してください。追加 plugin は、継続的に必要な機能だけを個別に評価します。

## 意図的に対象外にするもの

- VSCode の Activity Bar、Side Bar、icon、tab の外観再現
- Debug Adapter Protocol を使う統合 debugger
- multi-cursor の操作体系そのもの。Vim の operator、macro、visual block、置換を使う
- extension marketplace や自動的な tool install
- project を開いただけで任意コードを実行する task / workspace hook

これらを標準構成へ自作すると、設定量と状態管理が増え、Vim本体や外部CLIの更新に追従する負担が大きくなります。必要になった時点で、用途を限定した既存実装を個別に評価します。
