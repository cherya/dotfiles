" Encoding and fileformat
set encoding=UTF-8
set fileencoding=utf8
set fileformats=unix,mac
set fileformat=unix

" cursor
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"

" visible chars
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set list

" hotkey to edit .vimrc
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" line numbers
set number

" ================ PLUGINS ================
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" common plugins
Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree' 
Plug 'ryanoasis/vim-devicons' " requires nerd-fonts
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " search
Plug 'junegunn/fzf.vim'
Plug 'skielbasa/vim-material-monokai' " color scheme
Plug 'sheerun/vim-polyglot' " common ext syntax highlight
Plug 'vim-airline/vim-airline' " airline status bar
Plug 'vim-airline/vim-airline-themes'
" golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'stamblerre/gocode', { 'rtp': 'vim/', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
" programming plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" ======= vim-go settings ======
" syntax highlight
let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
" use guru to def and info
let g:go_def_mode='guru'
let g:go_info_mode='guru'
" gocode completion
let g:go_gocode_propose_source = 1
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 1
" highlight symbol under cursor and it's usages
autocmd CursorHold * silent call CocActionAsync('highlight')

" ========= Fuzzy file finder settings =========
" shift+p to run Ag
nnoremap <s-p> :Ag<cr>
" ctrl+p to run FZF
nnoremap <C-p> :call Fzf_dev()<cr>

augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END
" Enable per-command history.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Dev Icons and file preview for FZF
" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

" Files + devicons
function! Fzf_dev()
  let l:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {2..-1} | head -'.&lines.'"'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '40%' })
endfunction

"Ag command 
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

" ================ nerdtree ================
" autostart
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter NERD_tree_1 enew | execute 'NERDTree '.argv()[0]
" replace arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Ctrl+n to open NERDTree
map <C-n> :NERDTreeToggle<CR>

let g:NERDTreeChDirMode = 2

" =============== color scheme settings ================
set background=dark
set termguicolors " use terminal colors
colorscheme material-monokai

" ===================== others =========================
" golang syntax provided by vim-go  
let g:polyglot_disabled = ['golang']
" vim-airline status bar theme
let g:airline_theme='fruit_punch'
" json comments
autocmd FileType json syntax match Comment +\/\/.\+$+
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

