# Plugin 導入判断メモ

LSP、diagnostics、rename、code action、Git hunk sign、コメント切り替えを Vim で使うための候補です。まだ導入はしません。

## 現在の環境

この Mac の Vim は以下を満たしています。

- Vim 9.1
- `+job`
- `+channel`
- `+popupwin`
- `+textprop`
- `+signs`
- `+terminal`

LSP / diagnostics / Git hunk sign 系の plugin を動かす条件は概ね満たしています。

Node.js / npm も入っています。

- Node.js: `v24.18.0`
- npm: `11.16.0`

## 欲しい機能

| 欲しい機能 | 必要なもの |
|---|---|
| LSP | LSP client plugin + language server |
| diagnostics | LSP client または linter plugin |
| rename | LSP client |
| code action | LSP client |
| Git hunk sign | Git hunk sign plugin |
| コメント切り替え | comment plugin |

## 採用候補: coc.nvim 中心

構成:

- `neoclide/coc.nvim`

特徴:

- `coc.nvim` は VSCode extension に近い考え方
- LSP / diagnostics / rename / code action / completion をまとめて扱える
- TypeScript、ESLint、Prettier、JSON、CSS、HTML、YAML は coc extension で扱いやすい
- Tailwind、PHP、Astro、Rust は direct LSP としてプロジェクト側または toolchain 側の language server を使う

メリット:

- VSCode 風の IDE 機能に一番近い
- TypeScript / React / Astro / Tailwind / Rust / PHP をまとめて扱いやすい

懸念:

- Node.js 前提
- coc extension の install / update / cache が増える
- `~/.config/coc` や `~/.cache/coc` など管理対象が増える
- 今の「環境をあまりごちゃごちゃさせたくない」方針とはやや相性が悪い

## Git hunk sign 候補

### vim-gitgutter

Git 専用。追加 / 変更 / 削除の sign、hunk preview、stage、undo などが揃っています。

今回の Git 利用が Git 前提なら第一候補です。

## コメント切り替え候補

### vim-commentary

`gcc`、`gc{motion}`、visual mode の `gc` を提供します。小さく、Vim の `commentstring` に寄せる設計です。

コメント切り替えだけなら第一候補です。

## plugin 管理方針

環境を汚しにくくするため、`vim-plug` ではなく Vim 標準 package 機能を使う方針です。

例:

```txt
~/.vim/pack/vendor/start/tokyonight-vim
~/.vim/pack/vendor/start/coc.nvim
~/.vim/pack/vendor/start/vim-gitgutter
~/.vim/pack/vendor/start/vim-commentary
```

削除は該当ディレクトリを消すだけです。

```sh
rm -rf "$HOME/.vim/pack/vendor/start/tokyonight-vim"
rm -rf "$HOME/.vim/pack/vendor/start/coc.nvim"
rm -rf "$HOME/.vim/pack/vendor/start/vim-gitgutter"
rm -rf "$HOME/.vim/pack/vendor/start/vim-commentary"
```

## 導入検討項目

TypeScript / React / Astro / Tailwind を重視し、VSCode に近い補完や LSP 体験を優先するため、以下を採用候補にします。

Theme:

1. `tokyonight-vim`

`tokyonight-vim` は 2022-03-01 から archived / read-only です。静的な Vim colorscheme として使う分には小さく扱いやすい一方、今後の Vim 互換性修正は期待しません。この設定では未導入時も内蔵 fallback で起動できるようにします。

LSP / 補完:

1. `coc.nvim`

追加で検討する場合:

1. `vim-gitgutter`
2. `vim-commentary`

`coc.nvim` の導入・更新・削除方針は [coc.nvim 構成メモ](coc-setup.md) にまとめます。`vim-gitgutter` と `vim-commentary` は deferred 扱いで、必要になった時点で個別に導入判断します。

## 参照

- tokyonight-vim: https://github.com/ghifarit53/tokyonight-vim
- coc.nvim: https://github.com/neoclide/coc.nvim
- vim-gitgutter: https://github.com/airblade/vim-gitgutter
- vim-commentary: https://github.com/tpope/vim-commentary
