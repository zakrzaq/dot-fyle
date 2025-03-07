-- VIRTUAL TEXT OFF
vim.diagnostic.config({
	float = {
		source = true,
		border = "rounded",
		header = "",
		prefix = "",
		format = function(diagnostic)
			return string.format("%s (%s)", diagnostic.message, diagnostic.source)
		end,
	},
	virtual_text = false,
	-- virtual_text = {
	-- 	prefix = "●", -- Could be '●', '▎', 'x'
	-- 	spacing = 4,
	-- },
	-- signs = true,
})

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
vim.opt.viewoptions:append("folds") -- Ensure folds are included in viewoptions
local group = vim.api.nvim_create_augroup("AutoSaveFolds", { clear = true })

vim.api.nvim_create_autocmd({ "BufWinLeave" }, { command = "mkview", pattern = ".*", group = group })
vim.api.nvim_create_autocmd({ "BufWinEnter" }, { command = "loadview", pattern = ".*", group = group })

-- SPELL CHECKER
local spell_dir = vim.fn.stdpath("config") .. "/spell"
if vim.fn.isdirectory(spell_dir) == 0 then
	vim.fn.mkdir(spell_dir, "p")
end

-- COPILOT SYNTAX HIGHLIGHT
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "nordic",
	-- group = ...,
	callback = function()
		vim.api.nvim_set_hl(0, "CopilotSuggestion", {
			fg = "#555555",
			ctermfg = 8,
			force = true,
		})
	end,
})
