scriptencoding utf-8

" Repo-local Vim config. Try with:
"   vim -Nu ./vimrc

set nocompatible

" ------------------------------------------------------------
" Leader
" ------------------------------------------------------------
let mapleader = "\<Space>"
let maplocalleader = ","

" ------------------------------------------------------------
" Basic settings
" ------------------------------------------------------------
filetype plugin indent on
syntax enable

set encoding=utf-8
set fileencoding=utf-8
" Avoid pathological backtracking in Vim's TypeScript/TSX syntax rules.
set regexpengine=2
set number
set relativenumber
set hidden
set nowrap
set cursorline
set signcolumn=yes
set updatetime=300
set timeoutlen=500
set ttimeoutlen=10
set wildmenu
set wildmode=longest:full,full
set wildignorecase
set wildignore+=**/.git/**,**/.vim/**,**/node_modules/**,**/dist/**,**/build/**,**/coverage/**
set ignorecase
set smartcase
set incsearch
set hlsearch
set autoread
set confirm
set splitbelow
set splitright
set switchbuf=useopen,usetab
" VSCode-like layout stability: do not re-equalize all windows on every
" open/close. Fixed panes additionally set winfixwidth / winfixheight.
set noequalalways
set scrolloff=8
set sidescrolloff=8
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smartindent
set autoindent
set completeopt=menuone,noinsert,noselect
set pumheight=12
set laststatus=2
set showtabline=2
set mouse=a
set backspace=indent,eol,start
set list
set listchars=tab:»\ ,trail:·,extends:>,precedes:<,nbsp:+

" "pum" and "fuzzy" (8.2.4463) are unsupported values on older Vim, so set
" them individually and let unsupported ones fail quietly.
if exists('+wildoptions')
  silent! set wildoptions=pum
  silent! set wildoptions+=fuzzy
endif

if exists('+splitkeep')
  set splitkeep=screen
endif

if exists('+jumpoptions')
  set jumpoptions=stack
endif

if exists('+diffopt')
  set diffopt+=vertical
endif

if has('termguicolors')
  set termguicolors
endif

if has('clipboard')
  set clipboard=unnamed
endif

" Keep Vim-generated state inside this repository while testing with -Nu.
let s:repo_root = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:state_dir = s:repo_root . '/.vim/state'
let s:undodir = s:state_dir . '/undo'
let s:backupdir = s:state_dir . '/backup'
let s:swapdir = s:state_dir . '/swap'

for s:dir in [s:undodir, s:backupdir, s:swapdir]
  if !isdirectory(s:dir)
    call mkdir(s:dir, 'p')
  endif
endfor

if exists('&viminfofile') && &viminfofile !=# 'NONE'
  let &viminfofile = s:state_dir . '/viminfo'
endif

let &undodir = s:undodir
let &backupdir = s:backupdir . '//'
let &directory = s:swapdir . '//'
set undofile
set nobackup
set nowritebackup

" ------------------------------------------------------------
" Tokyo Night theme
" ------------------------------------------------------------
set background=dark

let g:tokyonight_style = get(g:, 'tokyonight_style', 'night')
let g:tokyonight_enable_italic = get(g:, 'tokyonight_enable_italic', 1)
let g:tokyonight_disable_italic_comment = get(g:, 'tokyonight_disable_italic_comment', 0)

function! s:ApplyTokyoNightFallback() abort
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
  set background=dark
  let g:colors_name = 'tokyonight-fallback'

  highlight Normal gui=NONE cterm=NONE term=NONE guifg=#c0caf5 guibg=#1a1b26 ctermfg=189 ctermbg=234
  highlight NormalNC gui=NONE cterm=NONE term=NONE guifg=#a9b1d6 guibg=#1a1b26 ctermfg=146 ctermbg=234
  highlight CursorLine gui=NONE cterm=NONE term=NONE guibg=#292e42 ctermbg=236
  highlight LineNr gui=NONE cterm=NONE term=NONE guifg=#3b4261 guibg=#1a1b26 ctermfg=60 ctermbg=234
  highlight CursorLineNr gui=NONE cterm=NONE term=NONE guifg=#bb9af7 guibg=#292e42 ctermfg=141 ctermbg=236
  highlight SignColumn gui=NONE cterm=NONE term=NONE guifg=#3b4261 guibg=#1a1b26 ctermfg=60 ctermbg=234
  highlight VertSplit gui=NONE cterm=NONE term=NONE guifg=#3b4261 guibg=#1a1b26 ctermfg=60 ctermbg=234
  highlight StatusLine gui=NONE cterm=NONE term=NONE guifg=#1a1b26 guibg=#7aa2f7 ctermfg=234 ctermbg=111
  highlight StatusLineNC gui=NONE cterm=NONE term=NONE guifg=#a9b1d6 guibg=#24283b ctermfg=146 ctermbg=237
  highlight Visual gui=NONE cterm=NONE term=NONE guibg=#364a82 ctermbg=24
  highlight Search gui=NONE cterm=NONE term=NONE guifg=#1a1b26 guibg=#e0af68 ctermfg=234 ctermbg=179
  highlight IncSearch gui=NONE cterm=NONE term=NONE guifg=#1a1b26 guibg=#ff9e64 ctermfg=234 ctermbg=215
  highlight Pmenu gui=NONE cterm=NONE term=NONE guifg=#c0caf5 guibg=#24283b ctermfg=189 ctermbg=237
  highlight PmenuSel gui=NONE cterm=NONE term=NONE guifg=#1a1b26 guibg=#7aa2f7 ctermfg=234 ctermbg=111
  highlight Comment gui=NONE cterm=NONE term=NONE guifg=#565f89 ctermfg=60
  highlight Constant gui=NONE cterm=NONE term=NONE guifg=#ff9e64 ctermfg=215
  highlight Identifier gui=NONE cterm=NONE term=NONE guifg=#7dcfff ctermfg=117
  highlight Statement gui=NONE cterm=NONE term=NONE guifg=#bb9af7 ctermfg=141
  highlight PreProc gui=NONE cterm=NONE term=NONE guifg=#7aa2f7 ctermfg=111
  highlight Type gui=NONE cterm=NONE term=NONE guifg=#2ac3de ctermfg=80
  highlight Special gui=NONE cterm=NONE term=NONE guifg=#f7768e ctermfg=204
  highlight Directory gui=NONE cterm=NONE term=NONE guifg=#7aa2f7 ctermfg=111
  highlight MatchParen gui=NONE cterm=NONE term=NONE guifg=#ff9e64 guibg=#3b4261 ctermfg=215 ctermbg=60
  highlight ErrorMsg gui=NONE cterm=NONE term=NONE guifg=#1a1b26 guibg=#f7768e ctermfg=234 ctermbg=204
  highlight WarningMsg gui=NONE cterm=NONE term=NONE guifg=#e0af68 ctermfg=179
  highlight Folded gui=NONE cterm=NONE term=NONE guifg=#7aa2f7 guibg=#24283b ctermfg=111 ctermbg=237
  highlight DiffAdd gui=NONE cterm=NONE term=NONE guifg=#9ece6a guibg=#20303b ctermfg=114 ctermbg=236
  highlight DiffChange gui=NONE cterm=NONE term=NONE guifg=#e0af68 guibg=#2f334d ctermfg=179 ctermbg=237
  highlight DiffDelete gui=NONE cterm=NONE term=NONE guifg=#f7768e guibg=#37222c ctermfg=204 ctermbg=235
  highlight DiffText gui=NONE cterm=NONE term=NONE guifg=#7aa2f7 guibg=#394b70 ctermfg=111 ctermbg=60
  highlight Error gui=NONE cterm=NONE term=NONE guifg=#1a1b26 guibg=#f7768e ctermfg=234 ctermbg=204
  highlight Todo gui=NONE cterm=NONE term=NONE guifg=#1a1b26 guibg=#e0af68 ctermfg=234 ctermbg=179
endfunction

function! s:UseTokyoNightTheme() abort
  let l:loaded = 0

  try
    colorscheme tokyonight
    let l:loaded = 1
  catch
    let l:loaded = 0
  endtry

  if !l:loaded
    call s:ApplyTokyoNightFallback()
  endif
endfunction

call s:UseTokyoNightTheme()

let s:git_statusline_cache = {}

function! s:StatuslineGitRoot(start) abort
  if empty(a:start)
    return ''
  endif

  let l:gitdir = finddir('.git', a:start . ';')
  if !empty(l:gitdir)
    return fnamemodify(substitute(fnamemodify(l:gitdir, ':p'), '[\/]\+$', '', ''), ':h')
  endif

  let l:gitfile = findfile('.git', a:start . ';')
  if !empty(l:gitfile)
    return fnamemodify(l:gitfile, ':p:h')
  endif

  return ''
endfunction

function! s:StatuslineGitBranch() abort
  if !executable('git')
    return ''
  endif

  let l:file = expand('%:p')
  let l:start = empty(l:file) ? getcwd() : fnamemodify(l:file, ':p:h')
  let l:root = s:StatuslineGitRoot(l:start)
  if empty(l:root)
    return ''
  endif

  let l:key = fnamemodify(l:root, ':p')
  let l:now = localtime()
  if has_key(s:git_statusline_cache, l:key)
    let l:cached = s:git_statusline_cache[l:key]
    if get(l:cached, 'expires', 0) > l:now
      return get(l:cached, 'text', '')
    endif
  endif

  let l:prefix = 'git -C ' . shellescape(l:root) . ' '
  let l:branch = system(l:prefix . 'branch --show-current 2>/dev/null')
  let l:branch = substitute(l:branch, '\n\+$', '', '')
  if empty(l:branch)
    let l:branch = system(l:prefix . 'rev-parse --short HEAD 2>/dev/null')
    let l:branch = substitute(l:branch, '\n\+$', '', '')
    if !empty(l:branch)
      let l:branch = 'detached:' . l:branch
    endif
  endif

  let l:text = empty(l:branch) ? '' : ' [' . l:branch . ']'
  let s:git_statusline_cache[l:key] = {'text': l:text, 'expires': l:now + 5}
  return l:text
endfunction

function! s:StatuslineEncoding() abort
  return !empty(&fileencoding) ? &fileencoding : &encoding
endfunction

let &statusline = '%#StatusLine# %f%m%r%{' . expand('<SID>') . 'StatuslineGitBranch()}%=%y %{' . expand('<SID>') . 'StatuslineEncoding()} %l:%c %p%%'

" ------------------------------------------------------------
" Built-in explorer/search fallback
" ------------------------------------------------------------
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_altv = 0
let g:netrw_winsize = -32

let s:netrw_tree_width = 32
let s:terminal_bufnr = -1
let s:scratch_counter = 0
let s:git_diff_pair = {
      \ 'base_winid': -1,
      \ 'file_winid': -1,
      \ 'base_bufnr': -1
      \ }
let s:closing_git_diff_pair = 0
let s:git_diff_close_pending = 0

let s:default_grepprg = &grepprg
let s:default_grepformat = &grepformat

if executable('rg')
  set grepprg=rg\ --vimgrep\ --hidden\ --glob\ '!.git/*'
  set grepformat=%f:%l:%c:%m
endif

" Vim-bundled optional packages. No external dependencies.
" comment: language-aware comment toggle (gcc / gc).
" cfilter: :Cfilter to narrow quickfix results.
silent! packadd comment
silent! packadd cfilter

" ------------------------------------------------------------
" Quick Open (fuzzy :find over project files)
" ------------------------------------------------------------
let s:project_files_cache = {}

function! s:ProjectFilesList(root) abort
  let l:key = fnamemodify(a:root, ':p') . '|' . getcwd()
  let l:now = localtime()
  if has_key(s:project_files_cache, l:key)
    let l:cached = s:project_files_cache[l:key]
    if get(l:cached, 'expires', 0) > l:now
      return copy(get(l:cached, 'files', []))
    endif
  endif

  let l:root_prefix = fnamemodify(a:root, ':p')
  let l:files = []
  if executable('git')
    " core.quotepath=false keeps non-ASCII paths (e.g. Japanese) unquoted.
    let l:files = s:SystemList(['git', '-C', a:root, '-c', 'core.quotepath=false',
          \ 'ls-files', '--cached', '--others', '--exclude-standard'])
    if v:shell_error
      let l:files = []
    endif
  endif

  if !empty(l:files)
    " Paths with control characters stay C-quoted; drop them rather than
    " produce bogus entries. Files deleted from the worktree may remain.
    call filter(l:files, 'v:val !~# ''^"''')
    call map(l:files, 'l:root_prefix . v:val')
  else
    " Outside Git: glob() honors wildignore, so node_modules etc. stay out.
    let l:files = filter(glob(l:root_prefix . '**/*', 0, 1), '!isdirectory(v:val)')
  endif

  let l:limit = get(g:, 'quickopen_file_limit', 20000)
  if len(l:files) > l:limit
    let l:files = l:files[: l:limit - 1]
  endif

  call map(l:files, "fnamemodify(v:val, ':.')")
  let s:project_files_cache[l:key] = {'files': l:files, 'expires': l:now + 5}
  return copy(l:files)
