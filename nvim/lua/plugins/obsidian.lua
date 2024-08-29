local M = {}

function M.init()
	--
end

function M.setup()
	local installed, obs = pcall(require, "obsidian")
	if not installed then
		vim.notify("Plugin 'obsidian' is not installed")
		return
	end

	M.init()

	obs.setup({
		workspaces = {
			{
				name = "personal",
				path = "~/notes",
			},
			{
				name = "work",
				path = "~/notes-dev",
			},
		},
	})
end

return M
