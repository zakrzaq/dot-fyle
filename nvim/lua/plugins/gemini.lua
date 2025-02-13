local M = {}

function M.init()
	-- write functionaly to be executed
end

function M.setup()
	local installed, module = pcall(require, "gemini")
	if not installed then
		vim.notify("Plugin 'gemini' is not installed")
		return
	end

	M.init()

	module.setup({
		-- setup params here
	})
end

return M
