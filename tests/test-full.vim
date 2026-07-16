set nomore

let s:root = $VIM_SETTINGS_ROOT
let s:repo = $VIM_SETTINGS_TEST_REPO
let s:tmp = $VIM_SETTINGS_TEST_TMP

function! s:SidebarSlotWin() abort
  for l:w in range(1, winnr('$'))
    if getwinvar(l:w, 'vscode_sidebar_slot', 0)
      return l:w
    endif
  endfor
  return 0
endfunction

call assert_equal(1, &autoread)
call assert_equal(1, &confirm)
call assert_equal(0, &equalalways)
call assert_match('node_modules', &wildignore)
call assert_match('ConfigureProjectFind', maparg('<Space>ff', 'n'))
call assert_match(':buffer', maparg('<Space>fb', 'n'))
call assert_match(':RecentFiles', maparg('<Space>fr', 'n'))
call assert_equal(':cnext<CR>', maparg(']q', 'n'))
call assert_equal(':lnext<CR>', maparg(']l', 'n'))
call assert_equal('<gv', maparg('<', 'x'))
call assert_equal('>gv', maparg('>', 'x'))
if has('patch-8.2.4325')
  call assert_match('fuzzy', &wildoptions)
endif
if exists('+findfunc')
  call assert_match('QuickOpenFindFunc', &findfunc)
endif
if !empty(globpath(&packpath, 'pack/dist/opt/cfilter'))
  call assert_equal(2, exists(':Cfilter'), 'Missing command: Cfilter')
endif
for s:command in [
      \ 'GitGrep',
      \ 'GitReplace',
      \ 'GitStatus',
      \ 'GitBlame',
      \ 'GitDiff',
      \ 'GitDiffSideBySide',
      \ 'RecentFiles',
      \ 'RevealInFinder',
      \ 'RevealInTree',
      \ 'CopyRelativePath',
      \ 'CopyAbsolutePath',
      \ 'CopyPathWithLine',
      \ ]
  call assert_equal(2, exists(':' . s:command), 'Missing command: ' . s:command)
endfor

for s:file in [s:root . '/coc-settings.json'] + glob(s:root . '/templates/coc/*.json', 0, 1)
  try
    call json_decode(join(readfile(s:file), "\n"))
  catch
    call assert_report('Invalid JSON: ' . s:file . ': ' . v:exception)
  endtry
endfor

execute 'cd ' . fnameescape(s:tmp)
execute 'edit ' . fnameescape(s:repo . '/src/app.txt')

call feedkeys(" ffapp.txt\<CR>", 'xt')
call assert_equal(resolve(s:repo . '/src/app.txt'), resolve(expand('%:p')))
call assert_equal(resolve(s:repo), resolve(getcwd()))
call assert_equal('.,**', &l:path)

if exists('+findfunc')
  " Fuzzy Quick Open: "srcapp" only fuzzy-matches src/app.txt.
  execute 'edit ' . fnameescape(s:repo . '/src/staged.txt')
  call feedkeys(" ffsrcapp\<CR>", 'xt')
  call assert_equal(resolve(s:repo . '/src/app.txt'), resolve(expand('%:p')))

  " Non-ASCII paths survive git ls-files (core.quotepath handling).
  call feedkeys(" ff日本語\<CR>", 'xt')
  call assert_equal(resolve(s:repo . '/src/日本語メモ.txt'), resolve(expand('%:p')))

  " Outside a Git work tree, Quick Open falls back to glob().
  execute 'cd ' . fnameescape(s:tmp . '/plain')
  execute 'edit ' . fnameescape(s:tmp . '/plain/note.txt')
  call feedkeys(" ffnote\<CR>", 'xt')
  call assert_equal(resolve(s:tmp . '/plain/note.txt'), resolve(expand('%:p')))
endif

" Recent files: with no argument, RecentFiles opens the previous buffer.
execute 'edit ' . fnameescape(s:repo . '/src/app.txt')
execute 'edit ' . fnameescape(s:repo . '/src/staged.txt')
RecentFiles
call assert_equal(resolve(s:repo . '/src/app.txt'), resolve(expand('%:p')))

call feedkeys(" fwfirst\<CR>", 'xt')
let s:project_qf = getqflist()
call assert_equal(1, len(s:project_qf))
call assert_equal(resolve(s:repo . '/src/app.txt'), fnamemodify(resolve(bufname(s:project_qf[0].bufnr)), ':p'))
" :grep opens its results in the sidebar slot (focus stays on the first
" match in the editor, matching :grep's jump behavior).
let s:fw_slot = s:SidebarSlotWin()
call assert_true(s:fw_slot > 0, 'grep did not open the sidebar slot')
call assert_equal('qf', getwinvar(s:fw_slot, '&filetype'))
call assert_equal(32, winwidth(s:fw_slot))
call assert_equal(resolve(s:repo . '/src/app.txt'), resolve(expand('%:p')))
cclose
execute 'edit ' . fnameescape(s:repo . '/src/app.txt')

