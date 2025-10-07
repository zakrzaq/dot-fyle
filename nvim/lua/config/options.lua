vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.hidden = true
vim.opt.conceallevel = 2
vim.opt.foldmethod = "manual"
vim.opt.foldenable = true
vim.opt.spell = true
vim.opt.spelllang = { "en", "pl" }
vim.opt.spelloptions = "camel"
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/programming.utf-8.add"

-- CROSS SSH, SYSTEM CLIPBOARD
local function paste()
	return {
		vim.fn.split(vim.fn.getreg(""), "\n"),
		vim.fn.getregtype(""),
	}
end

vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = paste,
		["*"] = paste,
	},
}

vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- THEME BY TIME
-- local function set_theme_by_time()
--   local hour = tonumber(os.date("%H"))
--   local min = tonumber(os.date("%M"))
--   if (hour > 7 or (hour == 7 and min >= 0)) and (hour < 17 or (hour == 17 and min < 30)) then
--     vim.cmd("colorscheme rose-pine-dawn")
--   else
--     vim.cmd("colorscheme rose-pine-moon")
--   end
-- end

-- set_theme_by_time()
-- local timer = vim.loop.new_timer()
-- timer:start(0, 300000, vim.schedule_wrap(set_theme_by_time))

vim.cmd("colorscheme catppuccin-frappe")
