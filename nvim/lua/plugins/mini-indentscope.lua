local M = {}

function M.init()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = {
			"help",
			"alpha",
			"dashboard",
			"neo-tree",
			"Trouble",
			"lazy",
			"mason",
			"notify",
			"toggleterm",
			"lazyterm",
		},
		callback = function()
			vim.b.miniindentscope_disable = true
		end,
	})
end

function M.setup()
	local installed, ind = pcall(require, "mini.indentscope")
	if not installed then
		vim.notify("Plugin 'mini.indentscope' is not installed")
		return
	end

	M.init()

	ind.setup({
		-- symbol = "▏",
		symbol = "│",
		options = { try_as_border = true },
	})
end

return M
