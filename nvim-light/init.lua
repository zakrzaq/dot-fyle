---@diagnostic disable: missing-fields

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.hidden = true
vim.opt.conceallevel = 2
vim.opt.foldmethod = "manual"
vim.opt.foldenable = true
vim.opt.spell = true
vim.opt.spelllang = { "en", "pl" }
vim.opt.spelloptions = "camel"
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/programming.utf-8.add"


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

vim.g.mapleader = " "
local keymap = vim.keymap.set

keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

keymap("n", "<leader>,", list_and_select_buffers, { desc = "List and select buffers" })

keymap("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
keymap("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })
keymap("n", "]t", ":tabnext<CR>", { desc = "Next tab" })
keymap("n", "[t", ":tabprevious<CR>", { desc = "Previous tab" })
keymap("n", "]b", ":bn<CR>", { desc = "Next tab" })
keymap("n", "[b", ":bp<CR>", { desc = "Previous tab" })
keymap('n', '<leader>z', '<C-^>', { noremap = true, silent = true })
keymap("v", "<", "<gv", { silent = true })
keymap("v", ">", ">gv", { silent = true })

keymap("n", "<C-q>", ":qa!<CR>", { desc = "Quit!" })
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>x", ":x<CR>", { desc = "Save and quit file" })
keymap("n", "<leader>q", ":bd<CR>", { desc = "Close buffer" })
keymap("n", "<leader>Q", "<C-w>c", { desc = "Close current pane/window" })

keymap("n", "<leader>uh", ":nohlsearch<CR>", { desc = "Clear search highlights" })
keymap("n", "<leader>ue", ":Explore<CR>", { desc = "Explorer" })
keymap("n", "<leader>ut", ":terminal<CR>", { desc = "Terminal" })
keymap({ "n", "v" }, "<leader>up", "<cmd>:echo expand('%:p') <cr>", { desc = "[C]ode [P]ath", silent = true })
keymap({ "n", "v" }, "<leader>ul", "<cmd>:colorscheme rose-pine-dawn<CR>", { desc = "[U]se [L]ight Theme" })
keymap({ "n", "v" }, "<leader>ud", "<cmd>:colorscheme nord<CR>", { desc = "[U]se [D]ark Theme" })

keymap("i", "jj", "<ESC>", { desc = "Escape" })
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")
keymap({ "n", "v" }, "<leader>y", '"+y', { desc = "[Y]ank to system clipboard" })
keymap({ "n", "v" }, "<leader>p", '"+p', { desc = "[P]aste from system clipboard" })

local center_maps = { "<C-d>", "<C-u>", "n", "N" }
for _, key in ipairs(center_maps) do
  keymap("n", key, key .. "zz")
end


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
  {
    "gbprod/nord.nvim",
    config = function()
      vim.cmd.colorscheme "nord"
    end,
  },
  { "rose-pine/neovim" },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        icons_enabled = false,
        theme = "nord",
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_x = {
          "encoding",
          "fileformat",
          "filetype",
        },
      },
    }
  },

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

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason").setup()

      mason_lspconfig.setup({
        automatic_installation = { "ts_ls", "html", "cssls", "ruff" },
        handlers = {
          function(server_name)
            local on_attach = function(client, bufnr)
              vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
              local opts = { noremap = true, silent = true }
              vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
              vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
              vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
              vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
              vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
              vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
              vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
              vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
              vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
              vim.keymap.set("n", "<leader>f", function()
                vim.lsp.buf.format({ async = true })
              end, opts)
            end

            lspconfig[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,
        },
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip"
    },
    config = function()
      require("cmp").setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = require("cmp").mapping.preset.insert(),
        sources = require("cmp").config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,

    }
  },

})
