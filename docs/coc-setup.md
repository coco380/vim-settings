# coc.nvim 構成メモ

LSP、diagnostics、rename、code action、補完を Vim で使う場合は、`coc.nvim` 中心の構成を候補にします。まだ導入はしません。

`diagnostics` は、編集中ファイルに対して Vim 上に出るエラーや警告のことです。たとえば syntax error、型エラー、lint error、未使用変数などが該当します。

## 構成

```txt
coc.nvim
```

役割:

| plugin | 役割 |
|---|---|
| `coc.nvim` | LSP / diagnostics / rename / code action / 補完 |

## 前提

- Vim 9.1
- Node.js 20.19.0 以上
- npm
- git

この Mac では Node.js と npm は確認済みです。

```txt
Node.js: v24.18.0
npm: 11.16.0
```

## 増えるファイル

Vim 標準 package 機能を使う場合:

```txt
~/.vim/pack/vendor/start/coc.nvim
```

coc 設定:

```txt
~/.vim/coc-settings.json
```

coc の extension / cache:

```txt
~/.config/coc/
~/.cache/coc/
```

消さないもの:

```txt
~/.npm
Node.js
npm
```

`~/.npm` は他の Node.js 開発でも使う共有 cache なので、この Vim 設定の削除対象にはしません。

## install 方針

Vim plugin manager は使わず、Vim 標準 package 機能で管理します。

```sh
mkdir -p "$HOME/.vim/pack/vendor/start"
```

入れる場合の配置先:

```sh
git clone --depth 1 --branch release https://github.com/neoclide/coc.nvim.git "$HOME/.vim/pack/vendor/start/coc.nvim"
```

`coc.nvim` の `release` branch は、GitHub 上の Git branch です。Vim plugin として使う場合は、この branch を取得します。

選択肢:

| branch | 特徴 |
|---|---|
| `release` | Vim plugin として使いやすい配布済み構成。通常はこちら |
| `master` | 開発 branch。利用側で build が必要になるため、今回は使わない |

この構成では、安定寄りで管理しやすい `release` branch に固定します。

`coc.nvim` 公式設定例に合わせ、Coc 構成では Vim の backup / writebackup は使いません。このリポジトリの `vimrc` では `nobackup` / `nowritebackup` にしています。

## LSP / extension 方針

Rust は共通設定の direct LSP で扱います。Tailwind、PHP、Astro は、使わないプロジェクトで language server 起動エラーが出ないように、対象プロジェクト側の local Coc 設定でだけ有効化します。TypeScript、ESLint、Prettier、JSON、CSS、HTML、YAML は coc extension で扱います。

共通設定の direct LSP:

```txt
rust-analyzer
```

対象プロジェクトだけに置く direct LSP:

```txt
@tailwindcss/language-server
intelephense
@astrojs/language-server
```

coc extensions:

```txt
coc-tsserver
coc-eslint
coc-prettier
coc-json
coc-yaml
coc-css
coc-html
```

Tailwind CSS は v4 前提です。`@yaegassy/coc-tailwindcss3` は使いません。共通 `coc-settings.json` には `languageserver.tailwindCSS` を置かず、Tailwind を使う対象プロジェクトだけ `.vim/coc-settings.json` に local 設定を置きます。Tailwind CSS language server がプロジェクトを検出できるように、対象プロジェクトには `@import "tailwindcss";` などを含む CSS entrypoint が必要です。

PHP / WordPress は `coc-phpls` ではなく、プロジェクト側に入れた `intelephense` を project-local 設定の `languageserver.intelephense` から呼び出します。WordPress API の認識は未設定です。WordPress 専用の stubs や project-specific 設定は、対象プロジェクト側で必要になった時点で追加します。

Astro は `@yaegassy/coc-astro` ではなく、プロジェクト側に入れた `@astrojs/language-server` を project-local 設定の `languageserver.astro` から呼び出します。

Rust は `coc-rust-analyzer` ではなく、`rustup` component の `rust-analyzer` を直接呼び出します。

保存時整形:

- JS / TS / React / Astro / CSS / SCSS / HTML / JSON / YAML / Markdown は Prettier や各 language server の formatter を使います
- Prettier 対象 filetype は、対象プロジェクト側に `.prettierrc`、`prettier.config.*`、または `package.json` の `prettier` 設定が必要です
- Rust は `rust-analyzer` 経由で `rustfmt` を使います
- PHP は保存時整形の対象外です
- Stylelint は Vim 連携しません。必要なときだけ CLI を手動実行します

保存時整形とは別に、必要なときだけ Vim のコマンドラインから対象ファイルに対して整形コマンドを実行できます。

現在開いているファイルだけを整形する例:

```vim
:!npx prettier --write %
:!npx stylelint --fix %
```

- `%` は現在開いているファイルの path
- 任意の file を対象にする場合は、`%` の代わりに path を直接書く
- Ex command line なので、通常の file path 補完が使える

導入後、Vim 内で extension を入れます。

```vim
:CocInstall coc-tsserver coc-eslint coc-prettier coc-json coc-yaml coc-css coc-html
```

MoonBit は採用候補に含めません。

## Project-local LSP 設定

