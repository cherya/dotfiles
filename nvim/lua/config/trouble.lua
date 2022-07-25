local M = {}

function M.setup()
	require("trouble").setup({
		auto_open = true,
		auto_close = false,
		auto_preview = true,
		icons = true,
		signs = {
			-- icons / text used for a diagnostic
			error = "",
			warning = "",
			hint = "",
			information = "",
			other = "﫠",
		},
	})
end

return M