endfunction

function! s:QuickOpenFindFunc(cmdarg, cmdcomplete) abort
  let l:files = s:ProjectFilesList(s:ProjectRoot())
  if empty(a:cmdarg)
    return l:files
  endif
  " 'findfunc' implies Vim 9.1, so matchfuzzy() and its limit are available.
  return matchfuzzy(l:files, a:cmdarg, {'limit': 500})
endfunction

if exists('+findfunc')
  let &findfunc = expand('<SID>') . 'QuickOpenFindFunc'
endif

" ------------------------------------------------------------
" Recent files (VSCode Quick Open MRU)
" ------------------------------------------------------------
function! s:RecentFilesList() abort
  let l:current = expand('%:p')
  let l:files = []
  let l:seen = {}

  " The alternate buffer comes first: 'lastused' has one-second
  " granularity, so it alone cannot order back-to-back switches.
  if bufnr('#') > 0 && buflisted(bufnr('#'))
    let l:alt = fnamemodify(bufname(bufnr('#')), ':p')
    if !empty(bufname(bufnr('#'))) && l:alt !=# l:current && filereadable(l:alt)
      let l:seen[l:alt] = 1
      call add(l:files, l:alt)
    endif
  endif

  " get() guards 'lastused', which is missing before patch 8.1.2225.
  let l:buffers = getbufinfo({'buflisted': 1})
  call sort(l:buffers, {a, b -> get(a, 'lastused', 0) == get(b, 'lastused', 0)
        \ ? 0 : (get(a, 'lastused', 0) < get(b, 'lastused', 0) ? 1 : -1)})
  for l:info in l:buffers
    if empty(l:info.name)
      continue
    endif
    let l:path = fnamemodify(l:info.name, ':p')
    if l:path ==# l:current || has_key(l:seen, l:path) || !filereadable(l:path)
      continue
    endif
    let l:seen[l:path] = 1
    call add(l:files, l:path)
  endfor

  for l:old in v:oldfiles
    let l:path = fnamemodify(l:old, ':p')
    if l:path ==# l:current || has_key(l:seen, l:path) || !filereadable(l:path)
      continue
    endif
    let l:seen[l:path] = 1
    call add(l:files, l:path)
  endfor

  return map(l:files, "fnamemodify(v:val, ':.')")
endfunction

function! s:RecentFilesComplete(arglead, cmdline, cursorpos) abort
  let l:files = s:RecentFilesList()
  if empty(a:arglead)
    return l:files
  endif
  if exists('*matchfuzzy')
    return matchfuzzy(l:files, a:arglead)
  endif
  return filter(l:files, 'stridx(v:val, a:arglead) >= 0')
endfunction

function! s:OpenRecentFile(path) abort
  let l:path = a:path
  if empty(l:path)
    let l:recent = s:RecentFilesList()
    if empty(l:recent)
      echo 'No recent files.'
      return
    endif
    let l:path = l:recent[0]
  endif
  execute 'edit ' . fnameescape(l:path)
endfunction

execute 'command! -nargs=? -complete=customlist,' . expand('<SID>') . 'RecentFilesComplete'
      \ . ' RecentFiles call ' . expand('<SID>') . 'OpenRecentFile(<q-args>)'

" ------------------------------------------------------------
" Helpers
" ------------------------------------------------------------
function! s:ShellCommand(args) abort
  return join(map(copy(a:args), 'shellescape(v:val)'), ' ')
endfunction

function! s:System(args) abort
  return system(s:ShellCommand(a:args))
endfunction

function! s:SystemList(args) abort
  return systemlist(s:ShellCommand(a:args))
endfunction

" Bottom-panel height ≈ 30% (Cursor's layout ratio), clamped so small
" terminals still leave room for the editor and command line.
function! s:PanelHeight() abort
  let l:target = max([8, float2nr(&lines * 0.3)])
  let l:available = &lines - &cmdheight - 5
  return max([1, min([l:target, l:available])])
endfunction

" Scratch windows are grouped by the bracketed title prefix
" ("[Git Blame] foo.txt" -> "[Git Blame]") so repeated commands reuse
" one panel instead of stacking new windows.
function! s:ScratchKind(title) abort
  let l:kind = matchstr(a:title, '^\[[^]]*\]')
  return empty(l:kind) ? a:title : l:kind
endfunction

function! s:ScratchWinnr(kind) abort
  for l:winnr in range(1, winnr('$'))
    if getbufvar(winbufnr(l:winnr), 'scratch_kind', '') ==# a:kind
      return l:winnr
    endif
  endfor
  return 0
endfunction

" Focus an existing scratch window of the same kind and give it a fresh
" buffer (the old one wipes itself via bufhidden=wipe).
function! s:ReuseScratchWindow(title) abort
  let l:winnr = s:ScratchWinnr(s:ScratchKind(a:title))
  if l:winnr == 0
    return 0
  endif
  execute l:winnr . 'wincmd w'
  enew
  return 1
