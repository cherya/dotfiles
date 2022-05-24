local M = {}

function M.setup()
	-- Set colorscheme (order is important here)
	vim.g.gruvbox_material_background = 'medium'
	vim.g.gruvbox_material_palette = 'mix'
	vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
	vim.g.gruvbox_material_diagnostic_text_highlight = '1'
	vim.g.gruvbox_material_diagnostic_line_highlight = '1'
	vim.cmd [[colorscheme gruvbox-material]]
end

return M
