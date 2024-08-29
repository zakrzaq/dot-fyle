-- requiring plugin
local installed, trm = pcall(require, "toggleterm")
if not installed then
	vim.notify("Plugin 'toggleterm' is not installed")
	return
end

trm.setup({
	open_mapping = "<C-b>",
	direction = "float",
	shade_terminals = true,
})