endfunction

function! s:OpenScratch(title, lines, filetype) abort
  if !s:ReuseScratchWindow(a:title)
    call s:OpenRightTopWindow(80)
  endif
  call s:PopulateScratch(a:title, a:lines, a:filetype)
endfunction

" ------------------------------------------------------------
" Sidebar slot (VSCode-like Search / Source Control views)
" ------------------------------------------------------------
" One window below the tree, shared by search results and Git status;
" opening one view overwrites the other.
" A slot window is identified by its marker plus its position in the
" left column; width is a user-adjustable attribute, not a criterion,
" so a manually widened slot is still found (and reused or closed).
function! s:SidebarSlotWinnr() abort
  for l:winnr in range(1, winnr('$'))
    if getwinvar(l:winnr, 'vscode_sidebar_slot', 0)
          \ && get(win_screenpos(l:winnr), 1, 0) == 1
          \ && winwidth(l:winnr) < &columns
      return l:winnr
    endif
  endfor
  return 0
endfunction

function! s:CloseSidebarSlot() abort
  let l:winnr = s:SidebarSlotWinnr()
  if l:winnr > 0 && winnr('$') > 1
    silent! call win_execute(win_getid(l:winnr), 'close')
  endif
endfunction

" Create the slot window: below the tree at half the column height, or
" as a standalone left column when the tree is closed.
function! s:SplitSidebarSlot(split_cmd) abort
  let l:tree_winnr = s:NetrwTreeWinnr()
  if l:tree_winnr > 0
    execute l:tree_winnr . 'wincmd w'
    execute 'belowright ' . max([3, winheight(0) / 2]) . a:split_cmd
  else
    execute 'topleft vertical ' . a:split_cmd
    execute 'vertical resize ' . s:netrw_tree_width
  endif
  let w:vscode_sidebar_slot = 1
  setlocal winfixheight winfixwidth
endfunction

function! s:OpenSidebarScratch(title, lines, filetype) abort
  let l:slot = s:SidebarSlotWinnr()
  if l:slot > 0
        \ && getbufvar(winbufnr(l:slot), 'scratch_kind', '') ==# s:ScratchKind(a:title)
    execute l:slot . 'wincmd w'
    enew
    let w:vscode_sidebar_slot = 1
    setlocal winfixheight winfixwidth
  else
    call s:CloseSidebarSlot()
    silent! cclose
    call s:SplitSidebarSlot('new')
  endif
  call s:PopulateScratch(a:title, a:lines, a:filetype)
endfunction

function! s:PopulateScratch(title, lines, filetype) abort
  setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted
  setlocal modifiable
  silent %delete _
  call setline(1, empty(a:lines) ? ['No output.'] : a:lines)
  let &l:filetype = a:filetype
  let b:scratch_kind = s:ScratchKind(a:title)
  let s:scratch_counter += 1
  execute 'file ' . fnameescape(a:title . ' #' . s:scratch_counter)
  setlocal nomodifiable readonly
  normal! gg
endfunction

function! s:WipeBuffer(bufnr) abort
  if a:bufnr > 0 && bufexists(a:bufnr)
    silent! execute 'bwipeout! ' . a:bufnr
  endif
endfunction

function! s:CloseGitDiffPair() abort
  if s:closing_git_diff_pair
    return
  endif

  let s:closing_git_diff_pair = 1
  let s:git_diff_close_pending = 0
  let l:base_winid = get(s:git_diff_pair, 'base_winid', -1)
  let l:file_winid = get(s:git_diff_pair, 'file_winid', -1)
  let l:base_bufnr = get(s:git_diff_pair, 'base_bufnr', -1)

  " Keep the file window open (VSCode returns to the file when a diff
  " closes); only the base window is closed.
  if win_id2win(l:file_winid) > 0
    silent! call win_execute(l:file_winid, 'if &diff | diffoff | endif')
    call setwinvar(win_id2win(l:file_winid), '&foldenable',
          \ get(s:git_diff_pair, 'file_foldenable', 1))
    call setwinvar(win_id2win(l:file_winid), '&foldcolumn',
          \ get(s:git_diff_pair, 'file_foldcolumn', 0))
  endif
  if win_id2win(l:base_winid) > 0
    if winnr('$') > 1
      silent! call win_execute(l:base_winid, 'close')
    else
      silent! call win_execute(l:base_winid, 'diffoff | enew')
    endif
  endif

  call s:WipeBuffer(l:base_bufnr)
  let s:git_diff_pair = {
        \ 'base_winid': -1,
        \ 'file_winid': -1,
        \ 'base_bufnr': -1
        \ }
  let s:closing_git_diff_pair = 0
endfunction

function! s:CloseGitDiffPairLater(timer) abort
  let s:git_diff_close_pending = 0
  call s:CloseGitDiffPair()
endfunction

function! s:MaybeCloseGitDiffPair(winid) abort
  if s:closing_git_diff_pair
    return
  endif

  if a:winid ==# get(s:git_diff_pair, 'base_winid', -1)
        \ || a:winid ==# get(s:git_diff_pair, 'file_winid', -1)
    if !s:git_diff_close_pending
      let s:git_diff_close_pending = 1
      call timer_start(0, function(expand('<SID>') . 'CloseGitDiffPairLater'))
    endif
  endif
endfunction

function! s:IsPrimaryEditorWindow(winnr) abort
  let l:bufnr = winbufnr(a:winnr)
  if l:bufnr <= 0
    return 0
  endif

  if getwinvar(a:winnr, '&previewwindow')
    return 0
  endif

  let l:buftype = getbufvar(l:bufnr, '&buftype')
  if l:buftype !=# ''
    return 0
  endif

  let l:filetype = getbufvar(l:bufnr, '&filetype')
  if l:filetype ==# 'netrw'
    return 0
  endif

  let l:name = bufname(l:bufnr)
  if l:name =~# 'NetrwTreeListing$'
    return 0
  endif

  return 1
endfunction

function! s:PrimaryEditorWinnr() abort
  if !exists('*win_screenpos')
    for l:winnr in range(1, winnr('$'))
      if s:IsPrimaryEditorWindow(l:winnr)
        return l:winnr
      endif
    endfor
    return 0
  endif

  let l:primary = 0
  let l:primary_col = 9999
  let l:primary_row = 9999

  for l:winnr in range(1, winnr('$'))
    if !s:IsPrimaryEditorWindow(l:winnr)
      continue
    endif

    let l:pos = win_screenpos(l:winnr)
    let l:row = get(l:pos, 0, 9999)
    let l:col = get(l:pos, 1, 9999)
    if l:col < l:primary_col || (l:col == l:primary_col && l:row < l:primary_row)
      let l:primary = l:winnr
      let l:primary_col = l:col
      let l:primary_row = l:row
    endif
  endfor

  return l:primary
endfunction

" Only windows we opened as the sidebar tree count; a plain :Explore in
" the editor area must not be treated as the tree.
function! s:NetrwTreeWinnr() abort
  for l:winnr in range(1, winnr('$'))
    if getwinvar(l:winnr, 'vscode_sidebar_tree', 0)
          \ && getbufvar(winbufnr(l:winnr), '&filetype') ==# 'netrw'
      return l:winnr
    endif
  endfor

  return 0
endfunction

" Adopt a leftmost, tree-sized netrw window as the sidebar tree — but
" only one created through :Lexplore (t:netrw_lexbufnr), so a user's
" plain :Explore split is never claimed by the sidebar machinery.
function! s:AdoptNetrwTreeWinnr() abort
  if !exists('t:netrw_lexbufnr')
    return 0
  endif
  for l:winnr in range(1, winnr('$'))
    if winbufnr(l:winnr) == t:netrw_lexbufnr
          \ && getbufvar(winbufnr(l:winnr), '&filetype') ==# 'netrw'
          \ && get(win_screenpos(l:winnr), 1, 0) == 1
          \ && winwidth(l:winnr) <= s:netrw_tree_width
      call setwinvar(l:winnr, 'vscode_sidebar_tree', 1)
      return l:winnr
    endif
  endfor
  return 0
endfunction

function! s:TerminalWinnr() abort
  if s:terminal_bufnr > 0
    let l:winid = bufwinid(s:terminal_bufnr)
    if l:winid != -1
      return win_id2win(l:winid)
    endif
  endif

  for l:winnr in range(1, winnr('$'))
    let l:bufnr = winbufnr(l:winnr)
    if l:bufnr > 0
          \ && getbufvar(l:bufnr, '&buftype') ==# 'terminal'
      let s:terminal_bufnr = l:bufnr
      return l:winnr
    endif
  endfor

  return 0
endfunction

function! s:EditInPrimaryWindow(file) abort
  let l:target = fnameescape(a:file)
  let l:winnr = s:PrimaryEditorWinnr()
  if l:winnr > 0
    if l:winnr != winnr()
      execute l:winnr . 'wincmd w'
    endif
  else
    " No editor window (e.g. only the sidebar is open): create the
    " editor column instead of taking over the current panel.
    call s:OpenRightTopWindow(0)
  endif
  execute 'edit ' . l:target
