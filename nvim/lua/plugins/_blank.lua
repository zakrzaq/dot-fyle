local M = {}

function M.init()
	-- write functionaly to be executed
end

function M.setup()
	local installed, module = pcall(require, "<package-name>")
	if not installed then
		vim.notify("Plugin '<package-name>' is not installed")
		return
	end

	M.init()

	module.setup({
		-- setup params here
	})
end

return M
