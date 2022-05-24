require("plugins").setup()
require("config.colorthemes").setup()

vim.api.nvim_exec([[
	command -nargs=1 Browse silent exe '!open ' . "<args>"
]], false)
