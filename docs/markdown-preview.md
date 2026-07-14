# Markdown preview

`vimrc` には plugin なしの Markdown preview キーマップを入れています。

## 方針

Markdown preview は `glow` CLI を使います。

- Vim plugin にはしない
- `<Space>om` で開閉する
- Vim の `:terminal` で表示する
- `glow` がない環境では警告を出して終了する

## 現在の使い方

`glow` を導入済みなら、Vim の外で直接使えます。

```sh
glow README.md
glow -p README.md
```

## Vim 内で使う

Markdown ファイルを開いて実行します。

```vim
:MarkdownPreview
```

または:

```txt
<Space>om
```

現在の Markdown ファイルを右 split の terminal buffer で preview します。preview を開いている状態で同じファイルを保存すると再描画します。

この機能は任意です。`glow` が入っていない場合は警告を出して何もしません。
