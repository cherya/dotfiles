" ================ PLUGINS ================
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" programming plugins
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'RRethy/vim-illuminate' " highlight word under cursor (with lsp integration)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'
Plug 'vim-test/vim-test'
Plug 'folke/trouble.nvim'
Plug 'ray-x/go.nvim'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'} " autocompletion
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'} " 9000+ Snippets
" Plug 'mfussenegger/nvim-lint' linter -- broken, should work on nvim 0.5.1
" debug
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
" git
Plug 'tpope/vim-fugitive' " git integration
Plug 'tpope/vim-rhubarb' " fugitive :Gbrowser provider for github
Plug 'airblade/vim-gitgutter'
" common plugins
Plug 'nvim-lua/plenary.nvim' " lua nvim helpers
Plug 'nvim-lua/popup.nvim' " lua nvim popup helpers
Plug 'unblevable/quick-scope' " letters highlight for f F t T
Plug 'airblade/vim-rooter' " auto switch cwd for projects
Plug 'mhinz/vim-startify' " vim start screen
Plug 'cohama/lexima.vim' "auto brackets
Plug 'folke/which-key.nvim' " hotkeys helper
Plug 'phaazon/hop.nvim' " easy motion
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'} " source tree
Plug 'hoob3rt/lualine.nvim' "bottom info-line
Plug 'kyazdani42/nvim-web-devicons' " requires nerd-fonts
Plug 'marklcrns/vim-smartq' " smart buffer close on 'q'
Plug 'stsewd/gx-extended.vim' " url opener
Plug 'scrooloose/nerdcommenter' " easy comment multiple lines
Plug 'romgrk/barbar.nvim' " buffers as tabs
Plug 'lukas-reineke/format.nvim'
Plug 'akinsho/toggleterm.nvim' " persistent terminals
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'gennaro-tedesco/nvim-peekup' " yank peeker
" search
Plug 'nvim-telescope/telescope.nvim'
Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-asterisk'
" color theme
Plug 'sainnhe/gruvbox-material' " theme
" gonvimm
" Plug 'akiyosi/gonvim-fuzzy'
call plug#end()

" airblade/vim-gitgutter
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
highlight GitGutterAdd    guifg=#009900 guibg=#282a2e ctermfg=2 ctermbg=0
highlight GitGutterChange guifg=#bbbb00 guibg=#282a2e ctermfg=3 ctermbg=0
highlight GitGutterDelete guifg=#ff2222 guibg=#282a2e ctermfg=1 ctermbg=0

" scrooloose/nerdcommenter
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1

" wilder
call wilder#setup({'modes': [':', '/', '?']})
call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline({
      \       'fuzzy': 1,
      \       'set_pcre2_pattern': has('nvim'),
      \     }),
      \     wilder#python_search_pipeline({
      \       'pattern': 'fuzzy',
      \     }),
      \   ),
      \ ])
let s:highlighters = [
        \ wilder#pcre2_highlighter(),
        \ wilder#basic_highlighter(),
        \ ]
call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \   'highlighter': s:highlighters,
      \   'highlights': {
      \     'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
      \   },
      \ })
      \ )

lua << EOF
require("which-key").setup({})
require("trouble").setup({})
require("dapui").setup({})
vim.g.dap_virtual_text = true

local chadtree_settings = {
    options = {show_hidden = true},
    view = {width = 35},
    theme = {text_colour_set = "nerdtree_syntax_dark"}
}
vim.api.nvim_set_var("chadtree_settings", chadtree_settings)

require'go'.setup({
    goimport = 'gopls', -- if set to 'gopls' will use golsp format
    gofmt = 'gopls', -- if set to gopls will use golsp format
    max_line_line = 120,
    tag_transform = false,
    test_dir = '',
    comment_placeholder = '   ',
    lsp_cfg = false, -- false: use your own lspconfig
    lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
    lsp_on_attach = false, -- use on_attach from go.nvim
    dap_debug = true
})

vim.g.coq_settings = {auto_start = true, clients = {tabnine = {enabled = true}}}
require'hop'.setup()

require("toggleterm").setup {
    -- size can be a number or function which is passed the current terminal
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    direction = 'horizontal',
    close_on_exit = true -- close the terminal window when the process exits
    -- shell = vim.o.shell, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
}

require"format".setup {
    ["*"] = {
        {cmd = {"sed -i 's/[ \t]*$//'"}} -- remove trailing whitespace
    },
    vim = {
        {
            cmd = {"lua-format -i"},
            start_pattern = "^lua << EOF$",
            end_pattern = "^EOF$"
        }
    },
    lua = {{cmd = {"lua-format -i"}}},
    go = {{cmd = {"gofmt -w", "goimports -w"}, tempfile_postfix = ".tmp"}},
    javascript = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}}
}
EOF

" airblade/vim-rooter
let g:rooter_patterns = ['.git', 'Makefile', 'init.vim']

" dadbod
let g:db_async = 1

" bufbuf
let bufferline = get(g:, 'bufferline', {})
let bufferline.add_in_buffer_number_order = v:false
