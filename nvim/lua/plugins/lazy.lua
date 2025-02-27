local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Core Utilities
	{ "tpope/vim-sleuth", event = "VeryLazy" },

	-- Theme Configuration
	{
		"AlexvZyl/nordic.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("nordic")
		end,
	},
	{ "rose-pine/neovim", enabled = false },
	{ "rebelot/kanagawa.nvim", enabled = false },
	{ "catppuccin/nvim", enabled = false },
	{ "folke/tokyonight.nvim", enabled = false },

	-- UI Components
	{ "akinsho/bufferline.nvim", event = "VeryLazy", opts = {} },
	{ "moll/vim-bbye", event = "VeryLazy" },
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
	{ "akinsho/toggleterm.nvim", event = "VeryLazy", opts = {} },
	{ "folke/which-key.nvim", event = "VeryLazy", opts = {} },
	{ "nvim-lualine/lualine.nvim", event = "VeryLazy", opts = {} },
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
	{ "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
	{ "folke/todo-comments.nvim", event = "VeryLazy", opts = {} },

	-- URL Handler
	{
		"sontungexpt/url-open",
		event = "VeryLazy",
		cmd = "URLOpenUnderCursor",
		opts = {},
	},

	-- Text Manipulation
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},

	-- Fuzzy Finding
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			"sharkdp/fd",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
	},

	-- Syntax & Language
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		config = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	},

	-- File Explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
		end,
	},

	-- Git Integration
	{ "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },

	-- LSP & Completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },
			"folke/neodev.nvim",
		},
	},

	-- Formatting
	{ "stevearc/conform.nvim", event = "BufReadPre", opts = {} },

	-- Note Taking
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		ft = "markdown",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Productivity
	{
		"epwalsh/pomo.nvim",
		version = "*",
		cmd = { "TimerStart", "TimerRepeat" },
		dependencies = { "rcarriga/nvim-notify" },
		opts = {},
	},

	-- Session Management
	{
		"rmagatti/auto-session",
		event = "VimEnter",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = {
			auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		},
	},

	-- Database Tools
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
		},
		cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},

	-- Git Diff Tools
	{ "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewFileHistory" } },

	-- AI Tools
	{
		"Exafunction/codeium.vim",
		event = "InsertEnter",
	},
	{
		"olimorris/codecompanion.nvim",
		event = "VeryLazy",
		config = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"j-hui/fidget.nvim",
		},
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		cmd = { "CopilotChat", "CopilotChatToggle" },
		dependencies = {
			"github/copilot.vim",
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {},
	},
}, {})