CopyRelativePath
call assert_equal('src/app.txt', getreg('"'))
CopyAbsolutePath
call assert_equal(resolve(s:repo . '/src/app.txt'), resolve(getreg('"')))
call cursor(2, 1)
CopyPathWithLine
call assert_equal(resolve(s:repo . '/src/app.txt') . ':2', getreg('"'))

GitGrep first
let s:qf = getqflist()
call assert_equal(1, len(s:qf))
call assert_equal(resolve(s:repo . '/src/app.txt'), fnamemodify(resolve(bufname(s:qf[0].bufnr)), ':p'))
" With no tree open, the quickfix list opens as a standalone sidebar
" column on the left, at the tree width.
let s:panel_height = max([8, float2nr(&lines * 0.3)])
call assert_equal('qf', &filetype)
call assert_equal(32, winwidth(0))
call assert_equal(1, w:vscode_sidebar_slot)
call assert_equal(1, &l:winfixheight)
call assert_equal(1, &l:winfixwidth)
cclose

execute 'edit ' . fnameescape(s:repo . '/src/app.txt')
GitBlame
call assert_equal(2, line('$'))
call assert_match('first', getline(1))
close

execute 'edit ' . fnameescape(s:repo . '/src/app.txt')
GitStatus
call assert_match('^## ', getline(1))
call assert_true(index(getline(1, '$'), ' M src/app.txt') >= 0)
call assert_true(index(getline(1, '$'), 'R  old name.txt -> new name.txt') >= 0)
call assert_true(index(getline(1, '$'), '?? untracked file.txt') >= 0)

call cursor(index(getline(1, '$'), '?? untracked file.txt') + 1, 1)
call feedkeys('a', 'xt')
call assert_match('untracked file.txt', system('git -C ' . shellescape(s:repo) . ' diff --cached --name-only'))
call cursor(index(getline(1, '$'), 'A  untracked file.txt') + 1, 1)
call feedkeys('r', 'xt')
call assert_notmatch('untracked file.txt', system('git -C ' . shellescape(s:repo) . ' diff --cached --name-only'))
close

execute 'edit ' . fnameescape(s:repo . '/src/app.txt')
GitDiff
call assert_match('^diff --git a/src/app.txt b/src/app.txt$', getline(1))
close

execute 'edit ' . fnameescape(s:repo . '/src/staged.txt')
GitDiff
call assert_match('^diff --git a/src/staged.txt b/src/staged.txt$', getline(1))
close

execute 'edit ' . fnameescape(s:repo . '/src/app.txt')
" Custom fold settings must survive a diff session.
setlocal foldenable foldcolumn=4 foldmethod=marker
GitDiffSideBySide
call assert_equal(2, winnr('$'))
call assert_equal(1, &diff)
" The whole file is visible (no diff folding), the first hunk has focus
" (line 2 is the only change in app.txt), and both panes are bound
" vertically and horizontally (diffthis adds "hor" itself).
call assert_equal(2, line('.'))
call assert_match('hor', &scrollopt)
for s:w in range(1, winnr('$'))
  call assert_equal(0, getwinvar(s:w, '&foldenable'))
  call assert_equal(1, getwinvar(s:w, '&scrollbind'))
  call assert_equal(1, getwinvar(s:w, '&cursorbind'))
endfor
" Close the base side so the surviving file window can be checked for
" restored fold settings.
wincmd h
close
sleep 10m
call assert_equal(1, winnr('$'))
call assert_equal(resolve(s:repo . '/src/app.txt'), resolve(expand('%:p')))
call assert_equal(1, &l:foldenable)
call assert_equal(4, &l:foldcolumn)
call assert_equal('marker', &l:foldmethod)
setlocal foldcolumn=0 foldmethod=manual

" When line 1 itself is changed and another hunk follows, the cursor
" must land on the first hunk, not overshoot to the second.
execute 'edit ' . fnameescape(s:repo . '/src/multi.txt')
GitDiffSideBySide
call assert_equal(1, line('.'))
close
sleep 10m
call assert_equal(1, winnr('$'))

" A file without content changes (the rename) opens quietly at line 1.
execute 'edit ' . fnameescape(s:repo . '/new name.txt')
GitDiffSideBySide
call assert_equal(2, winnr('$'))
call assert_equal(1, line('.'))
close
sleep 10m
call assert_equal(1, winnr('$'))

