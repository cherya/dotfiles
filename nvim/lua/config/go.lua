-- golang language support
local M = {}

function M.setup()
	require("go").setup({
		goimport = "goimports",
		gofmt = "gofumpt",
		max_line_line = 120,
		tag_transform = false,
		test_dir = "",
		comment_placeholder = "   ",
		lsp_cfg = false, -- false: use your own lspconfig
		lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
		lsp_on_attach = false, -- use on_attach from go.nvim
		dap_debug = true,
		icons = { breakpoint = "🧘", currentpos = "🏃" },
		dap_debug_keymap = true, -- set keymaps for debugger
		dap_debug_gui = true, -- set to true to enable dap gui, highly recommand
		dap_debug_vt = true, -- set to true to enable dap virtual text
	})

	vim.api.nvim_exec([[ autocmd BufWritePost *.go :silent! lua require('go.format').goimport() ]], false)
end

return M