endfunction

function! s:OpenNetrwTree() abort
  let l:tree_winnr = s:NetrwTreeWinnr()
  if l:tree_winnr == 0
    let l:tree_winnr = s:AdoptNetrwTreeWinnr()
  endif
  if l:tree_winnr > 0
    execute l:tree_winnr . 'wincmd w'
    call s:ResizeNetrwTreeWindow()
    return
  endif

  let l:terminal_winnr = s:TerminalWinnr()
  if l:terminal_winnr == winnr() && winnr('$') > 1
    wincmd k
  endif

  let l:slot_winnr = s:SidebarSlotWinnr()
  if l:slot_winnr > 0
    " A standalone sidebar view is open: stack the tree above it.
    execute l:slot_winnr . 'wincmd w'
    aboveleft new
    silent! execute 'Explore ' . fnameescape(getcwd())
  else
    silent! topleft vertical Lexplore
  endif
  let w:vscode_sidebar_tree = 1
  call s:ResizeNetrwTreeWindow()
endfunction

function! s:ResizeNetrwTreeWindow() abort
  execute 'vertical resize ' . s:netrw_tree_width
  setlocal winfixwidth
endfunction

" VSCode-like sidebar toggle: hidden -> open, unfocused -> focus,
" focused -> close. Closing hides the whole sidebar, including the
" search / Git view in the slot below the tree.
function! s:ToggleNetrwTree() abort
  let l:tree_winnr = s:NetrwTreeWinnr()
  if l:tree_winnr > 0 && l:tree_winnr == winnr()
    call s:CloseSidebarSlot()
    if winnr('$') > 1
      close
    endif
    return
  endif
  call s:OpenNetrwTree()
endfunction

function! s:OpenRightTopWindow(width) abort
  let l:winnr = s:PrimaryEditorWinnr()
  if l:winnr == 0
    let l:winnr = s:NetrwTreeWinnr()
  endif

  if l:winnr > 0 && l:winnr != winnr()
    execute l:winnr . 'wincmd w'
  endif

  botright vertical new
  if a:width > 0
    execute 'vertical resize ' . a:width
    setlocal winfixwidth
  endif
endfunction

function! s:OpenDiffTargetWindow(file) abort
  if s:IsPrimaryEditorWindow(winnr())
    execute 'edit ' . fnameescape(a:file)
    return
  endif

  let l:winnr = s:PrimaryEditorWinnr()
  if l:winnr > 0
    execute l:winnr . 'wincmd w'
  else
    call s:OpenRightTopWindow(0)
  endif

  execute 'edit ' . fnameescape(a:file)
endfunction

function! s:PrepareNetrwPrimaryTarget() abort
  let l:winnr = s:PrimaryEditorWinnr()
  if l:winnr > 0
    let g:netrw_browse_split = 0
    let g:netrw_chgwin = l:winnr
    return
  endif

  let g:netrw_browse_split = 0
  let g:netrw_chgwin = -1
endfunction

function! s:AfterNetrwFileOpen() abort
  if !s:IsPrimaryEditorWindow(winnr())
    return
  endif

  let l:file_winid = win_getid()
  let l:tree_winnr = s:NetrwTreeWinnr()
  if l:tree_winnr == 0
    silent! Lexplore
    let l:tree_winnr = s:AdoptNetrwTreeWinnr()
  endif

  if l:tree_winnr > 0
    let l:current_winid = win_getid()
    execute l:tree_winnr . 'wincmd w'
    call s:ResizeNetrwTreeWindow()
    call win_gotoid(l:current_winid)
  endif

  call win_gotoid(l:file_winid)
endfunction

let g:Netrw_funcref = function(expand('<SID>') . 'AfterNetrwFileOpen')

function! s:SetupNetrwPrimaryOpen() abort
  nmap <buffer><silent><nowait> <CR> :<C-U>call <SID>PrepareNetrwPrimaryTarget()<CR><Plug>NetrwLocalBrowseCheck
  nmap <buffer><silent><nowait> % :<C-U>call <SID>PrepareNetrwPrimaryTarget()<CR><Plug>NetrwOpenFile
endfunction

" ------------------------------------------------------------
" Reveal the current file in the tree (VSCode: explorer.autoReveal)
" ------------------------------------------------------------
let s:revealing_tree = 0
let s:last_reveal = {}

" Move the cursor to the entry of the given name below the current
" cursor line, bounded to the subtree of the current node.
function! s:SearchTreeEntry(depth, name, is_dir) abort
  let l:pattern = '^\%(| \)\{' . a:depth . '}'
        \ . escape(a:name, '\.*$^~[]')
        \ . (a:is_dir ? '/$' : '[*@]\=$')
  let l:lnum = line('.') + 1
  while l:lnum <= line('$')
    let l:line_depth = strchars(matchstr(getline(l:lnum), '^\%(| \)*')) / 2
    if l:line_depth < a:depth
      return 0
    endif
    if l:line_depth == a:depth && getline(l:lnum) =~# l:pattern
      execute l:lnum
      return 1
    endif
    let l:lnum += 1
  endwhile
  return 0
endfunction

function! s:RevealInTree(force) abort
  if s:revealing_tree || &buftype !=# ''
    return
  endif
  let l:file = expand('%:p')
  if empty(l:file) || !filereadable(l:file)
    return
  endif
  let l:tree_winnr = s:NetrwTreeWinnr()
  if l:tree_winnr == 0
    return
  endif
  " The walk below relies on the tree listing format ('| ' depth
  " prefixes and a "name/" top row).
  if getwinvar(l:tree_winnr, 'netrw_liststyle', get(g:, 'netrw_liststyle', 0)) != 3
    if a:force
      echo 'RevealInTree requires the netrw tree listing (liststyle 3).'
    endif
    return
  endif
  let l:treetop = getwinvar(l:tree_winnr, 'netrw_treetop', '')
  if empty(l:treetop)
    return
  endif
  let l:rel = s:RelativeToGitRoot(l:file, l:treetop)
  if l:rel ==# l:file || l:rel =~# '^/'
    return
  endif

  " Every BufEnter calls this; skip the tree walk when nothing changed
  " since the last successful reveal.
  let l:state = {'file': l:file, 'tree': winbufnr(l:tree_winnr), 'top': l:treetop}
  if !a:force && s:last_reveal ==# l:state
    return
  endif

  let s:revealing_tree = 1
  let l:origin = win_getid()
  try
    execute l:tree_winnr . 'wincmd w'
    keepjumps normal! gg
    if search('^' . escape(fnamemodify(l:treetop, ':t'), '\.*$^~[]') . '/$', 'cW') == 0
      return
    endif
    let l:comps = split(l:rel, '/')
    for l:i in range(len(l:comps))
      let l:is_last = l:i == len(l:comps) - 1
      if !s:SearchTreeEntry(l:i + 1, l:comps[l:i], !l:is_last)
        return
      endif
      " Expand a collapsed directory: its children are one level deeper.
      if !l:is_last && getline(line('.') + 1) !~# '^\%(| \)\{' . (l:i + 2) . '}'
        execute "normal \<CR>"
      endif
    endfor
    let s:last_reveal = l:state
  finally
    call win_gotoid(l:origin)
    let s:revealing_tree = 0
  endtry
endfunction

function! s:AutoRevealInTree() abort
  if !get(g:, 'tree_auto_reveal', 1) || s:revealing_tree || &buftype !=# ''
    return
  endif
  call s:RevealInTree(0)
endfunction

command! -nargs=0 RevealInTree call <SID>RevealInTree(1)

augroup tree_auto_reveal
  autocmd!
  autocmd BufEnter * call <SID>AutoRevealInTree()
augroup END

function! s:OpenBottomTerminal() abort
  if !has('terminal')
    echohl WarningMsg
    echom 'This Vim does not support terminal jobs.'
    echohl None
    return
  endif

  let l:winnr = s:TerminalWinnr()
  if l:winnr > 0
    execute l:winnr . 'wincmd w'
    startinsert
    return
  endif

  " VSCode panel position: below the editor area, not below the sidebar.
  let l:bufnr = s:terminal_bufnr
  let l:editor_winnr = s:PrimaryEditorWinnr()
  if l:editor_winnr > 0
    execute l:editor_winnr . 'wincmd w'
  else
    " Only sidebar windows are left: create the editor column first so
    " the terminal still sits on the right, not across the sidebar.
    call s:OpenRightTopWindow(0)
  endif
  belowright split
  execute 'resize ' . s:PanelHeight()
  setlocal winfixheight
  if l:bufnr > 0 && bufexists(l:bufnr)
    execute 'buffer ' . l:bufnr
  else
    call term_start([&shell], {'curwin': v:true})
    let s:terminal_bufnr = bufnr('%')
  endif
  setlocal nobuflisted
  startinsert
endfunction

" VSCode-like panel toggle: hidden -> open, unfocused -> focus,
" focused -> close. The terminal buffer stays alive for reuse.
function! s:ToggleBottomTerminal() abort
  let l:winnr = s:TerminalWinnr()
  if l:winnr > 0 && l:winnr == winnr()
    if winnr('$') > 1
      close
    endif
    return
  endif
  call s:OpenBottomTerminal()
