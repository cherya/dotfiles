local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- Clean search results highlights
keymap('n', '<esc><esc>', ':nohlsearch<CR>', default_opts)

-- Edit and reload init.lua
keymap('n', '<leader>ev', ":vsplit $MYVIMRC<CR>", default_opts)
keymap('n', '<leader>sv',
          ":lua require'plenary.reload'.reload_module('init.lua')<CR>", default_opts)

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- buffers switching
keymap('n', '<Tab>', ':bnext<CR>', default_opts)
keymap('n', '<S-Tab>', ':bprevious<CR>', default_opts)

-- source tree toggle
keymap('n', '<C-n>', '<cmd>NvimTreeFindFileToggle<cr>', default_opts)

-- Y yank until the end of line  (note: this is now a default on master)
keymap('n', 'Y', 'y$', default_opts)

-- tab and shift+tab for selection
keymap('v', '<Tab>', '>gv', default_opts)
keymap('v', '<S-Tab>', '<gv', default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<Up>", ":resize -1<CR>", default_opts)
keymap("n", "<Down>", ":resize +1<CR>", default_opts)

