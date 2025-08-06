local installed, conform = pcall(require, "conform")
if not installed then
	vim.notify("Plugin 'lualine' is not installed")
	return
end

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff", "black" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		vue = { "prettierd", "prettier", stop_after_first = true },
		markdown = { "prettierd", "prettier", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier", stop_after_first = true },
		sql = { "sqlfmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters = {
		ruff_format = {
			prepend_args = {},
		},
		black = {
			prepend_args = {},
		},
	},
})
