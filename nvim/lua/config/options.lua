vim.opt.number = true
-- vim.opt.relativenumber = true

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
vim.opt.signcolumn = "yes"

vim.opt.clipboard = "unnamedplus"

vim.opt.breakindent = true
vim.opt.undofile = true

vim.opt.smartcase = true

vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 300

vim.opt.completeopt = "menuone,noselect"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.hidden = true

vim.opt.conceallevel = 2

vim.opt.foldmethod = "manual"
vim.opt.foldenable = true

vim.opt.spell = true                                                           -- Enable spell checking
vim.opt.spelllang = { "en", "pl" }                                             -- Set languages to English and Polish
vim.opt.spelloptions = "camel"                                                 -- Support camelCase words in code
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/programming.utf-8.add" -- Custom word list
