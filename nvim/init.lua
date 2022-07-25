require("plugins").setup()

vim.api.nvim_exec(
	[[
	command -nargs=1 Browse silent exe '!open ' . "<args>"
]],
	false
)

-- Set colorscheme (order is important here)
vim.opt.termguicolors = true
vim.g.gruvbox_material_background = "medium"
vim.g.gruvbox_material_palette = "mix"
vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
vim.g.gruvbox_material_diagnostic_text_highlight = "1"
vim.g.gruvbox_material_diagnostic_line_highlight = "1"
vim.cmd([[ colorscheme gruvbox-material  ]])

-- Disable some builtin vim plugins
local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"matchparen",
	"tar",
	"tarPlugin",
	"rrhelper",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end
