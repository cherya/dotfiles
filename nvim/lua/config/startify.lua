-- startify
local M = {}

function M.setup()
	vim.g.startify_custom_header = {
		'  ', '   ╻ ╻   ╻   ┏┳┓', '   ┃┏┛   ┃   ┃┃┃',
		'   ┗┛    ╹   ╹ ╹', '   '
	}

	vim.g.startify_lists = {
		{ type = 'files', header = { '   MRU' } },
		{ type = 'dir', header = { '   MRU ' .. vim.fn.getcwd() } },
		{ type = 'sessions', header = { '   Sessions' } },
		{ type = 'bookmarks', header = { '   Bookmarks' } },
		{ type = 'commands', header = { '   Commands' } }
	}

	vim.g.startify_files_number = 5
	vim.g.startify_update_oldfiles = 1
	vim.g.startify_session_autoload = 1
	vim.g.startify_session_before_save = { 'silent! tabdo NvimTreeClose' }
	vim.g.startify_session_persistence = 1
	vim.g.startify_change_to_vcs_root = 1
	vim.g.startify_enable_special = 0
end

return M
