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
		enable_inline = false,
    -- inline = {
			-- 	adapter = "gemini",
			-- },
		adapters = {
			gemini = function()
				return require("codecompanion.adapters").extend("gemini", {
					env = {
						api_key = "GEMINI_API_KEY",
					},
				})
			end,
			anthropic = function()
				return require("codecompanion.adapters").extend("anthropic", {
					env = {
						api_key = "ANTHROPIC_KEY",
					},
				})
			end,
			llama3 = function()
				return require("codecompanion.adapters").extend("ollama", {
					name = "llama3",
					-- Give this adapter a different name to differentiate it from the default ollama adapter
					schema = {
						model = {
							default = "llama3:latest",
						},
						num_ctx = {
							default = 16384,
						},
						num_predict = {
							default = -1,
						},
					},
				})
			end,
		},
		strategies = {
			chat = {
				adapter = "gemini",
			},
		},
	})
end

return M
