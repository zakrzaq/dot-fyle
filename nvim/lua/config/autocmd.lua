-- VIRTUAL TEXT OFF
vim.diagnostic.config({
	float = { source = "always", border = "rounded" },
	virtual_text = false,
	signs = true,
})
-- vim.cmd([[ autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

-- DIAGNOSTICS ICONS
local diagnostic_signs = {
  { name = "DiagnosticSignError", text = "", texthl = "DiagnosticSignError" },
  { name = "DiagnosticSignWarn", text = "", texthl = "DiagnosticSignWarn" },
  { name = "DiagnosticSignInfo", text = "", texthl = "DiagnosticSignInfo" },
  { name = "DiagnosticSignHint", text = "", texthl = "DiagnosticSignHint" },
}

for _, sign in ipairs(diagnostic_signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.texthl, text = sign.text, numhl = "" })
end

-- SAVE FOLD ON FILE SAVE
local group = vim.api.nvim_create_augroup("AutoSaveFolds", { clear = true })

vim.api.nvim_create_autocmd({ "BufLeave" }, { command = "mkview", pattern = ".*", group = group })

vim.api.nvim_create_autocmd({ "BufEnter" }, { command = "loadview", pattern = ".*", group = group })

