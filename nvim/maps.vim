" to make gui cmd+v works
nnoremap <D-v> "+p
" leader
let mapleader = "'"
" tab and shift+tab for selection
vmap <Tab> >gv
vmap <S-Tab> <gv

" esc to remove search highlight
nnoremap <esc><esc> :silent! nohls<cr>
" hotkey to edit and save .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" buffers switching
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
" Moving through camel case words
nnoremap <C-h> :call search('\<\<Bar>\u', 'bW')<CR>
nnoremap <C-l> :call search('\<\<Bar>\u', 'W')<CR>
inoremap <C-h> <C-o>:call search('\<\<Bar>\u', 'bW')<CR>
inoremap <C-l> <C-o>:call search('\<\<Bar>\u', 'W')<CR>

" nvim-telescope/telescope.nvim
nnoremap <silent> <leader>fp :Telescope project<CR>

" s{char}{char} to move to {char}{char}
nnoremap s <cmd>lua require'hop'.hint_char2()<cr>
" Move to line
nmap <Leader>L <cmd>lua require'hop'.hint_lines()<cr>

" Move to word
map  <Leader>w <cmd>lua require'hop'.hint_words()<cr>
nmap <Leader>w <cmd>lua require'hop'.hint_words()<cr>

" scrooloose/nerdcommenter
vnoremap <Leader>c<space> <Plug>(NERDCommenterToggle)

:tnoremap <Esc> <C-\><C-n>

if exists('g:gonvim_running')
  set laststatus=0
  nnoremap ;[ :GonvimWorkspacePrevious<CR>
  nnoremap ;] :GonvimWorkspaceNext<CR>
  nnoremap <leader>N :GonvimWorkspaceNew<CR>
  nnoremap <silent> \\ :GonvimFuzzyBuffers<cr>
  nnoremap <silent> ;f :GonvimFuzzyFiles<cr>
  nnoremap <silent> ;r :GonvimFuzzyAg<cr>
else
  nnoremap <silent> ;f <cmd>Telescope find_files hidden=true<cr>
  nnoremap <silent> ;g <cmd>Telescope git_files<cr>
  nnoremap <silent> \\ <cmd>Telescope buffers<cr>
  nnoremap <silent> ;r <cmd>Telescope live_grep<cr>
endif

nnoremap <silent> ;; <cmd>Telescope help_tags<cr>

" source tree toggle
nnoremap <C-n> <cmd>CHADopen<cr>

lua << EOF
local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {border = "double"},
    -- function to run on opening the terminal
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>",
                                    {noremap = true, silent = true})
    end
})

function _lazygit_toggle() lazygit:toggle() end

vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>",
                        {noremap = true, silent = true})

function _G.set_terminal_keymaps()
    local opts = {noremap = true}
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
EOF
