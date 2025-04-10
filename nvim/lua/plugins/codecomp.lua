local M = {}

function M.init()
	-- write functionaly to be executed
end

function M.setup()
	local installed, module = pcall(require, "codecompanion")
	if not installed then
		vim.notify("Plugin 'codecompanion' is not installed")
		return
	end

	M.init()

	module.setup({
		strategies = {
			chat = {
				adapter = "gemini",
			},
			inline = {
				adapter = "copilot",
			},
		},
		adapters = {
			opts = {
				show_defaults = false,
			},
			gemini = function()
				return require("codecompanion.adapters").extend("gemini", {
					env = {
						api_key = vim.env.GEMINI_API_KEY,
					},
				})
			end,
			copilot = function()
				return require("codecompanion.adapters").extend("copilot")
			end,

			ollama = function()
				return require("codecompanion.adapters").extend("ollama", {
					env = {
						url = vim.env.OLLAMA_URL,
						api_key = "OLLAMA_API_KEY",
					},
					schema = {
						model = {
							default = "qwen2.5-coder:14b",
						},
						num_ctx = {
							default = 16384,
						},
						num_predict = {
							default = -1,
						},
					},
					headers = {
						["Content-Type"] = "application/json",
						["Authorization"] = "Bearer ${api_key}",
					},
					parameters = {
						sync = true,
					},
				})
			end,
		},
	})
end

return M
