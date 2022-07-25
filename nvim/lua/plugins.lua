local M = {}

function M.setup()
	-- Indicate first time installation
	local packer_bootstrap = false

	-- packer.nvim configuration
	local conf = {
		profile = {
			enable = true,
			threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
		},

		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	}

	-- Check if packer.nvim is installed
	-- Run PackerCompile if there are changes in this file
	local function packer_init()
		local fn = vim.fn
		local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
		if fn.empty(fn.glob(install_path)) > 0 then
			packer_bootstrap = fn.system({
				"git",
				"clone",
				"--depth",
				"1",
				"https://github.com/wbthomason/packer.nvim",
				install_path,
			})
			vim.cmd([[packadd packer.nvim]])
		end
		vim.cmd("autocmd BufWritePost plugins.lua source <afile> | PackerCompile")
	end

	local function plugins(use)
		use("wbthomason/packer.nvim") -- package manager
		use({ "lewis6991/impatient.nvim" }) -- Performance
		use("tpope/vim-commentary") -- "gc" to comment visual regions/lines
		use("DanilaMihailov/beacon.nvim")
		use({
			"nvim-telescope/telescope.nvim",
			module = "telescope",
			event = "VimEnter",
			requires = {
				"nvim-lua/popup.nvim",
				"nvim-lua/plenary.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				"nvim-telescope/telescope-project.nvim",
				"cljoly/telescope-repo.nvim",
				"nvim-telescope/telescope-file-browser.nvim",
				"ahmedkhalf/project.nvim",
			},
			config = function()
				require("config.telescope").setup()
			end,
		})
		use({
			"ahmedkhalf/project.nvim",
			config = function()
				require("project_nvim").setup({
					respect_buf_cwd = true,
					update_cwd = true,
					update_focused_file = {
						enable = true,
						update_cwd = true,
					},
				})
			end,
		})
		use({
			"TC72/telescope-tele-tabby.nvim",
			requires = { "nvim-telescope/telescope.nvim" },
		})
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = function()
				require("config.lualine").setup()
			end,
		}) -- fancier statusline
		use({ "sainnhe/gruvbox-material" }) -- theme
		use({ "nathom/filetype.nvim" })
		use({
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("config.gitsigns").setup()
			end,
		}) -- add git related info in the signs columns and popups}
		use({
			"nvim-treesitter/nvim-treesitter", -- highlight, edit, and navigate code using a fast incremental parsing library
			run = ":TSUpdate",
			config = function()
				require("config.treesitter").setup()
			end,
		})
		use("nvim-treesitter/nvim-treesitter-textobjects") -- additional textobjects for treesitter
		use({
			"rcarriga/nvim-notify",
			event = "VimEnter",
			config = function()
				vim.notify = require("notify")
			end,
		}) -- fancy notifications
		use({
			"VonHeikemen/fine-cmdline.nvim",
			requires = {
				{ "MunifTanjim/nui.nvim" },
			},
			config = function()
				require("fine-cmdline").setup({
					cmdline = {
						enable_keymaps = true,
						smart_history = true,
						prompt = ":",
					},
					popup = {
						position = {
							row = "10%",
							col = "50%",
						},
						size = {
							width = "60%",
						},
						border = {
							style = "double",
						},
						win_options = {
							winhighlight = "Normal:Normal,FloatBorder:Normal",
						},
					},
				})
			end,
		}) -- fancy comandline
		use({
			"VonHeikemen/searchbox.nvim",
			requires = {
				{ "MunifTanjim/nui.nvim" },
			},
		}) -- fancy searchbox
		use({
			"tiagovla/scope.nvim",
			config = function()
				require("scope").setup()
			end,
		}) -- integrating vim tabs with bufferline
		use("jose-elias-alvarez/null-ls.nvim") -- null language server
		use({
			"neovim/nvim-lspconfig",
			opt = true,
			event = "BufReadPre",
			wants = {
				"nvim-lsp-installer",
				"lsp_signature.nvim",
				"coq_nvim",
				"lua-dev.nvim",
				"vim-illuminate",
				"null-ls.nvim",
				"schemastore.nvim",
			},
			config = function()
				require("config.lsp").setup()
			end,
			requires = {
				"williamboman/nvim-lsp-installer",
				"ray-x/lsp_signature.nvim",
				"folke/lua-dev.nvim",
				"RRethy/vim-illuminate",
				"jose-elias-alvarez/null-ls.nvim",
				{
					"j-hui/fidget.nvim",
					config = function()
						require("fidget").setup()
					end,
				},
				"b0o/schemastore.nvim",
			},
		}) -- collection of configurations for built-in lsp client
		use("RishabhRD/popfix")
		use({
			"RishabhRD/nvim-lsputils",
			requires = { "RishabhRD/popfix" },
			config = function()
				require("config.lsputils").setup()
			end,
		})
		use("b0o/schemastore.nvim")
		use("folke/lua-dev.nvim")
		use({
			"j-hui/fidget.nvim",
			config = function()
				require("fidget").setup()
			end,
		})
		use({
			"ms-jpq/coq_nvim",
			branch = "coq",
			event = "InsertEnter",
			opt = true,
			run = ":COQdeps",
			config = function()
				require("config.coq").setup()
			end,
			requires = {
				{ "ms-jpq/coq.artifacts", branch = "artifacts" },
				{ "ms-jpq/coq.thirdparty", branch = "3p", module = "coq_3p" },
				{ "github/copilot.vim" },
			},
		}) -- fast as fuck autocompletion plugin
		use({ "ms-jpq/coq.artifacts", branch = "artifacts" }) -- 9000+ snippets
		use("p00f/nvim-ts-rainbow") -- rainbow brackets
		use("vim-test/vim-test") -- tests runner
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("config.trouble").setup()
			end,
		})
		use({
			"ray-x/go.nvim", -- golang
			requires = {
				"ray-x/guihua.lua",
				"neovim/nvim-lspconfig",
				"nvim-treesitter/nvim-treesitter",
				"thehamsta/nvim-dap-virtual-text",
				"nvim-telescope/telescope.nvim",
				"mfussenegger/nvim-dap",
				"rcarriga/nvim-dap-ui",
			},
			config = function()
				require("config.go").setup()
			end,
		})
		use("unblevable/quick-scope") -- letters highlight for f f t t
		use({
			"kyazdani42/nvim-tree.lua",
			module = "nvim-tree",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("config.nvim-tree").setup()
			end,
		})
		use({ "marklcrns/vim-smartq", branch = "main" }) -- smart buffer close on 'q'
		use("stsewd/gx-extended.vim") -- url opener
		use({
			"akinsho/bufferline.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			branch = "main",
			config = function()
				require("config.bufferline").setup()
			end,
		})
		use({
			"akinsho/toggleterm.nvim",
			branch = "main",
			config = function()
				require("config.toggleterm").setup()
			end,
		}) -- persistent terminals
		use("gelguy/wilder.nvim")
		use("gennaro-tedesco/nvim-peekup") -- yank peeker
		use("haya14busa/is.vim")
		use("tjdevries/nlua.nvim")
		use("rrethy/vim-illuminate") -- highlight word under cursor (with lsp integration)
		use("ray-x/lsp_signature.nvim") -- functions singature when typing
		use({
			"phaazon/hop.nvim", -- easy motion
			config = function()
				require("hop").setup()
			end,
		})
		use({
			"goolord/alpha-nvim",
			wants = { "which-key" },
			config = function()
				require("config.alpha").setup()
			end,
		}) -- vim start screen
		use("tpope/vim-fugitive") -- git integration
		use("tpope/vim-rhubarb") -- GBrowse provider
		use("mfussenegger/nvim-dap")
		use("rcarriga/nvim-dap-ui")
		use({
			"thehamsta/nvim-dap-virtual-text",
			config = function()
				require("nvim-dap-virtual-text").setup()
			end,
		})
		use({
			"folke/which-key.nvim", -- hotkeys helper,
			config = function()
				require("config.whichkey").setup()
			end,
		})
		use({ "SmiteshP/nvim-gps", requires = "nvim-treesitter/nvim-treesitter" })
		use({
			"karb94/neoscroll.nvim",
			config = function()
				require("config.neoscroll").setup()
			end,
		})

		-- Bootstrap Neovim
		if packer_bootstrap then
			print("Restart Neovim required after installation!")
			require("packer").sync()
		end
	end

	-- Init and start packer
	packer_init()
	local packer = require("packer")

	-- Performance
	pcall(require, "impatient")

	packer.init(conf)
	packer.startup(plugins)
end

return M
