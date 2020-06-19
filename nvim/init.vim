" Encoding and fileformat
set encoding=UTF-8
set fileencoding=utf8
set fileformats=unix,mac
set fileformat=unix
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" tab widtv
set tabstop=4
set shiftwidth=4
" improve default search
set incsearch
set hlsearch
nnoremap <esc><esc> :silent! nohls<cr>
set ignorecase
" cursor
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"
" visible chars
" set listchars=eol:¬,tab:>–,trail:~,extends:>,precedes:<,space:␣
set listchars=tab:>–,trail:~,extends:>,precedes:<
set list
" persistent undo
set undodir=~/.vim/undodir
set undofile
" horizontal scroll
set sidescroll=1
" make 'y' and 'p' works with system clipboard
set clipboard+=unnamed
" relative line numbers
set relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
" hotkey to edit .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" buffers switching
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
" switch to previous buffer, then delete last buffer
nnoremap <c-q> :bp\|bd #<CR> 
" show line numbers
set number
" highlight cursor line
set cursorline
hi CursorLine cterm=NONE ctermbg=darkblue ctermfg=white guibg=darkblue ctermfg=white

" move line bindings
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Moving through camel case words
nnoremap <C-Left> :call search('\<\<Bar>\u', 'bW')<CR>
nnoremap <C-Right> :call search('\<\<Bar>\u', 'W')<CR>
inoremap <C-Left> <C-o>:call search('\<\<Bar>\u', 'bW')<CR>
inoremap <C-Right> <C-o>:call search('\<\<Bar>\u', 'W')<CR>

" set iterm tab title to current buffer filename
set t_ts=]1
set t_fs=
set title titlestring=[%{expand(\"%:p\")} 

" ================ PLUGINS ================
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" programming plugins
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" common plugins
" Plug 'sheerun/vim-polyglot' " common ext syntax highlight #TODO conflicts
" with vim-go
Plug 'townk/vim-autoclose'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/committia.vim'
Plug 'scrooloose/nerdtree' 
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons' " requires nerd-fonts
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'chiel92/vim-autoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline' " airline status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'liuchengxu/space-vim-theme'
Plug 'morhetz/gruvbox'
Plug 'liuchengxu/vista.vim'
Plug 'ap/vim-buftabline' 
Plug 'wincent/terminus'
Plug 'vim-scripts/dbext.vim'
" search
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
Plug 'junegunn/fzf.vim'
Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'yuki-ycino/fzf-preview.vim'
" golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

" ======= vista.vim =======
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

let g:vista_fzf_preview = ['right:50%']

nnoremap <C-t> :Vista finder<cr>
" ======= vim-go settings ======
" syntax highlight
let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 0
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
" use guru to def and info
let g:go_def_mode="guru"
let g:go_info_mode="guru"
let g:go_gorename_command = 'gopls'

" autocmd BufRead /Users/icheremushkin/go/src/*.go
        " \  let s:tmp = matchlist(expand('%:p'),
            " \ '/Users/icheremushkin/go/src/\(gitlab.ozon.ru/[^/]\+\)')
        " \| if len(s:tmp) > 1 |  exe ':GoGuruScope ' . s:tmp[1] | endif
        " \| unlet s:tmp

let g:go_fmt_command="goimports"
" gocode completion
let g:go_gocode_propose_source = 1
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
" type info in status bar
let g:go_auto_type_info = 0
nnoremap <leader>gi :GoInfo<cr>
nnoremap <leader>fs :GoFillStruct<cr>
" highlight symbol under cursor and it's usages
autocmd CursorHold * silent call CocActionAsync('highlight')

" ========= FZF settings =========
let g:fzf_preview_use_floating_window = 1
let g:fzf_preview_floating_window_rate = 0.8
let g:fzf_preview_command = 'bat --color=always --style=grid {-1}'
let g:fzf_buffers_jump = 1

nnoremap <C-p> :FzfPreviewProjectFiles<cr>
nnoremap <C-o> :FzfPreviewProjectCommandGrep<cr>

" =============== color scheme settings ================
set background=dark
set termguicolors " use terminal colors
syntax enable
" colorscheme space_vim_theme
autocmd vimenter * colorscheme gruvbox

" buftabline colors
hi! link BufTabLineFill NonText
hi! link BufTabLineActive Pmenu
hi! link BufTabLineCurrent WildMenu
hi! link BufTabLineHidden Normal
" ===================== others =========================
" golang syntax provided by vim-go
let g:polyglot_disabled = ['go', 'golang']
" vim-airline status bar theme
" let g:airline_theme='gruvbox'
" json comments
autocmd FileType json syntax match Comment +\/\/.\+$+
" nerdcommenter add 1 space after comment delimiters by default
let g:NERDSpaceDelims = 1
" turn on mouse support
set mouse=a
" Russian langmap for standard PC keyboard
if has('langmap')
	set langmap=йцукенгшщзхъ;qwertyuiop[]
	set langmap+=фывапролджэё;asdfghjkl\\;'\\\
	set langmap+=ячсмитьбю;zxcvbnm\\,.
	set langmap+=ЙЦУКЕНГШЩЗХЪ;QWERTYUIOP{}
	set langmap+=ФЫВАПРОЛДЖЭЁ;ASDFGHJKL\\:\\"\\~
	set langmap+=ЯЧСМИТЬБЮ;ZXCVBNM<>
	set langmap+=№#
	if exists('+langremap')
		set nolangremap
	endif
endif
" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" ============= golang specified settings =============
" Clear filetype flags before changing runtimepath to force Vim to reload them.
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on
syntax on

" ============ COC completion framework and language server ==============
" if hidden is not set, TextEdit might fail.
set hidden
" Some servers have issues with backup files, see #649
" set nobackup
" set nowritebackup
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
autocmd VimEnter verbose imap <tab>
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)

nmap <silent> gi :GoImplements<CR>

nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" ================ nerdtree ================
" autostart
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter NERD_tree_1 enew | execute 'NERDTree '.argv()[0]
" open without nerdtree for git commit
if !exists('g:gui_oni')
    autocmd VimEnter * if &filetype !=# 'gitcommit' | NERDTree | wincmd w | endif
endif

" replace arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden=1
" close vim if the only window left open is a NERDTree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Ctrl+n to open NERDTree
map <C-n> :NERDTreeToggle<CR>
" Automatically delete the buffer of the file deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeChDirMode = 2
" reval current file
map <leader>r :NERDTreeFind<cr>

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

let NERDTreeHijackNetrw=1

" =============== Syntastic ================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" ============ tagbar ==================
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_go = {  
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" ============ easymotion ==============
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

"================ gitgutter =================
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
highlight GitGutterAdd    guifg=#009900 guibg=#282a2e ctermfg=2 ctermbg=0
highlight GitGutterChange guifg=#bbbb00 guibg=#282a2e ctermfg=3 ctermbg=0
highlight GitGutterDelete guifg=#ff2222 guibg=#282a2e ctermfg=1 ctermbg=0

"================ dbext =====================
let g:dbext_default_profile_PG = 'type=PGSQL:user=postgres:passwd=:host=localhost:port=5432:dbname=memes'
let g:dbext_default_profile='PG'

