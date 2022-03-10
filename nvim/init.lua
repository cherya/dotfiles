-- Install packer
local install_path = vim.fn.stdpath 'data' ..
                         '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                       install_path)
end

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)

vim.api.nvim_exec([[
	command -nargs=1 Browse silent exe '!open ' . "<args>"
]], false)

vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

local use = require('packer').use
require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- package manager
    use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
    use 'ludovicchabant/vim-gutentags' -- automatic tags management
    use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}} -- ui to select things (files, grep results, open buffers...)
    use {
        'TC72/telescope-tele-tabby.nvim',
        requires = {'nvim-telescope/telescope.nvim'}
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    } -- fancier statusline
    use 'sainnhe/gruvbox-material' -- theme
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}} -- add git related info in the signs columns and popups}
    use 'nvim-treesitter/nvim-treesitter' -- highlight, edit, and navigate code using a fast incremental parsing library
    use 'nvim-treesitter/nvim-treesitter-textobjects' -- additional textobjects for treesitter
    use 'neovim/nvim-lspconfig' -- collection of configurations for built-in lsp client
    use {
        'j-hui/fidget.nvim',
        config = function() require("fidget").setup {} end
    }
    use {'ms-jpq/coq_nvim', branch = 'coq'} -- fast as fuck autocompletion plugin
    use {'ms-jpq/coq.artifacts', branch = 'artifacts'} -- 9000+ snippets
    use 'p00f/nvim-ts-rainbow' -- rainbow brackets
    use 'vim-test/vim-test' -- tests runner
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                auto_open = true,
                auto_close = true,
                auto_preview = true,
                icons = true,
                signs = {
                    -- icons / text used for a diagnostic
                    error = "",
                    warning = "",
                    hint = "",
                    information = "",
                    other = "﫠"
                }
            }
        end
    }
    use 'ray-x/go.nvim' -- golang
    use 'unblevable/quick-scope' -- letters highlight for f f t t
    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}
    use 'marklcrns/vim-smartq' -- smart buffer close on 'q'
    use 'stsewd/gx-extended.vim' -- url opener
    use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
    use 'lukas-reineke/format.nvim'
    use 'akinsho/toggleterm.nvim' -- persistent terminals
    use 'gelguy/wilder.nvim'
    use 'gennaro-tedesco/nvim-peekup' -- yank peeker
    use 'haya14busa/is.vim'
    use 'tjdevries/nlua.nvim'
    use 'rrethy/vim-illuminate' -- highlight word under cursor (with lsp integration)
    use 'ray-x/lsp_signature.nvim' -- functions singature when typing
    use 'phaazon/hop.nvim' -- easy motion
    use {'mhinz/vim-startify', requires = 'itchyny/vim-gitbranch'} -- vim start screen
    use 'tpope/vim-fugitive' -- git integration
    use 'tpope/vim-rhubarb' -- GBrowse provider
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'thehamsta/nvim-dap-virtual-text'
    use 'folke/which-key.nvim' -- hotkeys helper
    use {
        'mfussenegger/nvim-lint',
        config = function()
            require("trouble").setup {go = 'golangcilint'}
        end
    }
end)

local utils = require('utils')

-- tabs size
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Highlight cursor line
vim.o.cursorline = true
-- Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

-- Make 'y' and 'p' work with system clipboard
vim.o.clipboard = vim.o.clipboard .. 'unnamed'

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers and relative numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.opt.undofile = true
vim.undodir = '~/.vim/undodir'

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_palette = 'mix'
vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
vim.g.gruvbox_material_diagnostic_text_highlight = '1'
vim.g.gruvbox_material_diagnostic_line_highlight = '1'
vim.cmd [[colorscheme gruvbox-material]]

-- Set statusline
local lualine = require('lualine')

-- Config
local config = {
    options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        theme = 'gruvbox-material'
    }
}
-- Now don't forget to initialize lualine
lualine.setup(config)

-- Remap ' as leader key
utils.map('', '\'', '<Nop>')
vim.g.mapleader = '\''
vim.g.maplocalleader = '\''

-- Clean search results highlights
utils.map('n', '<esc><esc>', ':nohlsearch<CR>')

-- Edit and reload init.lua
utils.map('n', '<leader>ev', ":vsplit $MYVIMRC<CR>")
utils.map('n', '<leader>sv',
          ":lua require'plenary.reload'.reload_module('init.lua')<CR>")

