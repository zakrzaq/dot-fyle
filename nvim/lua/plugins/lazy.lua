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
  { "tpope/vim-sleuth",           event = "VeryLazy" },

  -- Theme Configuration
  {
    "catppuccin/nvim",
    -- "rose-pine/neovim",
    -- "shaunsingh/nord.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
      -- vim.cmd.colorscheme("nord")
    end,
  },

  -- UI Components
  { "nvim-lualine/lualine.nvim",  event = "VeryLazy",    opts = {} },
  { "akinsho/bufferline.nvim",    event = "VeryLazy",    opts = {} },
  { "windwp/nvim-autopairs",      event = "InsertEnter", opts = {} },
  { "folke/which-key.nvim",       event = "VeryLazy",    opts = {} },
  { "meznaric/key-analyzer.nvim", event = "VeryLazy",    opts = {} },
  { "numToStr/Comment.nvim",      event = "VeryLazy",    opts = {} },
  { "folke/todo-comments.nvim",   event = "VeryLazy",    opts = {} },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true, -- if you want to enable the plugin
      message_template = " <summary> • <date> • <author> • <<sha>>",
      date_format = "%m-%d-%Y %H:%M:%S",
      virtual_text_column = 1,
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
  },

  -- Text Manipulation
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
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
      "onsails/lspkind.nvim",
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
  { "stevearc/conform.nvim",   event = "BufReadPre",                   opts = {} },

  -- Note Taking
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
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

  -- REST
  {
    "mistweaverco/kulala.nvim",
    keys = { "<leader>Rs", "<leader>Ra", "<leader>Ro" },
    ft = { "http", "rest" },
  },

  -- DBMS
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod",                     lazy = true },
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
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup({})
    end,
  },

  -- DAP --
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
    },
  },


  -- AI Tools
  { -- Codeium
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
  },

  { -- CodeCompanion
    "olimorris/codecompanion.nvim",
    config = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "github/copilot.vim",
    },
  },

  {                     -- VectorCode
    "Davidyz/VectorCode",
    version = "*",      -- optional, depending on whether you're on nightly or release
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "VectorCode", -- if you're lazy-loading VectorCode
  }
}, {})
