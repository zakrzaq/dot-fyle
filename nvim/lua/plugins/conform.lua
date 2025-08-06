local installed, conform = pcall(require, "conform")
if not installed then
	vim.notify("Plugin 'conform' is not installed")
	return
end

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff", "black", stop_after_first = true },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		vue = { "prettierd", "prettier", stop_after_first = true },
		markdown = { "prettierd", "prettier", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier", stop_after_first = true },
		sql = { "sqruff" },
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
