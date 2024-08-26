local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- GIT
	{ "NeogitOrg/neogit", dependencies = "nvim-lua/plenary.nvim", config = true },

	-- TAB SHIFT WIDTH
	"tpope/vim-sleuth",

	-- THEME
	{
		-- "rose-pine/neovim",
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight")
			-- vim.cmd.colorscheme("rose-pine")
		end,
	},

	-- UI
	{ "akinsho/bufferline.nvim", opts = {} },
	{ "moll/vim-bbye" },
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
	-- { -- AUTOTAG
	-- 	"windwp/nvim-ts-autotag",
	-- 	config = function()
	-- 		require("nvim-ts-autotag").setup({
	-- 			opts = {
	-- 				enable_close = true, -- Auto close tags
	-- 				enable_rename = true, -- Auto rename pairs of tags
	-- 				enable_close_on_slash = true, -- Auto close on trailing </
	-- 			},
	-- 			per_filetype = {
	-- 				["html"] = {
	-- 					enable_close = true,
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- 	opts = {},
	-- },
	{ -- TOGGLE TERM
		"akinsho/toggleterm.nvim",
		opts = {
			open_mapping = "<C-b>",
			direction = "float",
			shade_terminals = true,
		},
	},

	{ -- WHICH KEY
		"folke/which-key.nvim",
		opts = {},
	},

	{ -- LUALINE
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = false,
				theme = "tokyonight",
				component_separators = "|",
				section_separators = "",
			},
			sections = {
				lualine_x = {
					function()
						local ok, pomo = pcall(require, "pomo")
						if not ok then
							return ""
						end

						local timer = pomo.get_first_to_finish()
						if timer == nil then
							return ""
						end

						return "󰄉 " .. tostring(timer)
					end,
					"encoding",
					"fileformat",
					"filetype",
				},
			},
		},
	},

	{ -- MINI INDENT
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},

	{ -- COMMENTS
		"numToStr/Comment.nvim",
		opts = {},
	},

	{ -- TODO COMMENTS
		"folke/todo-comments.nvim",
		opts = {},
	},

	{ -- OPEN URL
		"sontungexpt/url-open",
		event = "VeryLazy",
		cmd = "URLOpenUnderCursor",
		config = function()
			local status_ok, url_open = pcall(require, "url-open")
			if not status_ok then
				return
			end
			url_open.setup({})
		end,
	},

	{ -- VIM SURROUND
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	{ -- TELESCOPE
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			"sharkdp/fd",
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},

	{ -- TREESITTER
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	},

	{ -- NEOTREE
		"nvim-neo-tree/neo-tree.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
		end,
	},

	{ -- GIT SIGNS
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	{ -- AUTOCOMPLETE
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
	},

	{ -- LSP
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },
			"folke/neodev.nvim",
		},
	},

	{ -- FORMATTING
		"stevearc/conform.nvim",
		opts = {},
	},

	{ -- CODEIUM
		"jcdickinson/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("codeium").setup({})
		end,
	},

	{ -- OBSIDIAN
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		--   "BufReadPre path/to/my-vault/**.md",
		--   "BufNewFile path/to/my-vault/**.md",
		-- },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			workspaces = {
				{
					name = "personal",
					path = "~/Dropbox/Apps/jakebook",
				},
				-- {
				-- 	name = "work",
				-- 	path = "~/vaults/work",
				-- },
			},
		},
	},

	{ -- POMODORO
		"epwalsh/pomo.nvim",
		version = "*", -- Recommended, use latest release instead of latest commit
		lazy = true,
		cmd = { "TimerStart", "TimerRepeat" },
		dependencies = {
			"rcarriga/nvim-notify",
		},
		opts = {},
	},

	{ -- TROUBLE
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},

	-- { -- AUTO DARK MODE
	-- 	"f-person/auto-dark-mode.nvim",
	-- 	config = {
	-- 		update_interval = 1000,
	-- 		set_dark_mode = function()
	-- 			vim.cmd.colorscheme("rose-pine")
	-- 		end,
	-- 		set_light_mode = function()
	-- 			vim.cmd.colorscheme("rose-pine-dawn")
	-- 		end,
	-- 	},
	-- },

	{ -- AUTO SESSION
		"rmagatti/auto-session",
		lazy = false,
		dependencies = {
			"nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
		},
		config = function()
			require("auto-session").setup({
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
		end,
	},

	{ -- DADBOD UI / DBMS
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
}, {})