" The same diff opens from the Git status panel via d; the status view
" stays visible like VSCode's Source Control sidebar.
execute 'edit ' . fnameescape(s:repo . '/src/app.txt')
GitStatus
call assert_equal(1, w:vscode_sidebar_slot)
call cursor(index(getline(1, '$'), ' M src/app.txt') + 1, 1)
call feedkeys('d', 'xt')
call assert_equal(1, &diff)
call assert_equal(3, winnr('$'))
" Dismiss the diff from the base side: the editor and the status view
" both survive.
wincmd h
close
sleep 10m
call assert_equal(2, winnr('$'))
call assert_match('Git Status', bufname(winbufnr(s:SidebarSlotWin())))
call win_execute(win_getid(s:SidebarSlotWin()), 'close')
call assert_equal(1, winnr('$'))

" The bundled comment package resolves its opfunc from expand('<stack>'),
" which misparses when triggered from a sourced script, so only the
" mapping wiring is asserted here.
if !empty(globpath(&packpath, 'pack/dist/opt/comment'))
  call assert_notequal('', maparg('gcc', 'n'), 'comment package not loaded')
  call assert_match('gcc', maparg('<Space>/', 'n'))
  call assert_match('gc', maparg('<Space>/', 'x'))
endif

" Reveal in Finder records its target through a stub command.
let g:finder_reveal_command = ['sh', s:tmp . '/record-reveal.sh']

function! s:RevealedPath() abort
  let s:out = s:tmp . '/reveal-out.txt'
  if !filereadable(s:out)
    return ''
  endif
  let s:lines = readfile(s:out)
  call delete(s:out)
  return empty(s:lines) ? '' : s:lines[0]
endfunction

execute 'edit ' . fnameescape(s:repo . '/src/app.txt')
RevealInFinder
call assert_equal(resolve(s:repo . '/src/app.txt'), resolve(s:RevealedPath()))

" A broken symlink is still selectable in Finder. Compare without
" resolve() so the link itself, not its target, is asserted.
execute 'edit ' . fnameescape(s:repo . '/broken link')
RevealInFinder
call assert_match('/broken link$', s:RevealedPath())
bwipeout!

" An invalid reveal command must warn, not throw or record anything.
let s:save_reveal = g:finder_reveal_command
let g:finder_reveal_command = 'xdg-open'
execute 'edit ' . fnameescape(s:repo . '/src/app.txt')
try
  RevealInFinder
catch
  call assert_report('RevealInFinder threw on invalid command: ' . v:exception)
endtry
call assert_equal('', s:RevealedPath())
let g:finder_reveal_command = s:save_reveal

execute 'cd ' . fnameescape(s:repo)
call feedkeys(" e", 'xt')
call assert_equal(2, winnr('$'))
call assert_equal('netrw', &filetype)
call assert_equal(32, winwidth(0))
call assert_equal(1, &l:winfixwidth)

" Reveal from the tree: top-level file containing a space.
if search('untracked file\.txt', 'w') > 0
  RevealInFinder
  call assert_equal(resolve(s:repo . '/untracked file.txt'), resolve(s:RevealedPath()))
else
  call assert_report('untracked file.txt not visible in netrw tree')
endif

" Reveal a nested non-ASCII file. Interactively this expands the tree
" node; under -es netrw may fall back to browsing into the directory.
" Both paths must resolve to the same absolute file.
if search('src/', 'w') > 0
  call feedkeys("\<CR>", 'xt')
  if search('日本語メモ\.txt', 'w') > 0
    RevealInFinder
    call assert_equal(resolve(s:repo . '/src/日本語メモ.txt'), resolve(s:RevealedPath()))
  else
    call assert_report('日本語メモ.txt not visible after expanding src/')
  endif
else
  call assert_report('src/ not visible in netrw tree')
endif

" Pressing the key again in the focused tree closes it.
call feedkeys(" e", 'xt')
call assert_equal(1, winnr('$'))
call assert_notequal('netrw', &filetype)

call feedkeys(" ot", 'xt')
call assert_equal('terminal', &buftype)
call assert_equal(s:panel_height, winheight(0))
call assert_equal(1, &l:winfixheight)
let s:term_bufnr = bufnr('%')
" Pressing the key again in the focused terminal closes the window
" but keeps the terminal buffer for reuse. Leave terminal-job mode first.
call feedkeys("\<C-\>\<C-n> ot", 'xt')
call assert_equal(1, winnr('$'))
call assert_true(bufexists(s:term_bufnr))
call feedkeys(" ot", 'xt')
call assert_equal(s:term_bufnr, bufnr('%'))
execute 'bwipeout! ' . s:term_bufnr

