-- requiring plugin
local installed, trm = pcall(require, "toggleterm")
if not installed then
	vim.notify("Plugin 'toggleterm' is not installed")
	return
end

trm.setup({
	open_mapping = "<C-b>",
	-- direction = "float",
	-- direction = "vertical",
	size = 20, -- Height of the terminal window
	hide_numbers = true, -- Hide line numbers in terminal buffers
	shade_terminals = true,
	shade_filetypes = {},
	shading_factor = 2, -- Amount of shading
	start_in_insert = true, -- Start in insert mode
	persist_size = true, -- Remember terminal size across sessions
	direction = "horizontal", -- 'vertical' | 'horizontal' | 'float'
	close_on_exit = true, -- Close terminal when process exits
	shell = vim.o.shell, -- Use the shell specified in your Neovim config
})

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
