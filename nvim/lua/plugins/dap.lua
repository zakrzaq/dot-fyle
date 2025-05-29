local M = {}

function M.init()
	-- Add any custom initialization logic here
end

function M.setup()
	local installed, dap = pcall(require, "dap")
	if not installed then
		vim.notify("Plugin 'dap' is not installed")
		return
	end

	local mason_dap = require("mason-nvim-dap")
	local ui = require("dapui")
	require("nvim-dap-virtual-text").setup()

	mason_dap.setup({
		ensure_installed = { "python", "node2", "chrome", "js" },
		automatic_installation = true,
		handlers = {
			function(config)
				require("mason-nvim-dap").default_setup(config)
			end,
		},
	})

	ui.setup()

	-- Define breakpoint sign
	vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

	-- Auto-open and close dapui
	-- dap.listeners.before.attach.dapui_config = function()
	-- 	ui.open()
	-- end
	dap.listeners.before.event_initialized.dapui_config = function()
		ui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		-- ui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		-- ui.close()
	end

	M.init()

	-- Configure Python adapter
	-- dap.adapters.python = {
	-- 	type = "executable",
	-- 	command = vim.fn.exepath("python") or "python",
	-- 	args = { "-m", "debugpy.adapter" },
	-- }
	-- dap.adapters.python = {
	-- 	type = "executable",
	-- 	command = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python",
	-- 	args = { "-m", "debugpy.adapter" },
	-- }

	-- Debug configurations for Python
	dap.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			pythonPath = function()
				-- Detect the Python executable from a virtual environment
				local cwd = vim.fn.getcwd()
				if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
					return cwd .. "/.venv/bin/python"
				elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
					return cwd .. "/venv/bin/python"
				elseif vim.fn.executable(cwd .. "/.venv/Scripts/python.exe") == 1 then
					return cwd .. "/.venv/Scripts/python.exe" -- Windows
				elseif vim.fn.executable(cwd .. "/venv/Scripts/python.exe") == 1 then
					return cwd .. "/venv/Scripts/python.exe" -- Windows
				else
					return vim.fn.exepath("python") -- Fallback
				end
			end,
		},
	}
end

return M
