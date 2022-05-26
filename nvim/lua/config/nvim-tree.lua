local M = {}

function M.setup()
	require("nvim-tree").setup {
		disable_netrw = true,
		git = {
			ignore = false,
		},
		hijack_netrw = true,
		view = { number = true, relativenumber = true },
		filters = {
			custom = { ".git" },
			exclude = { ".gitigore" },
		},
		update_cwd = true,
		update_focused_file = { enable = true, update_cwd = true }
	}

	vim.g.nvim_tree_respect_buf_cwd = 1
end

return M
