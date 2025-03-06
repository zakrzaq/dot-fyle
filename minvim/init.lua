-- Basic Settings
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = false -- Show relative line numbers
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 2 -- Number of spaces per tab
vim.opt.shiftwidth = 2 -- Number of spaces for indentation
vim.opt.smartindent = true -- Smart autoindenting
vim.opt.wrap = false -- Disable line wrapping
vim.opt.scrolloff = 8 -- Keep 8 lines visible when scrolling
vim.opt.sidescrolloff = 8 -- Keep 8 columns visible when scrolling
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.hlsearch = true -- Highlight search results
vim.opt.incsearch = true -- Incremental search
vim.opt.termguicolors = true -- Enable 24-bit RGB color

-- Leader Key
vim.g.mapleader = " "

-- Basic Keymaps
local keymap = vim.keymap.set

-- Window Navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Buffer Navigation
keymap("n", "[b", ":bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "]b", ":bnext<CR>", { desc = "Next buffer" })

-- Quick Save and Quit
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Clear Search Highlights
keymap("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Plugin Management (Optional - using built-in package management)
-- vim.cmd([[packadd packer.nvim]])

-- Basic Color Scheme (Optional)
vim.cmd([[colorscheme slate]])

-- Plugins
require("plugins")

-- LSP
-- require("lspconfig").lua_ls.setup({})
