# 前提要件

この Vim 設定を使うために必要なものと、必要に応じて追加するとよい CLI ツールです。

## 必須

- macOS
- Vim 9.1 以上を推奨

現時点の `vimrc` は、追加ダウンロードなしで起動できる構成です。

## 任意

- `git`: Git 管理下の検索や状態確認で使います
- `ripgrep` (`rg`): 高速な全文検索で使います
- `fzf`: VSCode の Quick Open に近いファイル検索を追加したい場合に使います
- `glow`: Markdown preview を追加したい場合に使います
- `Node.js` / `npm`: プロジェクト側の formatter / linter を使う場合に必要です
- `rustup` / `cargo`: Rust 開発をする場合に使います

`rg`、`fzf`、`glow` の入れ方・更新・削除は [CLI ツール管理](cli-tools.md) にまとめています。

補足:

- まずは必須ダウンロードなしで進めます
- `rg` があれば `<Space>fw` の検索が速くなります
- LSP / 補完 / diagnostics が必要な場合は `coc.nvim` 構成を追加します

## プロジェクト側に入れておくとよい npm パッケージ

formatter、linter、プロジェクト側 language server を使って Astro / TypeScript / Prettier / ESLint / Tailwind CSS / SCSS / PHP を扱う場合は、対象プロジェクト側に以下が入っていることを確認します。

```sh
npm ls typescript prettier eslint tailwindcss @tailwindcss/language-server @astrojs/language-server intelephense
```

不足している場合の例:

```sh
npm install -D typescript prettier eslint tailwindcss @tailwindcss/language-server
npm install -D @astrojs/language-server
npm install -D intelephense
npm install -D prettier-plugin-astro prettier-plugin-tailwindcss
npm install -D sass
```

保存時整形は `prettier.requireConfig: true` にしているため、Prettier 対象 filetype では対象プロジェクト側に `.prettierrc`、`prettier.config.*`、または `package.json` の `prettier` 設定が必要です。

Rust を使う場合は、`rustup` 側で `rust-analyzer` と `rust-src` を入れます。

```sh
rustup component add rust-analyzer rust-src
```

補足:

- React Router v8 / v7 の `app/routes.ts`、`react-router.config.ts`、各 route module は通常の `.ts` / `.tsx` として扱えます
- Remix v3 beta は React Router / Remix v2 系とは別系統の prerelease です。この設定では専用補完は保証せず、TypeScript / JavaScript / CSS / Prettier / ESLint の基本編集支援として扱います
- Tailwind CSS は v4 前提です。補完は coc extension ではなく、プロジェクト側の `@tailwindcss/language-server` を `npx --no-install` 経由で使います
- Tailwind CSS language server がプロジェクトを検出できるように、対象プロジェクトには `@import "tailwindcss";` などを含む CSS entrypoint が必要です
- PHP は coc extension ではなく、プロジェクト側の `intelephense` を `npx --no-install` 経由で使います
- Astro は coc extension ではなく、プロジェクト側の `@astrojs/language-server` を `npx --no-install` 経由で使います
- Tailwind / PHP / Astro の LSP 設定は global な `~/.vim/coc-settings.json` ではなく、対象プロジェクトの `.vim/coc-settings.json` に置きます。テンプレートは `examples/` 配下にあります
- Rust は coc extension ではなく、`rustup` component の `rust-analyzer` を直接使います