" The sidebar keeps its width while the panel opens and closes.
call feedkeys(" e", 'xt')
call assert_equal('netrw', &filetype)
let s:tree_winid = win_getid()
wincmd p
call feedkeys(" ot", 'xt')
call assert_equal('terminal', &buftype)
let s:term_bufnr = bufnr('%')
call assert_equal(32, winwidth(win_id2win(s:tree_winid)))
call feedkeys("\<C-\>\<C-n> ot", 'xt')
call assert_equal(32, winwidth(win_id2win(s:tree_winid)))
execute win_id2win(s:tree_winid) . 'wincmd w'
call feedkeys(" e", 'xt')
call assert_equal(1, winnr('$'))
execute 'bwipeout! ' . s:term_bufnr

" Deleting a buffer keeps its window and shows the previous file
" (VSCode-like tab close), instead of collapsing into the sidebar.
execute 'edit ' . fnameescape(s:repo . '/src/app.txt')
call feedkeys(" e", 'xt')
wincmd p
execute 'edit ' . fnameescape(s:repo . '/src/staged.txt')
call feedkeys(" bd", 'xt')
call assert_equal(2, winnr('$'))
call assert_equal(resolve(s:repo . '/src/app.txt'), resolve(expand('%:p')))
call assert_notequal('netrw', &filetype)
call assert_equal(0, buflisted(bufnr(fnameescape(s:repo . '/src/staged.txt'))))
for s:w in range(1, winnr('$'))
  if getwinvar(s:w, '&filetype') ==# 'netrw'
    execute s:w . 'wincmd w'
    call feedkeys(" e", 'xt')
    break
  endif
endfor
call assert_equal(1, winnr('$'))

" With the same buffer split into two windows, both windows survive.
execute 'edit ' . fnameescape(s:repo . '/src/app.txt')
execute 'edit ' . fnameescape(s:repo . '/src/staged.txt')
split
call assert_equal(2, winnr('$'))
call feedkeys(" bd", 'xt')
call assert_equal(2, winnr('$'))
call assert_equal(0, buflisted(bufnr(fnameescape(s:repo . '/src/staged.txt'))))
only

" When the alternate is unlisted, the previous listed normal buffer is
" chosen instead.
execute 'edit ' . fnameescape(s:repo . '/src/multi.txt')
execute 'edit ' . fnameescape(s:repo . '/src/app.txt')
execute 'edit ' . fnameescape(s:repo . '/src/staged.txt')
bdelete #
call feedkeys(" bd", 'xt')
call assert_equal(1, winnr('$'))
call assert_equal('', &buftype)
call assert_true(buflisted(bufnr('%')))
call assert_notequal('staged.txt', fnamemodify(bufname('%'), ':t'))

" In panel windows the mapping closes just the window: the terminal
" buffer survives for reuse and the quickfix window simply closes.
call feedkeys(" ot", 'xt')
call assert_equal('terminal', &buftype)
let s:term_bufnr = bufnr('%')
call feedkeys("\<C-\>\<C-n> bd", 'xt')
call assert_equal(1, winnr('$'))
call assert_true(bufexists(s:term_bufnr))
execute 'bwipeout! ' . s:term_bufnr

call feedkeys(" xq", 'xt')
call assert_equal('qf', &filetype)
call feedkeys(" bd", 'xt')
call assert_equal(1, winnr('$'))
call assert_notequal('qf', &filetype)

" Closing one side of the diff pair keeps the editor window when other
" windows (the sidebar) exist; only the diff view is dismissed.
execute 'edit ' . fnameescape(s:repo . '/src/app.txt')
call feedkeys(" e", 'xt')
wincmd p
GitDiffSideBySide
call assert_equal(3, winnr('$'))
wincmd h
close
sleep 10m
call assert_equal(2, winnr('$'))
call assert_equal(0, len(filter(range(1, winnr('$')), 'getwinvar(v:val, "&diff")')))
let s:app_visible = 0
for s:w in range(1, winnr('$'))
  if fnamemodify(resolve(bufname(winbufnr(s:w))), ':p') ==# resolve(s:repo . '/src/app.txt')
    let s:app_visible = 1
  endif
endfor
call assert_equal(1, s:app_visible)
for s:w in range(1, winnr('$'))
  if getwinvar(s:w, '&filetype') ==# 'netrw'
    execute s:w . 'wincmd w'
    call feedkeys(" e", 'xt')
    break
  endif
endfor
call assert_equal(1, winnr('$'))

