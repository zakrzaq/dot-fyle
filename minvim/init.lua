-- =============================================================================
-- LAZY.NVIM BOOTSTRAP
-- =============================================================================
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

-- =============================================================================
-- CORE OPTIONS
-- =============================================================================
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.clipboard = "unnamedplus"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.showtabline = 2 -- Always show the tabline

-- =============================================================================
-- NATIVE BUFFER & WINDOW MANAGEMENT FUNCTION
-- =============================================================================
-- This custom function lists all open buffers in a native UI popup for selection.
local function list_and_select_buffers()
  local bufs = vim.api.nvim_list_bufs()
  local buf_infos = {}

  for _, bufnr in ipairs(bufs) do
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buflisted then
      local fname = vim.api.nvim_buf_get_name(bufnr)
      table.insert(buf_infos, {
        nr = bufnr,
        name = fname == "" and "[No Name]" or vim.fn.fnamemodify(fname, ":t"),
        path = fname,
      })
    end
  end

  -- Sort buffers by number
  table.sort(buf_infos, function(a, b) return a.nr < b.nr end)

  local display_strings = {}
  for _, info in ipairs(buf_infos) do
    table.insert(display_strings, string.format("%d: %s", info.nr, info.name))
  end

  vim.ui.select(display_strings, {
    prompt = "Select a buffer:",
  }, function(choice)
    if not choice then return end
    -- Extract the buffer number from the start of the string
    local bufnr = tonumber(string.match(choice, "^%d+"))
    if bufnr then
      vim.api.nvim_set_current_buf(bufnr)
    end
  end)
end

-- =============================================================================
-- KEYMAPS
-- =============================================================================
vim.g.mapleader = " "
local keymap = vim.keymap.set

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Buffer navigation
keymap("n", "<leader>b", list_and_select_buffers, { desc = "List and select buffers" })

-- Buffer and Pane/Window closing
keymap("n", "<leader>c", ":bdelete<CR>", { desc = "Close current buffer" })
keymap("n", "<leader>wc", "<C-w>c", { desc = "Close current pane/window" })

-- Native Tab management
keymap("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
keymap("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })
keymap("n", "<leader>tl", ":tabnext<CR>", { desc = "Next tab" })
keymap("n", "<leader>th", ":tabprevious<CR>", { desc = "Previous tab" })

-- File operations
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Utility
keymap("n", "<leader>H", ":nohlsearch<CR>", { desc = "Clear search highlights" })
keymap("n", "<leader>e", ":Explore<CR>", { desc = "Explorer" })


-- =============================================================================
-- PLUGINS (Managed by Lazy.nvim)
-- =============================================================================
require("lazy").setup({
  -- Theme: Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
      })
      vim.cmd.colorscheme "catppuccin-mocha"
    end,
  },

  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "typescript", "html", "css", "python", "java", "lua", "vim", "vimdoc" },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
})
