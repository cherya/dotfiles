local api = vim.api
local g = vim.g
local opt = vim.opt

-- Remap ' as leader key
api.nvim_set_keymap('', '\'', '<Nop>', { noremap = true, silent = true })
g.mapleader = '\''
g.maplocalleader = '\''

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.mouse = "a" --Enable mouse mode
opt.breakindent = true --Enable break indent
opt.undofile = true --Save undo history
vim.undodir = '~/.vim/undodir'
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true --Smart case
opt.updatetime = 250 --Decrease update time
opt.signcolumn = "yes" --Always show sign column
opt.clipboard = "unnamedplus" --Access system clipboard
opt.timeoutlen = 300	--Time in milliseconds to wait for a mapped sequence to complete.
opt.tabstop = 4 -- tabs size
opt.shiftwidth = 4 -- tabs size
opt.cursorline = true -- Highlight cursor line
opt.completeopt = 'menuone,noselect' --Set completeopt to have a better completion experience

-- display hidden symbols
opt.list = true
opt.listchars:append("space:⋅")
opt.listchars:append("tab:>–")
opt.listchars:append("trail:~")
opt.listchars:append("extends:>")
opt.listchars:append("precedes:<")

-- WTF
g.loaded_netrwPlugin = 1
g.loaded_netrw = 1

