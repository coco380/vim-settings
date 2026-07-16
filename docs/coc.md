# Coc 構成

`coc.nvim` は任意です。標準構成は Vim 本体のみで動作し、補完、diagnostics、rename、code action が必要な場合だけ Coc を追加します。

## 前提

- Vim 9.1 以降
- Node.js 20.19 以降、npm、Git
- plugin 本体: `~/.vim/pack/vendor/start/coc.nvim`
- 共通設定: `~/.vim/coc-settings.json`

## 導入

```sh
mkdir -p ~/.vim/pack/vendor/start ~/.vim
git clone --depth 1 --branch release https://github.com/neoclide/coc.nvim.git ~/.vim/pack/vendor/start/coc.nvim
cp /path/to/vim-settings/coc-settings.json ~/.vim/coc-settings.json
```

Vim から必要な拡張を導入します。

```vim
:CocInstall coc-tsserver coc-eslint coc-prettier coc-json coc-yaml coc-css coc-html
:CocInfo
```

設定済みのキーは `gd`、`gy`、`gi`、`gr`、`K`、`<Space>cr`、`<Space>ca`、`[d`、`]d`、`<Space>cf` です。Coc 未導入時は定義移動などの標準動作を妨げません。

## プロジェクト固有の language server

プロジェクトで `:CocLocalConfig` を実行し、生成された `.vim/coc-settings.json` へ [template](../templates/coc/README.md) を反映します。複数 template を使う場合はトップレベル key を一つの JSON にまとめます。

| 用途 | プロジェクト側の準備 |
|---|---|
| Tailwind CSS | `npm install -D @tailwindcss/language-server`。必要なら `tailwind.json` を用意 |
| Astro | `npm install -D @astrojs/language-server typescript`。`astro.json` の `typescript.tsdk` をプロジェクト内の絶対パスへ置換 |
| PHP | `npm install -D intelephense` |
| Rust | `rustup component add rust-analyzer rust-src` |
| Prettier | プロジェクトの Prettier 設定を用意 |

Stylelint は Vim 連携の対象外です。CI、editorconfig、または別の実行経路で扱います。

`tailwind.json` と `full.json` の `css.customData` は、プロジェクトに `.vscode/tailwind.json` がある場合だけ使用します。ない場合はその key を外してください。

## 更新と削除

更新:

```sh
git -C ~/.vim/pack/vendor/start/coc.nvim pull --ff-only
```

Vim で `:CocUpdate` を実行し、プロジェクト側の language server は npm または rustup で更新します。

削除:

```sh
rm -rf ~/.vim/pack/vendor/start/coc.nvim ~/.config/coc ~/.cache/coc
rm -f ~/.vim/coc-settings.json
```

公式情報は [coc.nvim](https://github.com/neoclide/coc.nvim) を参照してください。