endfunction

" Jump to the quickfix entry under the cursor inside the editor area.
" Vim's default <CR> picks a nearby window, which can be the netrw tree
" when the quickfix list sits below it in the sidebar.
function! s:QuickfixJumpPrimary() abort
  if get(get(getwininfo(win_getid()), 0, {}), 'loclist', 0)
    execute "normal! \<CR>"
    return
  endif

  let l:idx = line('.')
  let l:qf_winid = win_getid()
  let l:editor_winnr = s:PrimaryEditorWinnr()
  let l:created_winid = 0
  if l:editor_winnr > 0
    execute l:editor_winnr . 'wincmd w'
  else
    call s:OpenRightTopWindow(0)
    let l:created_winid = win_getid()
  endif
  try
    execute 'cc ' . l:idx
  catch
    " Invalid entry or unreadable buffer: restore the layout and report.
    " Close the created fallback by id; an autocmd fired by :cc may have
    " moved the focus elsewhere.
    if l:created_winid != 0 && win_id2win(l:created_winid) > 0 && winnr('$') > 1
      silent! call win_execute(l:created_winid, 'close')
    endif
    call win_gotoid(l:qf_winid)
    echohl WarningMsg
    echom substitute(v:exception, '^Vim\%((\a\+)\)\=:', '', '')
    echohl None
  endtry
endfunction

" Quickfix (search results / problems) opens in the sidebar slot below
" the tree. The location list stays attached to its own window, so it
" opens below the current window instead.
function! s:OpenQuickfixPanel(cmd) abort
  if a:cmd ==# 'lopen'
    try
      execute 'belowright lopen ' . s:PanelHeight()
    catch /E776/
      echo 'No location list.'
    endtry
    return
  endif

  let l:slot = s:SidebarSlotWinnr()
  if l:slot > 0 && getwinvar(l:slot, '&buftype') ==# 'quickfix'
        \ && winwidth(l:slot) <= s:netrw_tree_width
    execute l:slot . 'wincmd w'
    return
  endif

  " Re-anchor a quickfix window that lives anywhere else.
  silent! cclose
  call s:CloseSidebarSlot()
  let l:tree_winnr = s:NetrwTreeWinnr()
  if l:tree_winnr > 0
    execute l:tree_winnr . 'wincmd w'
    execute 'belowright copen ' . max([3, winheight(0) / 2])
  else
    topleft vertical copen
    execute 'vertical resize ' . s:netrw_tree_width
  endif
  let w:vscode_sidebar_slot = 1
  setlocal winfixheight winfixwidth
endfunction

" Buffer shown instead of a deleted one: the alternate if it is a normal
" listed buffer, else the nearest previous listed normal buffer.
function! s:ReplacementBuffer(bufnr) abort
  let l:alt = bufnr('#')
  if l:alt > 0 && l:alt != a:bufnr && buflisted(l:alt)
        \ && getbufvar(l:alt, '&buftype') ==# ''
    return l:alt
  endif

  let l:listed = filter(range(1, bufnr('$')),
        \ 'buflisted(v:val) && v:val != a:bufnr && getbufvar(v:val, "&buftype") ==# ""')
  if empty(l:listed)
    return 0
  endif
  let l:before = filter(copy(l:listed), 'v:val < a:bufnr')
  return empty(l:before) ? l:listed[-1] : l:before[-1]
endfunction

" Delete the current buffer without taking its windows along (VSCode-like
" tab close). :bdelete closes every window showing the buffer when other
" windows exist, which collapses the layout next to the sidebar/panel.
function! s:DeleteBufferKeepWindow() abort
  " Panel windows (terminal, quickfix, netrw, scratch) close like their
  " toggles do; their buffers stay reusable.
  if &buftype !=# '' || &filetype ==# 'netrw'
    if winnr('$') > 1
      close
    endif
    return
  endif

  let l:bufnr = bufnr('%')
  let l:replacement = s:ReplacementBuffer(l:bufnr)
  let l:switched = []
  for l:winid in win_findbuf(l:bufnr)
    if l:replacement > 0
      call win_execute(l:winid, 'buffer ' . l:replacement)
      call add(l:switched, [l:winid, 0])
    else
      call win_execute(l:winid, 'enew')
      call add(l:switched, [l:winid, get(get(getwininfo(l:winid), 0, {}), 'bufnr', 0)])
    endif
  endfor

  execute 'confirm bdelete ' . l:bufnr
  if buflisted(l:bufnr)
    " Cancelled: put the buffer back and drop temporary empty buffers.
    for [l:winid, l:empty_bufnr] in l:switched
      silent! call win_execute(l:winid, 'buffer ' . l:bufnr)
      if l:empty_bufnr > 0 && bufexists(l:empty_bufnr)
        silent! execute 'bwipeout ' . l:empty_bufnr
      endif
    endfor
  endif
endfunction

function! s:DeleteOtherBuffers() abort
  let l:current_bufnr = bufnr('%')

  for l:bufnr in range(1, bufnr('$'))
    if l:bufnr == l:current_bufnr || !buflisted(l:bufnr)
      continue
    endif
    if getbufvar(l:bufnr, '&buftype') !=# ''
      continue
    endif

    execute 'confirm bdelete ' . l:bufnr
  endfor
endfunction

" ------------------------------------------------------------
" Git helpers
" ------------------------------------------------------------
function! s:GitRoot(path, ...) abort
  let l:quiet = a:0 ? a:1 : 0
  if !executable('git')
    if !l:quiet
      echohl WarningMsg
      echom 'git is not installed.'
      echohl None
    endif
    return ''
  endif

  let l:path = a:path
  if empty(l:path)
    let l:current_file = expand('%:p')
    let l:path = filereadable(l:current_file) ? l:current_file : getcwd()
  endif
  let l:start = isdirectory(l:path) ? fnamemodify(l:path, ':p') : fnamemodify(l:path, ':p:h')
  let l:root = s:System(['git', '-C', l:start, 'rev-parse', '--show-toplevel'])
  if v:shell_error
    if !l:quiet
      echohl WarningMsg
      echom 'This is not a Git work tree.'
      echohl None
    endif
    return ''
  endif

  return substitute(l:root, '\n\+$', '', '')
endfunction

function! s:ProjectRoot() abort
  let l:file = expand('%:p')
  if filereadable(l:file)
    let l:root = s:GitRoot(l:file, 1)
    if !empty(l:root)
      return l:root
    endif
  endif
  return getcwd()
endfunction

" :find / :grep open their target in the current window, so move to the
" editor area first when invoked from the tree or a panel.
function! s:FocusPrimaryEditor() abort
  if s:IsPrimaryEditorWindow(winnr())
    return
  endif
  let l:editor_winnr = s:PrimaryEditorWinnr()
  if l:editor_winnr > 0
    execute l:editor_winnr . 'wincmd w'
  else
    call s:OpenRightTopWindow(0)
  endif
endfunction

function! s:ConfigureProjectFind() abort
  call s:FocusPrimaryEditor()
  execute 'lcd ' . fnameescape(s:ProjectRoot())
  setlocal path=.,**
endfunction

function! s:ConfigureProjectGrep() abort
  call s:FocusPrimaryEditor()
  execute 'lcd ' . fnameescape(s:ProjectRoot())
  if executable('rg')
    let &grepprg = 'rg --vimgrep --hidden --glob ' . shellescape('!.git/*')
    set grepformat=%f:%l:%c:%m
    return
  endif

  let l:file = expand('%:p')
  let l:root = s:GitRoot(filereadable(l:file) ? l:file : '', 1)
  if !empty(l:root)
    execute 'lcd ' . fnameescape(l:root)
    let &grepprg = 'git -C ' . shellescape(l:root) . ' grep -n --column -I'
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    return
  endif

  let &grepprg = s:default_grepprg
  let &grepformat = s:default_grepformat
endfunction

function! s:RelativeToGitRoot(file, root) abort
  let l:file = fnamemodify(resolve(a:file), ':p')
  let l:root = fnamemodify(resolve(a:root), ':p')
  if stridx(l:file, l:root) ==# 0
    return strpart(l:file, strlen(l:root))
  endif
  return l:file
endfunction

function! s:ProjectRelativePath() abort
  let l:file = expand('%:p')
  if empty(l:file)
    return ''
  endif
  let l:file = fnamemodify(resolve(l:file), ':p')

  let l:root = fnamemodify(resolve(s:ProjectRoot()), ':p')
  if stridx(l:file, l:root) ==# 0
    return strpart(l:file, strlen(l:root))
  endif
  return fnamemodify(l:file, ':.')
endfunction

function! s:GitGrepLinesWithRoot(lines, root) abort
  let l:root = fnamemodify(a:root, ':p')
  return map(copy(a:lines), 'v:val =~# "^/" ? v:val : l:root . v:val')
endfunction

