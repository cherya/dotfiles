-- COQ

local M = {}

function M.setup()
	local coq = require("coq")
	vim.g.coq_settings = {
		auto_start = true,
		clients = {
			tabnine = {
				enabled = true,
			},
		},
	}
	coq.Now() -- Start coq

	-- 3party sources
	require("coq_3p")({
		{ src = "nvimlua", short_name = "nLUA", conf_only = false }, -- Lua
		{ src = "bc", short_name = "MATH", precision = 6 }, -- Calculator
		{
			src = "repl",
			sh = "zsh",
			shell = { p = "perl", n = "node" },
			max_lines = 99,
			deadline = 500,
			unsafe = { "rm", "poweroff", "mv" },
		},
		{ src = "copilot", short_name = "COP", accept_key = "<c-f>" },
	})
end

return M