-- Remap for dealing with word wrap
utils.map('n', 'k', "v:count == 0 ? 'gk' : 'k'", {expr = true})
utils.map('n', 'j', "v:count == 0 ? 'gj' : 'j'", {expr = true})

-- buffers switching
utils.map('n', '<Tab>', ':bnext<CR>')
utils.map('n', '<S-Tab>', ':bprevious<CR>')

-- source tree toggle
utils.map('n', '<C-n>', '<cmd>NvimTreeFindFileToggle<cr>')

-- Highlight on yank
vim.api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)

-- Y yank until the end of line  (note: this is now a default on master)
utils.map('n', 'Y', 'y$', {noremap = true})

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("tab:>–")
vim.opt.listchars:append("trail:~")
vim.opt.listchars:append("extends:>")
vim.opt.listchars:append("precedes:<")

-- Hop easy motion
require'hop'.setup()
-- s{char}{char} to move to {char}{char}
utils.map('n', 's', '<cmd>lua require"hop".hint_char2()<cr>')
-- Move to line
utils.map('n', '<leader>L', ':lua require"hop".hint_lines()<CR>')
-- Move to word
utils.map('n', ';w', ':lua require"hop".hint_words()<CR>')

-- format
require("lsp-format").setup {
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
    javascript = {{cmd = {"prettier -w", "./node_modules/.bin/esint --fix"}}}
}
-- format on write
vim.api.nvim_exec(
    [[ augroup Format autocmd! autocmd BufWritePost * FormatWrite augroup END ]],
    false)

-- COQ
vim.g.coq_settings = {auto_start = true, clients = {tabnine = {enabled = true}}}

-- startify
vim.g.startify_custom_header = {
    '  ', '   ╻ ╻   ╻   ┏┳┓', '   ┃┏┛   ┃   ┃┃┃',
    '   ┗┛    ╹   ╹ ╹', '   '
}

vim.g.startify_lists = {
    {type = 'files', header = {'   MRU'}},
    {type = 'dir', header = {'   MRU ' .. vim.fn.getcwd()}},
    {type = 'sessions', header = {'   Sessions'}},
    {type = 'bookmarks', header = {'   Bookmarks'}},
    {type = 'commands', header = {'   Commands'}}
}

vim.g.startify_files_number = 5
vim.g.startify_update_oldfiles = 1
vim.g.startify_session_autoload = 1
vim.g.startify_session_before_save = {'silent! tabdo NvimTreeClose'}
vim.g.startify_session_persistence = 1
vim.g.startify_change_to_vcs_root = 1
vim.g.startify_enable_special = 0

-- vim.api.nvim_exec(
-- 	[[
-- 	function! GetUniqueSessionName()
-- 		let path = fnamemodify(getcwd(), ':~:t')
-- 		let path = empty(path) ? 'no-project' : path
-- 		let branch = gitbranch#name()
-- 		let branch = empty(branch) ? '' : '-' . branch
-- 		return substitute(path . branch, '/', '-', 'g')
-- 	endfunction
-- 	autocmd User        StartifyReady silent execute 'SLoad '  . GetUniqueSessionName()
-- 	autocmd VimLeavePre *             silent execute 'SSave! ' . GetUniqueSessionName()
-- ]], true)

-- nvim-tree
require('nvim-tree').setup {}

-- which-key
require("which-key").setup({})

-- Bufferline
require('bufferline').setup {
    options = {
        numbers = "ordinal",
        close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            return "(" .. count .. ")"
        end,
        offsets = {{filetype = "NvimTree", text = "File Explorer"}},
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        separator_style = "thick",
        sort_by = 'id'
    }
}

-- tab and shift+tab for selection
utils.map('v', '<Tab>', '>gv')
utils.map('v', '<S-Tab>', '<gv')

-- Gitsigns
require('gitsigns').setup {
    signs = {
        add = {hl = 'GitGutterAdd', text = '+'},
        change = {hl = 'GitGutterChange', text = '~'},
        delete = {hl = 'GitGutterDelete', text = '_'},
        topdelete = {hl = 'GitGutterDelete', text = '‾'},
        changedelete = {hl = 'GitGutterChange', text = '~'}
    },
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000
    },
    current_line_blame_formatter_opts = {relative_time = true}
}