function! s:CurrentFileForGit(action) abort
  let l:file = expand('%:p')
  if empty(l:file) || !filereadable(l:file)
    echohl WarningMsg
    echom 'Open a readable file to run git ' . a:action . '.'
    echohl None
    return ''
  endif
  return l:file
endfunction

" ------------------------------------------------------------
" Git commands
" ------------------------------------------------------------
function! s:GitGrep(query) abort
  let l:root = s:GitRoot('')
  if empty(l:root)
    return
  endif

  let l:query = a:query
  if empty(l:query)
    call inputsave()
    let l:query = input('Git grep: ')
    call inputrestore()
  endif
  if empty(l:query)
    return
  endif

  let l:lines = s:SystemList(['git', '-C', l:root, 'grep', '-n', '--column', '-I', '--fixed-strings', '--', l:query])
  if v:shell_error == 1
    echo 'No git grep matches: ' . l:query
    return
  elseif v:shell_error
    echohl WarningMsg
    echom 'git grep failed.'
    echohl None
    return
  endif

  call setqflist([], 'r', {
        \ 'title': 'git grep: ' . l:query,
        \ 'lines': s:GitGrepLinesWithRoot(l:lines, l:root),
        \ 'efm': '%f:%l:%c:%m,%f:%l:%m'
        \ })
  call s:OpenQuickfixPanel('copen')
endfunction

function! s:GitReplace() abort
  let l:root = s:GitRoot('')
  if empty(l:root)
    return
  endif

  call inputsave()
  let l:from = input('Git replace from: ')
  if empty(l:from)
    call inputrestore()
    return
  endif
  let l:to = input('Git replace to: ')
  call inputrestore()

  let l:out = s:System(['git', '-C', l:root, 'grep', '-l', '-I', '--fixed-strings', '--', l:from])
  if v:shell_error == 1
    echo 'No git grep matches: ' . l:from
    return
  elseif v:shell_error
    echohl WarningMsg
    echom 'git grep failed.'
    echohl None
    return
  endif

  let l:files = filter(split(l:out, "\n"), '!empty(v:val)')
  if empty(l:files)
    echo 'No git grep matches: ' . l:from
    return
  endif

  let l:absolute_files = map(copy(l:files), 'fnamemodify(l:root . "/" . v:val, ":p")')
  execute 'args ' . join(map(l:absolute_files, 'fnameescape(v:val)'), ' ')
  let l:pattern = '\V' . escape(l:from, '\/')
  let l:replacement = escape(l:to, '\/&')
  execute 'argdo %s/' . l:pattern . '/' . l:replacement . '/gce'
  echo 'Git replace checked ' . len(l:files) . ' file(s). Review buffers, then :wall to save.'
endfunction

function! s:GitStatus() abort
  let l:root = s:GitRoot('')
  if empty(l:root)
    return
  endif

  let l:entries = s:GitStatusEntries(l:root)
  if v:shell_error
    echohl WarningMsg
    echom 'git status failed.'
    echohl None
    return
  endif

  call s:OpenSidebarScratch('[Git Status]', map(copy(l:entries), 'v:val.display'), 'git')
  let b:git_status_root = l:root
  let b:git_status_entries = l:entries
  call s:SetupGitStatusKeymaps()
endfunction

" Parse `git status --porcelain=v1 --branch -z` into display rows and target paths.
function! s:GitStatusFields(root) abort
  let l:tmp = tempname()
  let l:cmd = 'git -C ' . shellescape(a:root) . ' status --porcelain=v1 --branch -z > ' . shellescape(l:tmp)
  call system(l:cmd)
  if v:shell_error
    call delete(l:tmp)
    return []
  endif
  let l:bytes = blob2list(readblob(l:tmp))
  call delete(l:tmp)
  let l:fields = []
  let l:current = []
  for l:byte in l:bytes
    if l:byte == 0
      call add(l:fields, join(blob2str(list2blob(l:current)), "\n"))
      let l:current = []
    else
      call add(l:current, l:byte)
    endif
  endfor
  if !empty(l:current)
    call add(l:fields, join(blob2str(list2blob(l:current)), "\n"))
  endif
  return l:fields
endfunction

function! s:GitStatusEntries(root) abort
  let l:fields = s:GitStatusFields(a:root)
  let l:entries = []
  let l:i = 0
  while l:i < len(l:fields)
    let l:field = l:fields[l:i]
    if l:field =~# '^## '
      call add(l:entries, {'display': l:field, 'path': ''})
    elseif l:field =~# '^[ MTADRCU?!]\{2\} '
      let l:status = strpart(l:field, 0, 2)
      let l:path = strpart(l:field, 3)
      if l:status =~# '[RC]' && l:i + 1 < len(l:fields)
        let l:old_path = l:fields[l:i + 1]
        call add(l:entries, {
              \ 'display': l:status . ' ' . l:old_path . ' -> ' . l:path,
              \ 'path': l:path,
              \ 'base_path': l:old_path
              \ })
        let l:i += 1
      else
        call add(l:entries, {'display': l:field, 'path': l:path, 'base_path': l:path})
      endif
    endif
    let l:i += 1
  endwhile
  if empty(l:entries)
    return [{'display': 'No output.', 'path': ''}]
  endif
  return l:entries
endfunction

function! s:GitStatusEntryOnLine() abort
  let l:entries = get(b:, 'git_status_entries', [])
  let l:idx = line('.') - 1
  if l:idx < 0 || l:idx >= len(l:entries)
    return {}
  endif
  return l:entries[l:idx]
endfunction

function! s:GitStatusBasePath(root, relfile) abort
  for l:entry in s:GitStatusEntries(a:root)
    if get(l:entry, 'path', '') ==# a:relfile
      return get(l:entry, 'base_path', a:relfile)
    endif
  endfor

  return a:relfile
endfunction

function! s:GitStatusRefresh() abort
  let l:root = get(b:, 'git_status_root', '')
  if empty(l:root)
    return
  endif
  let l:save = getpos('.')
  let l:entries = s:GitStatusEntries(l:root)
  setlocal modifiable noreadonly
  silent %delete _
  call setline(1, map(copy(l:entries), 'v:val.display'))
  setlocal nomodifiable readonly nomodified
  let b:git_status_entries = l:entries
  let l:save[1] = min([l:save[1], line('$')])
  call setpos('.', l:save)
endfunction

function! s:GitStatusRun(args, label) abort
  let l:root = get(b:, 'git_status_root', '')
  let l:entry = s:GitStatusEntryOnLine()
  let l:file = get(l:entry, 'path', '')
  if empty(l:root) || empty(l:file)
    return
  endif
  call s:System(['git', '-C', l:root] + a:args + ['--', l:file])
  if v:shell_error
    echohl WarningMsg
    echom a:label . ' failed: ' . l:file
    echohl None
    return
  endif
  call s:GitStatusRefresh()
endfunction

" Open the file on the current line. a:split opens it in a split instead of
" reusing the previous window.
function! s:GitStatusOpen(split) abort
  let l:root = get(b:, 'git_status_root', '')
  let l:entry = s:GitStatusEntryOnLine()
  let l:file = get(l:entry, 'path', '')
  if empty(l:root) || empty(l:file)
    return
  endif
  let l:target = fnameescape(l:root . '/' . l:file)
  if a:split
    " Split inside the editor area, not inside the sidebar column.
    let l:editor_winnr = s:PrimaryEditorWinnr()
    if l:editor_winnr > 0
      execute l:editor_winnr . 'wincmd w'
      execute 'aboveleft split ' . l:target
    else
      call s:OpenRightTopWindow(0)
      execute 'edit ' . l:target
    endif
  else
    call s:EditInPrimaryWindow(l:root . '/' . l:file)
  endif
endfunction

" Show the diff for the file on the current line.
function! s:GitStatusDiff() abort
  let l:root = get(b:, 'git_status_root', '')
  let l:entry = s:GitStatusEntryOnLine()
  let l:file = get(l:entry, 'path', '')
  let l:base_file = get(l:entry, 'base_path', l:file)
  if empty(l:root) || empty(l:file)
    return
  endif
  " Like VSCode's Source Control view, the status list stays visible
  " while the diff opens in the editor area.
  call s:GitDiffSideBySideForFile(l:root . '/' . l:file, l:base_file)
endfunction

function! s:GitStatusAdd() abort
  call s:GitStatusRun(['add'], 'git add')
endfunction

function! s:GitStatusUnstage() abort
  call s:GitStatusRun(['restore', '--staged'], 'git restore --staged')
endfunction

function! s:GitStatusDiscard() abort
  let l:entry = s:GitStatusEntryOnLine()
  let l:file = get(l:entry, 'path', '')
  if empty(l:file)
    return
  endif
  call inputsave()
  let l:ans = input('Discard working-tree changes in ' . l:file . '? (staged changes are kept) (y/N) ')
  call inputrestore()
  if l:ans !~? '^y'
    echo 'Cancelled.'
    return
  endif
  call s:GitStatusRun(['restore'], 'git restore')
endfunction

