local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')
local headers = require('utils.ascii_art')

local function footer()
	-- Number of plugins
	local total_plugins = #vim.tbl_keys(packer_plugins)
	local datetime = os.date "  %d-%m-%Y   %H:%M:%S"

	local version = vim.version()
	local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
	local plugins_text = "   " .. total_plugins .. " plugins loaded " .. datetime
	return nvim_version_info .. plugins_text
end

math.randomseed(os.time())
dashboard.section.header.val = headers[math.random(1, #headers)]

dashboard.section.buttons.val = {
	dashboard.button('e', 'ﱐ  New file', '<cmd>ene<CR>'),
	dashboard.button('s', '  Sync plugins', '<cmd>PackerSync<CR>'),
	dashboard.button('c', '  Configurations', '<cmd>e ~/.config/nvim/<CR>'),
	dashboard.button(';ff', '  Find files', '<cmd>Telescope find_files<CR>'),
	dashboard.button(';fo', '  Find old files', '<cmd>Telescope oldfiles<CR>'),
	dashboard.button(';fg', 'ﭨ  Live grep', '<cmd>Telescope live_grep<CR>'),
	dashboard.button(';gs', '  Git status', '<cmd>Telescope git_status<CR>'),
	dashboard.button('q', '  Quit', '<cmd>qa<CR>')
}

dashboard.section.footer.opts.hl = 'Green'
dashboard.section.footer.val = footer()

-- ┌──────────────────────────────────────────────────────────┐
-- │                  /                                       │
-- │    header_padding                                        │
-- │                  \  ┌──────────────┐ ____                │
-- │                     │    header    │     \               │
-- │                  /  └──────────────┘      \              │
-- │ head_butt_padding                          \             │
-- │                  \                          occu_        │
-- │                  ┌────────────────────┐     height       │
-- │                  │       button       │    /             │
-- │                  │       button       │   /              │
-- │                  │       button       │  /               │
-- │                  └────────────────────┘‾‾                │
-- │                  /                                       │
-- │ foot_butt_padding                                        │
-- │                  \  ┌──────────────┐                     │
-- │                     │    footer    │                     │
-- │                     └──────────────┘                     │
-- │                                                          │
-- └──────────────────────────────────────────────────────────┘

local head_butt_padding = 4
local occu_height = #dashboard.section.header.val + 2 * #dashboard.section.buttons.val + head_butt_padding
local header_padding = math.max(0, math.ceil((vim.fn.winheight('$') - occu_height) * 0.25))
local foot_butt_padding_ub = vim.o.lines - header_padding - occu_height - #dashboard.section.footer.val - 3
local foot_butt_padding = math.floor((vim.fn.winheight('$') - 2 * header_padding - occu_height))
foot_butt_padding = math.max(0, math.max(math.min(0, foot_butt_padding), math.min(math.max(0, foot_butt_padding), foot_butt_padding_ub)))

dashboard.config.layout = {
	{ type = 'padding', val = header_padding },
	dashboard.section.header,
	{ type = 'padding', val = head_butt_padding },
	dashboard.section.buttons,
	{ type = 'padding', val = foot_butt_padding },
	dashboard.section.footer
}

local M = {}
function M.setup()
	alpha.setup(dashboard.opts)
end

return M
