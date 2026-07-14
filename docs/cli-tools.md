# CLI ツール管理

`rg`、`fzf`、`glow` は必須ではありません。入れる場合は、環境を汚しにくいように単体 binary を `~/.local/bin` に置く方針にします。

このリポジトリの標準方針:

- Homebrew は使わない
- Vim plugin は使わない
- installer に shell 設定を自動変更させない
- binary は `~/.local/bin` に置く
- 削除は `rm` で終わる形にする

## 対象ツール

| ツール | 用途 | 優先度 |
|---|---|---|
| `rg` | 高速な全文検索 | 高 |
| `fzf` | fuzzy finder | 中 |
| `glow` | Markdown preview | 必要な場合だけ |

## 事前準備

`~/.local/bin` が `PATH` に入っているか確認します。

```sh
echo "$PATH" | tr ':' '\n' | grep "$HOME/.local/bin"
```

入っていない場合は、`~/.zshrc` に明示的に追加します。

```sh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
source "$HOME/.zshrc"
```

配置先を作ります。

```sh
mkdir -p "$HOME/.local/bin"
```

各ツールは Release から対象 architecture の archive URL を選び、作業用ディレクトリで取得します。

```sh
workdir="$(mktemp -d)"
cd "$workdir"
curl -LO "<release-archive-url>"
shasum -a 256 "<downloaded-archive>"
```

公式 release page に checksum がある場合は、表示された hash と照合してから展開します。

```sh
tar -xzf "<downloaded-archive>"
```

展開後、対象 binary だけを `~/.local/bin` に配置します。

```sh
cp path/to/binary "$HOME/.local/bin/<tool>"
chmod +x "$HOME/.local/bin/<tool>"
```

作業用ディレクトリは不要になったら削除できます。

```sh
rm -rf "$workdir"
```

## install

### `rg`

GitHub Releases から macOS 用の `ripgrep` archive を取得し、中の `rg` binary だけを配置します。

- Releases: https://github.com/BurntSushi/ripgrep/releases
- Apple Silicon: `aarch64-apple-darwin` を含む archive
- Intel Mac: `x86_64-apple-darwin` を含む archive

配置後に確認します。

```sh
rg --version
```

### `fzf`

GitHub Releases から macOS 用の `fzf` archive を取得し、中の `fzf` binary だけを配置します。

- Releases: https://github.com/junegunn/fzf/releases
- Apple Silicon: `darwin_arm64` を含む archive
- Intel Mac: `darwin_amd64` を含む archive

配置後に確認します。

```sh
fzf --version
```

shell integration は最初は入れません。必要になった場合だけ、後から明示的に追加します。

### `glow`

GitHub Releases から macOS 用の `glow` archive を取得し、中の `glow` binary だけを配置します。

- Releases: https://github.com/charmbracelet/glow/releases
- Apple Silicon: `Darwin_arm64` を含む archive
- Intel Mac: `Darwin_x86_64` を含む archive

配置後に確認します。

```sh
glow --version
```

## fzf shell integration

`fzf` 本体だけでも `fzf` コマンドは使えます。shell integration を入れると、zsh で次の操作が使えるようになります。

| キー | 何をするか |
|---|---|
| `Ctrl-R` | コマンド履歴を fuzzy search |
| `Ctrl-T` | ファイル / ディレクトリを選んでコマンドラインに挿入 |
| `Alt-C` | ディレクトリを選んで `cd` |

入れる場合は、`~/.zshrc` に自分で分かる形で追記します。

```sh
# fzf shell integration
source <(fzf --zsh)
```

削除する場合は、この2行を `~/.zshrc` から消して、shell を開き直します。

## update

単体 binary 管理なので、更新は入れ直しです。

1. Releases から新しい archive を取得する
2. 新しい binary で `~/.local/bin/<tool>` を上書きする
3. `chmod +x` を確認する
4. version を確認する

```sh
chmod +x "$HOME/.local/bin/rg" "$HOME/.local/bin/fzf" "$HOME/.local/bin/glow"
rg --version
fzf --version
glow --version
```

## uninstall

binary を消します。

```sh
rm -f "$HOME/.local/bin/rg"
rm -f "$HOME/.local/bin/fzf"
rm -f "$HOME/.local/bin/glow"
```

fzf shell integration を追加していた場合は、`~/.zshrc` から以下を削除します。

```sh
# fzf shell integration
source <(fzf --zsh)
```

`glow` の設定ファイルを作成していた場合だけ、必要に応じて削除します。作成していなければ不要です。
