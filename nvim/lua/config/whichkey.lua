local M = {}
local whichkey = require("which-key")
local conf = {
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom" -- bottom, top
	}
}

whichkey.setup(conf)

local function normal_keymap()
	local keymaps_f = nil -- File search
	local keymaps_p = nil -- Project search

	keymaps_f = {
		name = "Find",
		f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
		d = { "<cmd>lua require('utils.finder').find_dotfiles()<cr>", "Dotfiles" },
		b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
		h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help" },
		m = { "<cmd>lua require('telescope.builtin').marks()<cr>", "Marks" },
		o = {
			"<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Old Files"
		},
		g = {
			"<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live Grep"
		},
		c = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
		r = {
			"<cmd>lua require'telescope'.extensions.file_browser.file_browser()<cr>",
			"File Browser"
		},
		w = {
			"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
			"Current Buffer"
		},
		e = { "<cmd>NvimTreeToggle<cr>", "Explorer" }
	}

	keymaps_p = {
		name = "Project",
		p = {
			"<cmd>lua require'telescope'.extensions.project.project{display_type = 'full'}<cr>",
			"List"
		},
		s = { "<cmd>lua require'telescope'.extensions.repo.list{search_dirs = {'~/go/src/github.com', '~/Projects', '~/Prisma'}}<cr>", "Search" },
		P = { "<cmd>TermExec cmd='BROWSER=brave yarn dev'<cr>", "Slidev" }
	}

	local opts = {
		mode = "n", -- Normal mode
		prefix = ";",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = false -- use `nowait` when creating keymaps
	}

	local mappings = {
		["w"] = { "<cmd>update!<CR>", "Save" },
		-- ["q"] = { "<cmd>q!<CR>", "Quit" },

		b = {
			name = "Buffer",
			c = { "<Cmd>bd!<Cr>", "Close Buffer" },
			D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete All Buffers" }
		},

		f = keymaps_f,
		p = keymaps_p,

		z = {
			name = "System",
			c = { "<cmd>PackerCompile<cr>", "Compile" },
			i = { "<cmd>PackerInstall<cr>", "Install" },
			p = { "<cmd>PackerProfile<cr>", "Profile" },
			t = { "<cmd>ToggleTerm<cr>", "Terminal" },
			s = { "<cmd>PackerSync<cr>", "Sync" },
			S = { "<cmd>PackerStatus<cr>", "Status" },
			u = { "<cmd>PackerUpdate<cr>", "Update" },
			r = { "<cmd>Telescope reloader<cr>", "Reload Module" },
			e = { "!!$SHELL<CR>", "Execute line" },
			W = { "<cmd>lua require('utils.session').toggle_session()<cr>", "Toggle Workspace Saving" },
			w = { "<cmd>lua require('utils.session').list_session()<cr>", "Restore Workspace" },
		},

		h = {
			name = "Hop",
			w = { "<cmd>lua require('hop').hint_words()<cr>", "Words" },
			l = { "<cmd>lua require('hop').hint_lines()<cr>", "Lines" },
		},

		g = {
			name = "Git",
			s = { "<cmd>Git status<CR>", "status" },
			l = { "<cmd>lua require('config.toggleterm').LazygitToggle()<cr>", "Lazygit" },
		}
	}
	whichkey.register(mappings, opts)
end

local function code_keymap()
	vim.cmd "autocmd FileType * lua CodeRunner()"

	function CodeRunner()
		local bufnr = vim.api.nvim_get_current_buf()
		local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
		local keymap = nil
		if ft == "python" then
			keymap = {
				name = "Code",
				r = { "<cmd>update<CR><cmd>exec '!python3' shellescape(@%, 1)<cr>", "Run" },
				m = { "<cmd>TermExec cmd='nodemon -e py %'<cr>", "Monitor" },
			}
		elseif ft == "lua" then
			keymap = {
				name = "Code",
				r = { "<cmd>luafile %<cr>", "Run" },
			}
		elseif ft == "rust" then
			keymap = {
				name = "Code",
				r = { "<cmd>Cargo run<cr>", "Run" },
			}
		elseif ft == "go" then
			keymap = {
				name = "Code",
				r = { "<cmd>GoRun<cr>", "Run" },
			}
		end

		if keymap ~= nil then
			whichkey.register(
				{ c = keymap },
				{ mode = "n", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>" }
			)
		end
	end
end

function M.setup()
	normal_keymap()
	code_keymap()
end

return M
