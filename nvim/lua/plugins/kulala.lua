local M = {}

function M.init()
	-- write functionaly to be executed
end

function M.setup()
	local installed, kulala = pcall(require, "kulala")
	if not installed then
		vim.notify("Plugin 'kulala' is not installed")
		return
	end

	M.init()

	kulala.setup({
		ui = {
			display_mode = "split",
			split_direction = "vertical",
			default_view = "body",
			winbar = true,
			default_winbar_panes = { "body", "headers", "headers_body", "verbose" },
			show_variable_info_text = false,
			show_icons = "on_request",
			icons = {
				inlay = {
					loading = "⏳",
					done = "✅",
					error = "❌",
				},
				lualine = "🐼",
				textHighlight = "WarningMsg", -- highlight group for request elapsed time
				lineHighlight = "Normal", -- highlight group for icons line highlight
			},
			show_request_summary = true,
			summaryTextHighlight = "Special",
		},
		global_keymaps = {
			["Send request"] = { -- sets global mapping
				"<leader>Rs",
				function()
					require("kulala").run()
				end,
				mode = { "n", "v" }, -- optional mode, default is n
				desc = "Send request", -- optional description, otherwise inferred from the key
			},
			["Send all requests"] = {
				"<leader>Ra",
				function()
					require("kulala").run_all()
				end,
				mode = { "n", "v" },
				ft = "http", -- sets mapping for *.http files only
			},
			["Replay the last request"] = {
				"<leader>Rr",
				function()
					require("kulala").replay()
				end,
				ft = { "http", "rest" }, -- sets mapping for specified file types
			},
			["Find request"] = false, -- set to false to disable
		},
		kulala_keymaps = {},
	})
end

return M
