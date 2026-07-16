#!/bin/sh

set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
tmp=$(mktemp -d "${TMPDIR:-/tmp}/vim-settings-test.XXXXXX")
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

repo="$tmp/project"
mkdir -p "$repo/src"
git -C "$repo" init -q
git -C "$repo" config user.email test@example.com
git -C "$repo" config user.name "Vim Settings Test"
printf 'first\n' > "$repo/src/app.txt"
printf 'committed\n' > "$repo/src/staged.txt"
printf 'l1\nl2\nl3\nl4\nl5\n' > "$repo/src/multi.txt"
printf 'rename\n' > "$repo/old name.txt"
git -C "$repo" add .
git -C "$repo" commit -qm initial

printf 'second\n' >> "$repo/src/app.txt"
printf 'staged\n' >> "$repo/src/staged.txt"
printf 'L1\nl2\nl3\nL4\nl5\n' > "$repo/src/multi.txt"
git -C "$repo" add src/staged.txt
git -C "$repo" mv "old name.txt" "new name.txt"
printf 'untracked\n' > "$repo/untracked file.txt"
printf 'nihongo\n' > "$repo/src/日本語メモ.txt"
ln -s missing-target "$repo/broken link"

plain="$tmp/plain"
mkdir -p "$plain"
printf 'plain\n' > "$plain/note.txt"

cat > "$tmp/record-reveal.sh" <<'EOF'
#!/bin/sh
printf '%s' "$1" > "${VIM_SETTINGS_TEST_TMP}/reveal-out.txt"
EOF
chmod +x "$tmp/record-reveal.sh"

# </dev/null: an inherited pipe stdin reaches :grep's rg, which would
# then read stdin forever instead of searching the work tree.
if ! VIM_SETTINGS_ROOT="$root" VIM_SETTINGS_TEST_REPO="$repo" VIM_SETTINGS_TEST_TMP="$tmp" \
  vim -Nu "$root/vimrc" -i NONE -n -es -V1"$tmp/full-vim.log" \
  -S "$root/tests/test-full.vim" </dev/null >/dev/null 2>&1; then
  test ! -f "$tmp/full-errors.log" || cat "$tmp/full-errors.log"
  cat "$tmp/full-vim.log"
  exit 1
fi

if ! VIM_SETTINGS_ROOT="$root" VIM_SETTINGS_TEST_TMP="$tmp" \
  vim --noplugin -Nu "$root/vimrc.minimal" -i NONE -n -es -V1"$tmp/minimal-vim.log" \
  -S "$root/tests/test-minimal.vim" </dev/null >/dev/null 2>&1; then
  test ! -f "$tmp/minimal-errors.log" || cat "$tmp/minimal-errors.log"
  cat "$tmp/minimal-vim.log"
  exit 1
fi

printf 'Vim settings tests passed.\n'
