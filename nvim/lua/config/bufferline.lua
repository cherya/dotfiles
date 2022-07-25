-- Bufferline
local M = {}

function M.setup()
	require("bufferline").setup({
		options = {
			mode = "buffers",
			numbers = "ordinal",
			close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
			right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
			left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
			middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level, diagnostics_dict, co, fa, truentext)
				return "(" .. count .. ")"
			end,
			offsets = { { filetype = "NvimTree", text = "File Explorer" } },
			show_buffer_icons = true, -- disable filetype icons for buffers
			show_buffer_close_icons = true,
			show_close_icon = true,
			show_tab_indicators = true,
			persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
			separator_style = "thick",
			sort_by = "id",
		},
	})
end

return M