function! s:SetupGitStatusKeymaps() abort
  nnoremap <silent> <buffer> a :call <SID>GitStatusAdd()<CR>
  nnoremap <silent> <buffer> r :call <SID>GitStatusUnstage()<CR>
  nnoremap <silent> <buffer> R :call <SID>GitStatusDiscard()<CR>
  nnoremap <silent> <buffer> d :call <SID>GitStatusDiff()<CR>
  nnoremap <silent> <buffer> <CR> :call <SID>GitStatusOpen(0)<CR>
  nnoremap <silent> <buffer> o :call <SID>GitStatusOpen(1)<CR>
  nnoremap <silent> <buffer> gr :call <SID>GitStatusRefresh()<CR>
  nnoremap <silent> <buffer> q :close<CR>
endfunction

function! s:GitBlame() abort
  let l:file = s:CurrentFileForGit('blame')
  if empty(l:file)
    return
  endif
  let l:root = s:GitRoot(l:file)
  if empty(l:root)
    return
  endif
  let l:relfile = s:RelativeToGitRoot(l:file, l:root)

  let l:lines = s:SystemList(['git', '-C', l:root, 'blame', '--date=short', '--', l:relfile])
  if v:shell_error
    echohl WarningMsg
    echom 'git blame failed. The file may be untracked.'
    echohl None
    return
  endif

  call s:OpenScratch('[Git Blame] ' . fnamemodify(l:file, ':t'), l:lines, 'git')
endfunction

function! s:GitDiff() abort
  let l:file = s:CurrentFileForGit('diff')
  if empty(l:file)
    return
  endif
  let l:root = s:GitRoot(l:file)
  if empty(l:root)
    return
  endif
  let l:relfile = s:RelativeToGitRoot(l:file, l:root)

  let l:lines = s:SystemList(['git', '-C', l:root, 'diff', 'HEAD', '--', l:relfile])
  if v:shell_error
    " Repositories without an initial commit do not have HEAD yet.
    let l:lines = s:SystemList(['git', '-C', l:root, 'diff', '--', l:relfile])
    if v:shell_error
      echohl WarningMsg
      echom 'git diff failed.'
      echohl None
      return
    endif
  endif
  if empty(l:lines)
    let l:lines = ['No git diff for ' . fnamemodify(l:file, ':.')]
  endif

  call s:OpenScratch('[Git Diff] ' . fnamemodify(l:file, ':t'), l:lines, 'diff')
endfunction

