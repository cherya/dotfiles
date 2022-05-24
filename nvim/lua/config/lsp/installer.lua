local lsp_installer_servers = require("nvim-lsp-installer.servers")
local utils = require("utils")

local M = {}

function M.setup(servers, options)
	for server_name, _ in pairs(servers) do
		local server_available, server =
		lsp_installer_servers.get_server(server_name)

		if server_available then
			server:on_ready(function()
				local opts = vim.tbl_deep_extend("force", options,
					servers[server.name] or {})
				-- For coq.nvim
				local coq = require "coq"
				server:setup(coq.lsp_ensure_capabilities(opts))
			end)

			if not server:is_installed() then
				utils.info("Installing " .. server.name)
				server:install()
			end
		else
			utils.error(server)
		end
	end

	-- setup golangcilsp
	local lspconfig = require("lspconfig")
	local configs = require("lspconfig/configs")
	if not configs.golangcilsp then
		configs.golangcilsp = {
			default_config = {
				cmd = { 'golangci-lint-langserver' },
				root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
				init_options = {
					command = {
						"golangci-lint", "run", "--out-format", "json",
						"--config=", ".golangci.yaml"
					}
				}
			}
		}
	end
	lspconfig.golangci_lint_ls.setup { filetypes = { 'go', 'gomod' } }
end

return M