" Repeated GitStatus reuses its panel instead of stacking windows.
execute 'edit ' . fnameescape(s:repo . '/src/app.txt')
GitStatus
let s:wins_after_status = winnr('$')
wincmd p
GitStatus
call assert_equal(s:wins_after_status, winnr('$'))
call assert_match('Git Status', bufname('%'))
close

" A moved quickfix window is re-anchored into the sidebar slot.
call feedkeys(" xq", 'xt')
call assert_equal('qf', &filetype)
call assert_equal(32, winwidth(0))
wincmd K
call feedkeys(" xq", 'xt')
call assert_equal('qf', &filetype)
call assert_equal(32, winwidth(0))
call assert_equal(1, w:vscode_sidebar_slot)
cclose

" Opening an empty location list warns instead of raising E776.
let v:errmsg = ''
call feedkeys(" xl", 'xt')
call assert_notmatch('E776', v:errmsg)

" Sidebar slot: Git status and search results share one window below
" the tree, overwriting each other instead of stacking.
execute 'cd ' . fnameescape(s:repo)
execute 'edit ' . fnameescape(s:repo . '/src/app.txt')
call feedkeys(" e", 'xt')
call assert_equal('netrw', &filetype)
let s:tree_height = winheight(0)
GitStatus
call assert_equal(3, winnr('$'))
call assert_equal(1, w:vscode_sidebar_slot)
call assert_equal(32, winwidth(0))
call assert_true(winheight(0) <= s:tree_height / 2 + 1)
GitGrep first
call assert_equal('qf', &filetype)
call assert_equal(1, w:vscode_sidebar_slot)
call assert_equal(32, winwidth(0))
call assert_equal(3, winnr('$'))

" The terminal opens under the editor, not under the sidebar.
call feedkeys(" ot", 'xt')
call assert_equal('terminal', &buftype)
call assert_true(winwidth(0) < &columns)
call assert_equal(4, winnr('$'))
call feedkeys("\<C-\>\<C-n> ot", 'xt')
call assert_equal(3, winnr('$'))

" Toggling the tree closed hides the whole sidebar including the slot.
for s:w in range(1, winnr('$'))
  if getwinvar(s:w, '&filetype') ==# 'netrw'
    execute s:w . 'wincmd w'
    break
  endif
endfor
call feedkeys(" e", 'xt')
call assert_equal(0, s:SidebarSlotWin())
call assert_equal(1, winnr('$'))

" Resize mode: after <C-w>>, bare keys keep resizing until another key
" exits the mode.
vsplit
let s:width_before = winwidth(0)
call feedkeys("\<C-w>>>>\<Esc>", 'xt')
call assert_equal(s:width_before + 6, winwidth(0))
call feedkeys("\<C-w><\<Esc>", 'xt')
call assert_equal(s:width_before + 4, winwidth(0))
split
let s:height_before = winheight(0)
call feedkeys("\<C-w>++\<Esc>", 'xt')
call assert_equal(s:height_before + 2, winheight(0))
only

" A pseudo key (CursorHold) must not end the mode; the > after it still
" resizes.
vsplit
let s:width_before = winwidth(0)
call feedkeys("\<C-w>>\<CursorHold>>\<Esc>", 'xt')
call assert_equal(s:width_before + 4, winwidth(0))

" Exiting keys replay in typed order: the d of a quick dw must run
" before the w.
enew
call setline(1, 'one two')
call feedkeys("\<C-w>>dw", 'xt')
call assert_equal('two', getline(1))
bwipeout!
only

" A manually widened slot is still reused instead of stacking.
execute 'edit ' . fnameescape(s:repo . '/src/app.txt')
GitStatus
vertical resize 40
wincmd p
GitStatus
call assert_equal(2, winnr('$'))
call assert_equal(40, winwidth(0))
close

" GitStatus <CR> with no editor window creates the editor column on the
" right instead of opening inside the sidebar slot.
execute 'edit ' . fnameescape(s:repo . '/src/app.txt')
GitStatus
wincmd p
close
call assert_equal(1, winnr('$'))
call cursor(index(getline(1, '$'), ' M src/app.txt') + 1, 1)
call feedkeys("\<CR>", 'xt')
call assert_equal(2, winnr('$'))
call assert_equal(resolve(s:repo . '/src/app.txt'), resolve(expand('%:p')))
call assert_equal('', &buftype)
call win_execute(win_getid(s:SidebarSlotWin()), 'close')
call assert_equal(1, winnr('$'))

if !empty(v:errors)
  call writefile(v:errors, s:tmp . '/full-errors.log')
  cquit 1
endif

qa!
