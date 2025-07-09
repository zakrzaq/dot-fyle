local M = {}

function M.init()
	-- write functionaly to be executed
end

function M.setup()
	local installed, tterm = pcall(require, "toggleterm")
	if not installed then
		vim.notify("Plugin 'toggleterm' is not installed")
		return
	end

	M.init()

	tterm.setup({
		size = vim.o.columns * 0.4,
		persist_size = true,
		persist_mode = true,
		direction = 'vertical', -- 'vertical' | 'horizontal' | 'tab' | 'float',
		close_on_exit = true,
		clear_env = false,
		shell = vim.o.shell,
	})
end

return M
