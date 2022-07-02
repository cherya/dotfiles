local M = {}
local servers = {
	gopls = {},
	html = {},
	sqlls = {},
	jsonls = {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
			},
		},
	},
	pyright = {},
	rust_analyzer = {},
	sumneko_lua = {
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = vim.split(package.path, ";")
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" }
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = {
						[vim.fn.expand "$VIMRUNTIME/lua"] = true,
						[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true
					}
				}
			}
		}
	},
	tsserver = {},
	vimls = {}
}

local function on_attach(client, bufnr)
	-- Enable completion triggered by <C-X><C-O>
	-- See `:help omnifunc` and `:help ins-completion` for more information.
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Use LSP as the handler for formatexpr.
	-- See `:help formatexpr` for more information.
	vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

	-- Configure key mappings
	require("config.lsp.keymaps").setup(client, bufnr)

	-- LSP plugins
	require("illuminate").on_attach(client)
	require("lsp_signature").on_attach({
		bind = true,
		handler_opts = { border = "rounded" }
	})

	require("config.lsp.null-ls.formatters").setup(client, bufnr)

	local coq = require("coq")
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	coq.lsp_ensure_capabilities({
		on_attach = on_attach,
		capabilities = capabilities
	})

	vim.lsp.protocol.CompletionItemKind = {
		'', -- Text
		'', -- Method
		'', -- Function
		'', -- Constructor
		'', -- Field
		'', -- Variable
		'', -- Class
		'ﰮ', -- Interface
		'', -- Module
		'', -- Property
		'', -- Unit
		'', -- Value
		'', -- Enum
		'', -- Keyword
		'﬌', -- Snippet
		'', -- Color
		'', -- File
		'', -- Reference
		'', -- Folder
		'', -- EnumMember
		'', -- Constant
		'', -- Struct
		'', -- Event
		'ﬦ', -- Operator
		'' -- TypeParameter
	}
end

local opts = { on_attach = on_attach, flags = { debounce_text_changes = 150 } }

-- Setup LSP handlers
require("config.lsp.handlers").setup()

function M.setup()
	-- null-ls
	require("config.lsp.null-ls").setup(opts)
	-- Installer
	require("config.lsp.installer").setup(servers, opts)
end

return M