Tailwind CSS、PHP、Astro を使うプロジェクトでは、対象プロジェクト内で Vim を起動して `:CocLocalConfig` を実行し、作成された `.vim/coc-settings.json` に必要な LSP だけを追加します。共通設定には置かないため、使わないプロジェクトで `npx --no-install ...` の起動失敗が出るのを避けられます。

コピー元は [templates/coc/README.md](../templates/coc/README.md) にまとめています。

- [templates/coc/tailwind.json](../templates/coc/tailwind.json)
- [templates/coc/astro.json](../templates/coc/astro.json)
- [templates/coc/php.json](../templates/coc/php.json)
- [templates/coc/full.json](../templates/coc/full.json)

複数の project-local LSP を使う場合は、これらを別々のファイルとして置かず、同じ `.vim/coc-settings.json` に必要な key をまとめます。

Tailwind CSS の例:

```json
{
  "languageserver": {
    "tailwindCSS": {
      "command": "npx",
      "args": [
        "--no-install",
        "tailwindcss-language-server",
        "--stdio"
      ],
      "filetypes": [
        "astro",
        "html",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "css",
        "scss"
      ],
      "rootPatterns": [
        "package.json"
      ]
    }
  }
}
```

`rootPatterns` の `package.json` は Tailwind の有無判定ではなく、Coc の workspace root 検出に使います。local package を `npx --no-install` で解決しやすくするため、対象プロジェクト内で Vim を起動します。Tailwind v4 では `tailwind.config.*` がない構成もあるため、共通設定の自動判定には使いません。

PHP / WordPress の例:

```json
{
  "languageserver": {
    "intelephense": {
      "command": "npx",
      "args": [
        "--no-install",
        "intelephense",
        "--stdio"
      ],
      "filetypes": [
        "php"
      ],
      "rootPatterns": [
        "package.json",
        "composer.json",
        ".git"
      ]
    }
  }
}
```

Astro の例:

```json
{
  "languageserver": {
    "astro": {
      "command": "npx",
      "args": [
        "--no-install",
        "astro-ls",
        "--stdio"
      ],
      "filetypes": [
        "astro"
      ],
      "rootPatterns": [
        "package.json"
      ]
    }
  }
}
```

## 導入前チェック

導入前に現在の状態を確認します。

```sh
ls -la "$HOME/.vimrc"
ls -la "$HOME/.vim"
ls -la "$HOME/.config/coc"
ls -la "$HOME/.cache/coc"
```

この Mac では、確認時点で以下の状態です。

```txt
~/.vimrc      なし
~/.vim/       あり。中身は .netrwhist のみ
~/.config/coc なし
~/.cache/coc  なし
```

既存の `~/.vimrc` がある場合は退避します。

```sh
backup_ts="$(date +%Y%m%d-%H%M%S)"
test -f "$HOME/.vimrc" && cp "$HOME/.vimrc" "$HOME/.vimrc.backup.$backup_ts"
```

このリポジトリの `coc-settings.json` は、導入時に `~/.vim/coc-settings.json` として配置します。

```sh
mkdir -p "$HOME/.vim"
test -f "$HOME/.vim/coc-settings.json" && cp "$HOME/.vim/coc-settings.json" "$HOME/.vim/coc-settings.json.backup.$backup_ts"
cp coc-settings.json "$HOME/.vim/coc-settings.json"
```

`~/.config/coc` と `~/.cache/coc` は、導入前に存在しないことを確認しておきます。既に存在する場合は、この構成だけの所有物ではない可能性があるため、削除や上書きは慎重に判断します。

導入後に確認する項目:

```vim
:scriptnames
:CocInfo
:CocList extensions
```

操作確認:

```txt
gd          定義ジャンプ
gr          参照
K           hover
<Space>ca   code action
<Space>cr   rename
<Space>xx   diagnostics
```

## update

plugin 本体:

```sh
git -C "$HOME/.vim/pack/vendor/start/coc.nvim" pull --ff-only
```

coc extensions:

```vim
:CocUpdate
```

coc 設定をこのリポジトリから再反映する場合:

```sh
cp coc-settings.json "$HOME/.vim/coc-settings.json"
```

direct LSP はこの Vim 設定ではなく、対象プロジェクトまたは toolchain 側で更新します。

```sh
npm update @tailwindcss/language-server @astrojs/language-server intelephense
rustup update
rustup component add rust-analyzer rust-src
```

Node.js / npm は他の開発環境と共有するため、この Vim 設定の update 手順には含めません。

## uninstall

plugin 本体:

```sh
rm -rf "$HOME/.vim/pack/vendor/start/coc.nvim"
```

coc 設定・cache:

```sh
rm -f "$HOME/.vim/coc-settings.json"
```

Vim state:

```sh
rm -rf "$HOME/.vim/state"
rm -rf "$HOME/.vim/state-minimal"
```

state はこの Vim 設定だけで作られたことが明確な場合だけ削除します。

`~/.config/coc` と `~/.cache/coc` は、導入前に存在せず、この構成で作られたことが明確な場合だけ削除します。

```sh
rm -rf "$HOME/.config/coc"
rm -rf "$HOME/.cache/coc"
```

削除しないもの:

```txt
~/.npm
Node.js
npm
```

## 参照

- coc.nvim: https://github.com/neoclide/coc.nvim
