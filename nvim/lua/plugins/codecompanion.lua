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
			copilot = function()
				return require("codecompanion.adapters").extend("copilot")
			end,
			-- VER.2 of remote access
			-- ollama_remote = function()
			-- 	return require("codecompanion.adapters").extend("ollama", {
			-- 		name = "ollama_remote",
			-- 		env = {
			-- 			url = os.getenv("OLLAMA_URL") or "http://192.168.21.15:11434/api/generate",
			-- 			-- "https://my_ollama_url",
			-- 			api_key = "OLLAMA_API_KEY",
			-- 		},
			-- 		headers = {
			-- 			["Content-Type"] = "application/json",
			-- 			["Authorization"] = "Bearer ${api_key}",
			-- 		},
			-- 		parameters = {
			-- 			sync = true,
			-- 		},
			-- 		schema = {
			-- 			model = {
			-- 				default = "llama3.1:70b",
			-- 			},
			-- 			num_ctx = {
			-- 				default = 16384,
			-- 			},
			-- 			num_predict = {
			-- 				default = -1,
			-- 			},
			-- 		},
			-- 	})
			-- end,
			llama3 = function()
				return require("codecompanion.adapters").extend("ollama", {
					name = "oberon",
					-- Give this adapter a different name to differentiate it from the default ollama adapter
					schema = {
						model = {
							-- default = "qwen2.5-coder:latest",
							default = "qwen2.5:3b",
						},
						num_ctx = {
							default = 16384,
						},
						num_predict = {
							default = -1,
						},
						url = {
							default = os.getenv("OLLAMA_URL") or "http://192.168.21.20:11434/api/generate",
						},
					},
				})
			end,
		},
		strategies = {
			chat = {
				adapter = "copilot",
			},
		},
		display = {
			action_palette = {
				width = 45,
				height = 10,
				prompt = "Prompt ",              -- Prompt used for interactive LLM calls
				provider = "telescope",          -- default|telescope|mini_pick
				opts = {
					show_default_actions = true,   -- Show the default actions in the action palette?
					show_default_prompt_library = true, -- Show the default prompt library in the action palette?
				},
			},
		},
	})
end

return M
