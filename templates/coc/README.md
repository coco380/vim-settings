# project-local Coc templates

`.vim/coc-settings.json` のコピー元です。

- `tailwind.json`: Tailwind CSS language server と class 補完設定
- `astro.json`: Astro language server
- `php.json`: Intelephense
- `full.json`: Tailwind + Astro + PHP をまとめた完成形

前提:

- TypeScript / ESLint / Prettier は共通 `coc-settings.json` 側で扱います
- Rust は共通 direct LSP 側で扱います
- Stylelint は Vim 連携しません

使い方:

1. 対象プロジェクトで `:CocLocalConfig` を実行する
2. 作られた `.vim/coc-settings.json` に必要な template を反映する
3. 複数 template を使う場合は、トップレベル key を 1 つの JSON にまとめる

`full.json` はそのままコピー用です。`tailwind.json`、`astro.json`、`php.json` は部分 template です。

`tailwind.json` と `full.json` の `css.customData` は、対象プロジェクトに `.vscode/tailwind.json` がある前提です。なければこの key は外します。
