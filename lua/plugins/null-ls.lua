-- requiring plugin
local installed, nls = pcall(require, "null-ls")
if not installed then
	vim.notify("Plugin 'null-ls' is not installed")
	return
end

-- Setting up Null_ls
local formatting = nls.builtins.formatting
local diagnostics = nls.builtins.diagnostics
local code_actions = nls.builtins.code_actions
local sources = {
	formatting.stylua,
	formatting.prettierd,
	formatting.isort,
	formatting.black,
	diagnostics.cspell.with({
		diagnostics_postprocess = function(diagnostic)
			diagnostic.severity = vim.diagnostic.severity.HINT
		end,
	}),
	diagnostics.luacheck,
	-- diagnostics.eslint,
	diagnostics.ruff,
	code_actions.cspell,
	code_actions.eslint,
}

nls.setup({
	sources = sources,
})
