local M = {}

function M.init()
	-- write functionaly to be executed
end

function M.setup()
	local installed, module = pcall(require, "snacks")
	if not installed then
		vim.notify("Plugin 'snacks' is not installed")
		return
	end

	M.init()

	module.setup({
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		explorer = { enabled = true },
		input = { enabled = true },
		picker = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		indent = { enabled = true },
		lazygit = { enabled = true },
		rename = { enabled = true },
	})
end

return M