function! s:GitDiffSideBySideForFile(file, ...) abort
  let l:file = fnamemodify(a:file, ':p')
  if empty(l:file)
    return
  endif
  let l:root = s:GitRoot(l:file)
  if empty(l:root)
    return
  endif
  let l:relfile = s:RelativeToGitRoot(l:file, l:root)
  let l:base_relfile = a:0 ? a:1 : l:relfile

  let l:old_lines = s:SystemList(['git', '-C', l:root, 'show', 'HEAD:' . l:base_relfile])
  if v:shell_error
    let l:old_lines = []
  endif

  call s:CloseGitDiffPair()

  let l:base_name = '[Git Base] ' . fnamemodify(l:root, ':p') . ':' . l:base_relfile
  call s:WipeBuffer(bufnr(l:base_name))

  call s:OpenDiffTargetWindow(l:file)
  " :diffoff on a non-diff window would reset its fold options to the
  " defaults, so only clear an actual diff state (including a partner
  " window from an unrelated diff).
  if &diff
    silent! diffoff!
  endif
  let l:new_winid = win_getid()

  aboveleft vertical new
  let l:base_winid = win_getid()
  setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted
  setlocal modifiable
  silent %delete _
  call setline(1, empty(l:old_lines) ? [''] : l:old_lines)
  let &l:filetype = getbufvar(winbufnr(win_id2win(l:new_winid)), '&filetype')
  execute 'file ' . fnameescape(l:base_name)
  setlocal nomodifiable readonly
  diffthis
  " Show the whole file like VSCode's diff editor, not just the hunks.
  setlocal nofoldenable foldcolumn=0

  call win_gotoid(l:new_winid)
  if &diff
    silent! diffoff
  endif
  " Remember the fold view we override below; :diffoff only restores
  " values still owned by diff mode, not ones changed after :diffthis.
  let l:file_foldenable = &l:foldenable
  let l:file_foldcolumn = &l:foldcolumn
  diffthis
  setlocal noreadonly modifiable
  setlocal nofoldenable foldcolumn=0
  " Focus the first hunk. From line 1, ]c overshoots to the second hunk
  " when line 1 itself is changed; [c steps back to the first in that
  " case and stays put otherwise.
  silent! normal! gg]c[c

  let s:git_diff_pair = {
        \ 'base_winid': l:base_winid,
        \ 'file_winid': l:new_winid,
        \ 'base_bufnr': winbufnr(win_id2win(l:base_winid)),
        \ 'file_foldenable': l:file_foldenable,
        \ 'file_foldcolumn': l:file_foldcolumn
        \ }
endfunction

function! s:GitDiffSideBySide() abort
  let l:file = s:CurrentFileForGit('diff')
  if empty(l:file)
    return
  endif
  let l:root = s:GitRoot(l:file)
  if empty(l:root)
    return
  endif
  let l:relfile = s:RelativeToGitRoot(l:file, l:root)
  call s:GitDiffSideBySideForFile(l:file, s:GitStatusBasePath(l:root, l:relfile))
endfunction

" ------------------------------------------------------------
" Commands
" ------------------------------------------------------------
command! -nargs=* GitGrep call <SID>GitGrep(<q-args>)
command! -nargs=0 GitReplace call <SID>GitReplace()
command! -nargs=0 GitStatus call <SID>GitStatus()
command! -nargs=0 GitBlame call <SID>GitBlame()
command! -nargs=0 GitDiff call <SID>GitDiff()
command! -nargs=0 GitDiffSideBySide call <SID>GitDiffSideBySide()

function! s:CopyText(text, label) abort
  if empty(a:text)
    echohl WarningMsg
    echom 'No file path for this buffer.'
    echohl None
    return
  endif

  call setreg('"', a:text)
  if has('clipboard')
    call setreg('+', a:text)
  endif
  echom 'Copied ' . a:label . ': ' . a:text
endfunction

function! s:CopyPath(modifier, include_line, label) abort
  let l:path = expand(a:modifier)
  if a:include_line && !empty(l:path)
    let l:path .= ':' . line('.')
  endif
  call s:CopyText(l:path, a:label)
endfunction

command! -nargs=0 CopyRelativePath call <SID>CopyText(<SID>ProjectRelativePath(), 'relative path')
command! -nargs=0 CopyAbsolutePath call <SID>CopyPath('%:p', 0, 'absolute path')
command! -nargs=0 CopyPathWithLine call <SID>CopyPath('%:p', 1, 'path with line')

" ------------------------------------------------------------
" Reveal in Finder (VSCode: Reveal in Finder)
" ------------------------------------------------------------
" Absolute path of the entry under the cursor in a netrw window.
function! s:NetrwCursorPath() abort
  " Banner rows: NetrwGetWord() is not a plain getter there and can move
  " the cursor or toggle netrw state, so bail out first.
  if line('.') < get(w:, 'netrw_bannercnt', 0)
    return ''
  endif

  try
    let l:word = netrw#Call('NetrwGetWord')
  catch
    return ''
  endtry
  if empty(l:word)
    return ''
  endif
  let l:curline = getline('.')

  if get(w:, 'netrw_liststyle', get(g:, 'netrw_liststyle', 0)) == 3
        \ && exists('w:netrw_treetop')
    " The treetop row would compose as treetop + its own name.
    if l:curline ==# fnamemodify(w:netrw_treetop, ':t') . '/'
      return fnamemodify(w:netrw_treetop, ':p')
    endif
    try
      let l:dir = netrw#Call('NetrwTreePath', w:netrw_treetop)
    catch
      " Without NetrwTreePath any other base directory would be wrong for
      " nested entries, so refuse rather than reveal a wrong path.
      return ''
    endtry
    if empty(l:dir)
      return ''
    endif
    " For directory and symlink rows the tree path already includes the
    " node itself; for file rows it is the parent directory.
    if l:curline =~# '/$' || l:curline =~# '@\s\+-->'
      return l:dir
    endif
    return (l:dir =~# '/$' ? l:dir : l:dir . '/') . l:word
  endif

  let l:dir = get(b:, 'netrw_curdir', getcwd())
  let l:word = substitute(l:word, '/$', '', '')
  return (l:dir =~# '/$' ? l:dir : l:dir . '/') . l:word
endfunction

function! s:RevealInFinder() abort
  let l:cmd = get(g:, 'finder_reveal_command', ['open', '-R'])
  if type(l:cmd) != v:t_list || empty(l:cmd) || !executable(l:cmd[0])
    echohl WarningMsg
    echom 'Reveal command is not available: ' . string(l:cmd)
    echohl None
    return
  endif

  if &filetype ==# 'netrw'
    let l:path = s:NetrwCursorPath()
  else
    let l:path = expand('%:p')
  endif
  " getftype() also accepts broken symlinks, which Finder can still select.
  if empty(l:path) || getftype(l:path) ==# ''
    echohl WarningMsg
    echom 'No file to reveal in Finder.'
    echohl None
    return
  endif

  call s:System(l:cmd + [l:path])
  if v:shell_error
    echohl WarningMsg
    echom 'Failed to reveal in Finder: ' . l:path
    echohl None
  endif
endfunction

command! -nargs=0 RevealInFinder call <SID>RevealInFinder()

" ------------------------------------------------------------
" Optional plugin integrations
" ------------------------------------------------------------
function! CheckBackspace() abort
  let l:col = col('.') - 1
  return !l:col || getline('.')[l:col - 1] =~# '\s'
endfunction

function! s:CocActionAsync(...) abort
  if exists('*CocActionAsync')
    return call('CocActionAsync', a:000)
  endif
  echohl WarningMsg
  echom 'coc.nvim is not available.'
  echohl None
endfunction

function! s:SetupCocKeymaps() abort
  if !exists('g:did_coc_loaded')
    return
  endif

  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
  inoremap <silent><expr> <CR>
        \ coc#pum#visible() ? coc#pum#confirm() :
        \ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  nmap <silent> [d <Plug>(coc-diagnostic-prev)
  nmap <silent> ]d <Plug>(coc-diagnostic-next)
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nnoremap <silent> K :call <SID>CocActionAsync('doHover')<CR>

  nmap <silent> <leader>ca <Plug>(coc-codeaction-cursor)
  xmap <silent> <leader>ca <Plug>(coc-codeaction-selected)
  nmap <silent> <leader>cA <Plug>(coc-codeaction-source)
  nmap <silent> <leader>cr <Plug>(coc-rename)
  nnoremap <silent> <leader>cf :call <SID>CocActionAsync('format')<CR>
  nnoremap <silent> <leader>cl :CocList extensions<CR>
  nnoremap <silent> <leader>cR :CocRestart<CR>

  nnoremap <silent> <leader>xx :CocList diagnostics<CR>
  nnoremap <silent> <leader>xn :call <SID>CocActionAsync('diagnosticNext')<CR>
  nnoremap <silent> <leader>xp :call <SID>CocActionAsync('diagnosticPrevious')<CR>
endfunction

function! s:SetupGitGutterKeymaps() abort
  if !exists(':GitGutterPreviewHunk')
    return
  endif

  nnoremap <silent> <leader>hs :GitGutterStageHunk<CR>
  nnoremap <silent> <leader>hu :GitGutterUndoHunk<CR>
  nnoremap <silent> <leader>hp :GitGutterPreviewHunk<CR>
  nnoremap <silent> <leader>hn :GitGutterNextHunk<CR>
  nnoremap <silent> <leader>hN :GitGutterPrevHunk<CR>
endfunction

function! s:SetupCommentaryKeymaps() abort
  if empty(maparg('gcc', 'n'))
    return
  endif

  nmap <leader>/ gcc
  xmap <leader>/ gc
endfunction

augroup optional_plugin_keymaps
  autocmd!
  autocmd VimEnter * call <SID>SetupCocKeymaps()
  autocmd VimEnter * call <SID>SetupGitGutterKeymaps()
  autocmd VimEnter * call <SID>SetupCommentaryKeymaps()
augroup END

augroup netrw_primary_open
  autocmd!
  autocmd FileType netrw call <SID>SetupNetrwPrimaryOpen()
augroup END

augroup git_diff_pair_windows
  autocmd!
  autocmd WinClosed * call <SID>MaybeCloseGitDiffPair(str2nr(expand('<amatch>')))
augroup END

augroup reload_changed_files
  autocmd!
  autocmd FocusGained,BufEnter,CursorHold * silent! checktime
augroup END

augroup fixed_panel_windows
  autocmd!
  " Quickfix / location list opened by any means stays a fixed-height panel.
  autocmd FileType qf setlocal winfixheight
  autocmd FileType qf nnoremap <silent> <buffer> <CR> :call <SID>QuickfixJumpPrimary()<CR>
  " :grep (<Space>fw) fills the list without opening a window; show the
  " results in the sidebar slot like the other search commands.
  autocmd QuickFixCmdPost grep call <SID>OpenQuickfixPanel('copen')
augroup END

" ------------------------------------------------------------
" Keymaps
" ------------------------------------------------------------
nnoremap <silent> <leader>w :write<CR>
nnoremap <silent> <leader>q :confirm quit<CR>
nnoremap <silent> <leader>Q :confirm qall<CR>
nnoremap <silent> <leader>nh :nohlsearch<CR>

nnoremap <silent> <leader>e :call <SID>ToggleNetrwTree()<CR>
nnoremap <leader>fw :call <SID>ConfigureProjectGrep()<CR>:grep<Space>
nnoremap <silent> <leader>fG :GitGrep<CR>
nnoremap <leader>ff :call <SID>ConfigureProjectFind()<CR>:find<Space>
nnoremap <leader>fb :buffer<Space>
nnoremap <leader>fr :RecentFiles<Space>

nnoremap <silent> <leader>yp :CopyRelativePath<CR>
nnoremap <silent> <leader>yP :CopyAbsolutePath<CR>
nnoremap <silent> <leader>yl :CopyPathWithLine<CR>
nnoremap <silent> <leader>of :RevealInFinder<CR>

nnoremap <leader>sr :%s///gc<Left><Left><Left><Left>
nnoremap <leader>sw :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
nnoremap <silent> <leader>sG :GitReplace<CR>
xnoremap <leader>sr :s///gc<Left><Left><Left><Left>

nnoremap <silent> <leader>gg :GitStatus<CR>
nnoremap <silent> <leader>gb :GitBlame<CR>
nnoremap <silent> <leader>gd :GitDiff<CR>
nnoremap <silent> <leader>gD :GitDiffSideBySide<CR>

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> <leader>bn :bnext<CR>
nnoremap <silent> <leader>bp :bprevious<CR>
nnoremap <silent> <leader>bd :call <SID>DeleteBufferKeepWindow()<CR>
nnoremap <silent> <leader>bo :call <SID>DeleteOtherBuffers()<CR>

nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> ]l :lnext<CR>
nnoremap <silent> <leader>xq :call <SID>OpenQuickfixPanel('copen')<CR>
nnoremap <silent> <leader>xl :call <SID>OpenQuickfixPanel('lopen')<CR>

" Keep the visual selection while indenting, like VSCode's Tab indent.
xnoremap < <gv
xnoremap > >gv

" ------------------------------------------------------------
" Window resize mode
" ------------------------------------------------------------
" <C-w> plus < > + - enters a transient resize mode: afterwards the bare
" keys keep resizing (hold one down for a smooth drag-like resize), and
" any other key exits and acts normally.
function! s:WinResizeStep(key, count) abort
  if a:key ==# '>'
    execute 'vertical resize +' . (2 * a:count)
  elseif a:key ==# '<'
    execute 'vertical resize -' . (2 * a:count)
  elseif a:key ==# '+'
    execute 'resize +' . a:count
  elseif a:key ==# '-'
    execute 'resize -' . a:count
  endif
endfunction

let s:winresize_active = 0

function! s:WinResizeMode(initial, count) abort
  " A timer or job callback could fire the mapping while the mode is
  " already reading keys; just perform the step without nesting.
  if s:winresize_active
    call s:WinResizeStep(a:initial, a:count)
    return
  endif
  let s:winresize_active = 1

  try
    call s:WinResizeStep(a:initial, a:count)
    redraw
    echo 'resize: < > + -  (other keys exit)'
    while 1
      let l:char = getchar()
      let l:key = type(l:char) == v:t_number ? nr2char(l:char) : l:char
      " Pseudo keys (CursorHold fires after 'updatetime') must not end
      " the mode while the user is idle.
      if l:key ==# "\<CursorHold>" || l:key ==# "\<Ignore>"
        continue
      endif
      if index(['<', '>', '+', '-'], l:key) >= 0
        call s:WinResizeStep(l:key, 1)
        redraw
      else
        if l:key !=# "\<Esc>"
          " 'i' re-inserts at the front of the typeahead so the key runs
          " before anything typed after it (e.g. the w of a quick dw).
          call feedkeys(l:key, 'it')
        endif
        break
      endif
    endwhile
    echo ''
  finally
    let s:winresize_active = 0
  endtry
endfunction

nnoremap <silent> <C-w>> :<C-u>call <SID>WinResizeMode('>', v:count1)<CR>
nnoremap <silent> <C-w>< :<C-u>call <SID>WinResizeMode('<', v:count1)<CR>
nnoremap <silent> <C-w>+ :<C-u>call <SID>WinResizeMode('+', v:count1)<CR>
nnoremap <silent> <C-w>- :<C-u>call <SID>WinResizeMode('-', v:count1)<CR>

if has('terminal')
  nnoremap <silent> <leader>ot :call <SID>ToggleBottomTerminal()<CR>
  tnoremap <Esc><Esc> <C-\><C-n>
endif
