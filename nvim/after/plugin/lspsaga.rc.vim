if !exists('g:loaded_lspsaga') | finish | endif

lua << EOF
local saga = require 'lspsaga'

saga.init_lsp_saga {
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = '',
    border_style = "none",
    max_preview_lines = 20
}

EOF

nnoremap <silent> <C-j> <Cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent>K <Cmd>Lspsaga hover_doc<CR>
inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>
nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>
nnoremap <silent><leader>rn :Lspsaga rename<CR>
nnoremap <silent> ;d :Lspsaga preview_definition<CR>

nnoremap <silent><leader>ca <cmd> Lspsaga code_action<CR>

tnoremap <silent> <C-\> <Cmd>:Lspsaga close_floaterm<CR>

" scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" scroll up hover doc
nnoremap <silent> <C-k> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