-- Telescope
local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        mappings = {
            i = {['<C-u>'] = false, ['<C-d>'] = false},
            n = {["q"] = actions.close}
        }
    }
}
-- Add leader shortcuts
utils.map('n', '<leader><space>',
          [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
utils.map('n', ';f',
          [[<cmd>lua require('telescope.builtin').find_files({previewer = false, hidden = true})<CR>]])
utils.map('n', ';g',
          [[<cmd>lua require('telescope.builtin').git_files({previewer = false })<CR>]])
utils.map('n', '<leader>sb',
          [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]])
utils.map('n', '<leader>sh',
          [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])
utils.map('n', '<leader>st',
          [[<cmd>lua require('telescope.builtin').tags()<CR>]])
utils.map('n', '<leader>sd',
          [[<cmd>lua require('telescope.builtin').grep_string()<CR>]])
utils.map('n', ';r', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
utils.map('n', '<leader>so',
          [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]])
utils.map('n', '<leader>?',
          [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true -- false will disable the whole extension
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm'
        }
    },
    indent = {enable = true},
    rainbow = {enable = true},
    ensure_installed = {
        "tsx", "javascript", "go", "python", "toml", "json", "yaml", "html",
        "scss", "css", "bash"
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner'
            }
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer'
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer'
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer'
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer'
            }
        }
    }
}

local parser_config = require"nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.used_by = {"javascript", "typescript.tsx"}

-- LSP settings
local nvim_lsp = require('lspconfig')
local protocol = require 'vim.lsp.protocol'

local signs = {Error = " ", Warn = " ", Hint = " ", Info = " "}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = ""})
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.lsp.set_log_level("debug")
    -- Mappings.
    local opts = {noremap = true, silent = true}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
    buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                   opts)
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<leader>D',
                   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
                   opts)
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    -- buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    -- buf_set_keymap('n', '<S-C-j>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap('n', '<leader>f',
                       '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap('n', '<leader>f',
                       '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end

    -- formatting
    require "lsp-format".on_attach(client)
	require "illuminate".on_attach(client)
    require "lsp_signature".on_attach({
        bind = true,
        handler_opts = {border = "single"}
    })

    -- protocol.SymbolKind = { }
    protocol.CompletionItemKind = {
        '', -- Text
        '', -- Method
        '', -- Function
        '', -- Constructor
        '', -- Field
        '', -- Variable
        '', -- Class
        'ﰮ', -- Interface
        '', -- Module
        '', -- Property
        '', -- Unit
        '', -- Value
        '', -- Enum
        '', -- Keyword
        '﬌', -- Snippet
        '', -- Color
        '', -- File
        '', -- Reference
        '', -- Folder
        '', -- EnumMember
        '', -- Constant
        '', -- Struct
        '', -- Event
        'ﬦ', -- Operator
        '' -- TypeParameter
    }
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {'documentation', 'detail', 'additionalTextEdits'}
}

local coq = require "coq"
local servers = {'pyright', 'gopls', 'tsserver'}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities({
        on_attach = on_attach,
        capabilities = capabilities
    }))
end

USER = vim.fn.expand('$USER')

local sumneko_root_path = ""
local sumneko_binary = ""

if vim.fn.has("mac") == 1 then
    sumneko_root_path = "/Users/" .. USER .. "/.config/nvim/lua-language-server"
    sumneko_binary = "/Users/" .. USER ..
                         "/.config/nvim/lua-language-server/bin/macOS/lua-language-server"
elseif vim.fn.has("unix") == 1 then
    sumneko_root_path = "/home/" .. USER .. "/.config/nvim/lua-language-server"
    sumneko_binary = "/home/" .. USER ..
                         "/.config/nvim/lua-language-server/bin/Linux/lua-language-server"
else
    print("Unsupported system for sumneko")
end

nvim_lsp.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                }
            }
        }
    }
}

require'nvim-dap-virtual-text'.setup()

-- diagnostics virtual text icon
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = {spacing = 4, prefix = ''}
    })

-- golang
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
    dap_debug = true,
    icons = {breakpoint = '🧘', currentpos = '🏃'},
    dap_debug_keymap = true, -- set keymaps for debugger
    dap_debug_gui = true, -- set to true to enable dap gui, highly recommand
    dap_debug_vt = true -- set to true to enable dap virtual text
})
-- format on save
vim.cmd("autocmd FileType go nmap <Leader><Leader>l :GoLint")

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

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

function Lazygit_toggle() lazygit:toggle() end

utils.map('n', '<leader>lg', '<cmd>lua Lazygit_toggle()<CR>')

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

