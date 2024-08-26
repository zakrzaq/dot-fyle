-- VIRTUAL TEXT OFF
vim.diagnostic.config({
	float = { source = "always", border = "rounded" },
	virtual_text = false,
	signs = true,
})
-- vim.cmd([[ autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

-- DIAGNOSTICS ICONS
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- SAVE FOLD ON FILE SAVE
local group = vim.api.nvim_create_augroup("AutoSaveFolds", { clear = true })

vim.api.nvim_create_autocmd({ "BufLeave" }, { command = "mkview", pattern = ".*", group = group })

vim.api.nvim_create_autocmd({ "BufEnter" }, { command = "loadview", pattern = ".*", group = group })

-- MARKDOWN CONCEAL
-- vim.cmd[[
-- augroup filetypedetect
--   autocmd!
--   " Set .md files to use markdown syntax
--   autocmd BufNewFile,BufRead *.md set syntax=markdown
--   autocmd BufNewFile,BufRead *.md set conceallevel=2
-- augroup END
-- ]]

-- vim.api.nvim_create_autocmd("FileType", {
--   group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
--   pattern = { "gitcommit", "markdown" },
--   callback = function()
--     -- vim.opt_local.textwidth = 80
--     vim.opt_local.wrap = true
--     vim.opt_local.spell = true
--     -- vim.opt_local.tabstop = 2
--     -- vim.opt_local.softtabstop = 2
--     -- vim.opt_local.shiftwidth = 2
--     -- vim.opt_local.expandtab = true
--   end,
-- })
