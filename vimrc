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
set ignorecase
set smartcase
set incsearch
set hlsearch
set splitbelow
set splitright
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

if exists('&viminfofile')
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

set statusline=%#StatusLine#
set statusline+=\ %f
set statusline+=%m
set statusline+=%r
set statusline+=%=
set statusline+=%y
set statusline+=\ %{&fileencoding!=''?&fileencoding:&encoding}
set statusline+=\ %l:%c
set statusline+=\ %p%%

" ------------------------------------------------------------
" Built-in explorer/search fallback
" ------------------------------------------------------------
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 28

let s:default_grepprg = &grepprg
let s:default_grepformat = &grepformat

if executable('rg')
  set grepprg=rg\ --vimgrep\ --hidden\ --glob\ '!.git/*'
  set grepformat=%f:%l:%c:%m
endif

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

function! s:OpenScratch(title, lines, filetype) abort
  botright new
  setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted
  setlocal modifiable
  silent %delete _
  call setline(1, empty(a:lines) ? ['No output.'] : a:lines)
  let &l:filetype = a:filetype
  execute 'file ' . fnameescape(a:title)
  setlocal nomodifiable readonly
  normal! gg
endfunction

function! s:WipeBuffer(bufnr) abort
  if a:bufnr > 0 && bufexists(a:bufnr)
    silent! execute 'bwipeout! ' . a:bufnr
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
" Markdown preview
" ------------------------------------------------------------
let s:markdown_preview = {
      \ 'bufnr': -1,
      \ 'source': ''
      \ }

function! s:ResetMarkdownPreview() abort
  let s:markdown_preview = {
        \ 'bufnr': -1,
        \ 'source': ''
        \ }
endfunction

function! s:RenderMarkdownPreview(filepath) abort
  if !executable('glow')
    echohl WarningMsg
    echom 'glow is not installed. Install glow to preview Markdown.'
    echohl None
    return
  endif

  let l:current_win = win_getid()
  let l:old_bufnr = s:markdown_preview.bufnr
  let l:old_win = bufwinid(l:old_bufnr)

  if l:old_win != -1
    call win_gotoid(l:old_win)
    enew
    call s:WipeBuffer(l:old_bufnr)
  else
    call s:WipeBuffer(l:old_bufnr)
    botright vertical new
    vertical resize 80
  endif

  setlocal nobuflisted bufhidden=wipe noswapfile
  execute 'terminal ' . s:ShellCommand(['glow', a:filepath])
  let s:markdown_preview = {
        \ 'bufnr': bufnr('%'),
        \ 'source': a:filepath
        \ }
  setlocal nobuflisted bufhidden=wipe noswapfile
  setlocal nonumber norelativenumber signcolumn=no
  setlocal nowrap
  silent! file [Markdown Preview]
  stopinsert

  call win_gotoid(l:current_win)
endfunction

function! s:ToggleMarkdownPreview() abort
  if !executable('glow')
    echohl WarningMsg
    echom 'glow is not installed. Install glow to preview Markdown.'
    echohl None
    return
  endif

  let l:filepath = expand('%:p')
  if empty(l:filepath) || !filereadable(l:filepath)
    echohl WarningMsg
    echom 'Open a readable file to preview it with glow.'
    echohl None
    return
  endif

  let l:preview_win = bufwinid(s:markdown_preview.bufnr)
  if l:preview_win != -1 && s:markdown_preview.source ==# l:filepath
    let l:preview_bufnr = s:markdown_preview.bufnr
    silent! call win_execute(l:preview_win, 'close')
    call s:WipeBuffer(l:preview_bufnr)
    call s:ResetMarkdownPreview()
    return
  endif

  call s:RenderMarkdownPreview(l:filepath)
endfunction

function! s:RefreshMarkdownPreview(filepath) abort
  if a:filepath ==# s:markdown_preview.source && bufwinid(s:markdown_preview.bufnr) != -1
    call s:RenderMarkdownPreview(a:filepath)
  endif
endfunction

augroup markdown_preview
  autocmd!
  autocmd BufWritePost *.md,*.markdown,*.mdx call <SID>RefreshMarkdownPreview(expand('<afile>:p'))
augroup END

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

  let l:start = empty(a:path) ? getcwd() : fnamemodify(a:path, ':p:h')
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

function! s:ConfigureProjectGrep() abort
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
  let l:file = fnamemodify(a:file, ':p')
  let l:root = fnamemodify(a:root, ':p')
  if stridx(l:file, l:root) ==# 0
    return strpart(l:file, strlen(l:root))
  endif
  return l:file
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
  copen
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

  let l:lines = s:SystemList(['git', '-C', l:root, 'status', '--short', '--branch'])
  if v:shell_error
    echohl WarningMsg
    echom 'git status failed.'
    echohl None
    return
  endif

  call s:OpenScratch('[Git Status]', l:lines, 'git')
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

  let l:lines = s:SystemList(['git', '-C', l:root, 'diff', '--', l:relfile])
  if v:shell_error
    echohl WarningMsg
    echom 'git diff failed.'
    echohl None
    return
  endif
  if empty(l:lines)
    let l:lines = ['No git diff for ' . fnamemodify(l:file, ':.')]
  endif

  call s:OpenScratch('[Git Diff] ' . fnamemodify(l:file, ':t'), l:lines, 'diff')
endfunction

" ------------------------------------------------------------
" Commands
" ------------------------------------------------------------
command! -nargs=* GitGrep call <SID>GitGrep(<q-args>)
command! -nargs=0 GitReplace call <SID>GitReplace()
command! -nargs=0 GitStatus call <SID>GitStatus()
command! -nargs=0 GitBlame call <SID>GitBlame()
command! -nargs=0 GitDiff call <SID>GitDiff()
command! -nargs=0 MarkdownPreview call <SID>ToggleMarkdownPreview()

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
  nnoremap <silent> <leader>co :call <SID>CocActionAsync('runCommand', 'editor.action.organizeImport')<CR>
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

" ------------------------------------------------------------
" Keymaps
" ------------------------------------------------------------
nnoremap <silent> <leader>w :write<CR>
nnoremap <silent> <leader>q :confirm quit<CR>
nnoremap <silent> <leader>Q :confirm qall<CR>
nnoremap <silent> <leader>nh :nohlsearch<CR>

nnoremap <silent> <leader>e :Lexplore<CR>
nnoremap <leader>fw :call <SID>ConfigureProjectGrep()<CR>:grep 
nnoremap <silent> <leader>fG :GitGrep<CR>
nnoremap <leader>ff :find 

nnoremap <leader>sr :%s///gc<Left><Left><Left><Left>
nnoremap <leader>sw :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
nnoremap <silent> <leader>sG :GitReplace<CR>
xnoremap <leader>sr :s///gc<Left><Left><Left><Left>

nnoremap <silent> <leader>gg :GitStatus<CR>
nnoremap <silent> <leader>gb :GitBlame<CR>
nnoremap <silent> <leader>gd :GitDiff<CR>

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> <leader>bn :bnext<CR>
nnoremap <silent> <leader>bp :bprevious<CR>
nnoremap <silent> <leader>bd :confirm bdelete<CR>
nnoremap <silent> <leader>bo :call <SID>DeleteOtherBuffers()<CR>

if has('terminal')
  nnoremap <silent> <leader>ot :terminal<CR>
  nnoremap <silent> <leader>om :MarkdownPreview<CR>
  tnoremap <Esc><Esc> <C-\><C-n>
endif
