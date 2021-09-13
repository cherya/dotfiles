" Fundamentals
autocmd!
" set script encoding
scriptencoding utf-8
" encoding and fileformat
set encoding=UTF-8
set fileencoding=utf8
set fileformats=unix,mac
set fileformat=unix
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"font
set guifont=JetBrainsMono\ Nerd\ Font:h15
" tab widtv
set tabstop=4
set shiftwidth=4
" improve default search
set incsearch
set hlsearch
set ignorecase
" cursor mode
"  1 -> blinking block
"  2 -> solid block 
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar
let &t_SI = "\e[5 q" "SI = INSERT mode
let &t_EI = "\e[2 q" "EI = NORMAL mode
let &t_SR = "\e[4 q" "SR = REPLACE mode

" visible trailing tabs and spaces
set list
set listchars=tab:>–,trail:~,extends:>,precedes:<

" persistent undo
set undodir=~/.vim/undodir
set undofile

" make 'y' and 'p' works with system clipboard
set clipboard+=unnamed

" show line numbers and relative line numbers
set number
set relativenumber
" highlight cursor line
set cursorline
set hidden

" highlight cursor line
hi CursorLine cterm=NONE ctermbg=darkblue ctermfg=white guibg=darkblue ctermfg=white

" turn on mouse support
set mouse=a
" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" Imports "{{{
" ---------------------------------------------------------------------
runtime ./plug.vim
runtime ./maps.vim
"}}}

" =============== color scheme settings ================
set background=dark
set termguicolors " use terminal colors
syntax enable
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_palette = 'mix'
colorscheme gruvbox-material

" buftabline colors
hi! link BufTabLineFill NonText
hi! link BufTabLineActive Pmenu
hi! link BufTabLineCurrent WildMenu
hi! link BufTabLineHidden Normal

" autocmd VimEnter * Dashboard
" hotkeys helper
" format on save
augroup fmt
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END

" startify
" Fancy custom header
let g:startify_custom_header = [
  \ "  ",
  \ '   ╻ ╻   ╻   ┏┳┓',
  \ '   ┃┏┛   ┃   ┃┃┃',
  \ '   ┗┛    ╹   ╹ ╹',
  \ '   ',
  \ ]

let g:startify_lists = [
  \ { 'type': 'files',     'header': ['   MRU']            },
  \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
  \ { 'type': 'sessions',  'header': ['   Sessions']       },
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
  \ { 'type': 'commands',  'header': ['   Commands']       },
  \ ]

let g:startify_files_number = 3
let g:startify_update_oldfiles = 1
let g:startify_session_autoload = 1
let g:startify_session_before_save = [ 'silent! tabdo NvimTreeClose' ]
let g:startify_session_persistence = 1
let g:startify_change_to_vcs_root = 1
let g:startify_enable_special = 0

function! GetUniqueSessionName()
  let path = fnamemodify(getcwd(), ':~:t')
  let path = empty(path) ? 'no-project' : path
  let branch = gitbranch#name()
  let branch = empty(branch) ? '' : '-' . branch
  return substitute(path . branch, '/', '-', 'g')
endfunction

function! SaveSession()
  let session_name = GetUniqueSessionName()
  if session_name != ""
    execute 'SSave! ' . GetUniqueSessionName()
  endif
endfunction

autocmd VimLeavePre * silent call SaveSession()

function! ToggleVerbose()
    if !&verbose
        set verbosefile=~/.log/vim/verbose.log
        set verbose=15
    else
        set verbose=0
        set verbosefile=
    endif
endfunction
