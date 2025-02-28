vim.g.mapleader = " "

-- Helper function for mapping multiple keys
local function map(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.silent = opts.silent ~= false
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Basic mappings
map("i", "jj", "<ESC>")
map("n", "<leader>ue", vim.cmd.Explore, { desc = "Nvim Explorer" })
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Center screen mappings
local center_maps = { "<C-d>", "<C-u>", "n", "N" }
for _, key in ipairs(center_maps) do
	map("n", key, key .. "zz")
end

-- Clipboard operations
map({ "n", "v" }, "<leader>y", '"+y', { desc = "[Y]ank to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "[P]aste from system clipboard" })

-- Window navigation
local window_maps = {
	["<C-h>"] = "h",
	["<C-l>"] = "l",
	["<M-h>"] = "h",
	["<M-j>"] = "j",
	["<M-k>"] = "k",
	["<M-l>"] = "l",
}
for key, dir in pairs(window_maps) do
	map("n", key, "<C-w>" .. dir)
end

-- Buffer operations
map("n", "<C-q>", "<cmd>qa!<CR>", { desc = "[Q]uit nvim" })
map("n", "<space>w", "<cmd>write<cr>", { desc = "[W]rite changes" })
map("n", "<C-s>", "<cmd>Format<cr> <cmd>write<cr>", { desc = "[W]rite changes" })
map("n", "]b", "<cmd>bn<CR>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bp<CR>", { desc = "Previous buffer" })
map("n", "<leader>q", "<cmd>Bdelete<CR>", { desc = "[Q]uit current buffer" })

-- Visual mode indentation
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Custom
map("n", "<C-f>", "<cmd>:silent !tmux neww tmux-sessionizer<CR>", { desc = "Create Tmux Session" })

-- Telescope mappings
local telescope = require("telescope.builtin")
local telescope_maps = {
	["<leader>?"] = { telescope.oldfiles, "Find recently opened files" },
	["<leader>fb"] = { telescope.buffers, "Find existing buffers" },
	["<leader><space>"] = { telescope.find_files, "Search Files" },
	["<C-p>"] = { telescope.git_files, "Search Git Files" },
	["<leader>sh"] = { telescope.help_tags, "Search help" },
	["<leader>sw"] = { telescope.grep_string, "Search current word" },
	["<leader>sg"] = { telescope.live_grep, "Search by grep" },
	["<leader>sd"] = { telescope.diagnostics, "Search buffer Diagnostics" },
	["<leader>ss"] = { "<cmd>:Telescope lsp_document_symbols<CR>", "Search document symbol" },
	["<leader>sS"] = { telescope.lsp_dynamic_workspace_symbols, "Search workspace Symbol" },
}

for key, value in pairs(telescope_maps) do
	map("n", key, value[1], { desc = value[2] })
end

-- Fuzzy find in current buffer
map("n", "<leader>/", function()
	telescope.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = true,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

-- Symbol search mappings
local symbol_maps = {
	["<leader>sc"] = "class",
	["<leader>sf"] = "function",
	["<leader>sm"] = "method",
}

for key, symbol in pairs(symbol_maps) do
	map("n", key, function()
		telescope.lsp_document_symbols({ symbols = { symbol } })
	end, { desc = string.format("[S]earch document %ss", symbol) })
end

map("n", "<leader>sr", function()
	telescope.marks()
end, { desc = "[S]earch ma[r]ks" })

-- Git mappings
local git_maps = {
	["<leader>gs"] = { "git_status", "[G]it [S]atus" },
	["<leader>gc"] = { "git_commits", "[G]it [C]ommits" },
	["<leader>gb"] = { "git_branches", "[G]it [B]ranches" },
	["<leader>gt"] = { "git_stash", "[G]it s[T]ash" },
}

for key, value in pairs(git_maps) do
	map("n", key, "<cmd>:Telescope " .. value[1] .. "<CR>", { desc = value[2] })
end

map("n", "<leader>gl", "<cmd>:Gitsigns toggle_current_line_blame<cr>", { silent = true, desc = "[G]it b[L]ame line" })
map("n", "<leader>gL", "<cmd>:Gitsigns blame_line<CR>", { desc = "[G]it b[L]ame popup" })

-- Neotree and Terminal
map({ "n", "v" }, "<leader>t", ":Neotree toggle<CR>", { silent = true, desc = "Neo[T]ree Toggle" })
map({ "n", "v" }, "<leader>b", ":ToggleTerm<CR>", { silent = true, desc = "Terminal Toggle" })

-- Terminal numbers
for i = 1, 4 do
	map({ "n", "v" }, "<leader>" .. i, ":ToggleTerm " .. i .. "<CR>", { desc = "Terminal " .. i, silent = true })
end

-- URL handling
map("n", "<leader>uo", "<esc>:URLOpenUnderCursor<cr>", { silent = true, desc = "[u][u]RL under cursor open" })
map("n", "<leader>us", "<esc>:URLOpenHighlightAll<cr>", { silent = true, desc = "[u]RL highlight all" })
map("n", "<leader>uS", "<esc>:URLOpenHighlightAllClear<cr>", { silent = true, desc = "[u]RL clear highlight all" })

-- Pomodoro mappings
local pomodoro_maps = {
	["<leader>pss"] = { "25m", "Start [P]omodoro 25m" },
	["<leader>psl"] = { "55m", "Start [P]omodoro 55m" },
	["<leader>pb5"] = { "5m", "Start [P]omodoro break 5m" },
	["<leader>pbl"] = { "15m", "Start [P]omodoro break 15m" },
}

for key, value in pairs(pomodoro_maps) do
	map("n", key, "<cmd>:TimerStart " .. value[1] .. "<cr>", { desc = value[2], silent = true })
end

local pomodoro_commands = {
	["<leader>pe"] = { "Stop", "Stop [P]omodoro" },
	["<leader>pp"] = { "Pause", "Pause [P]omodoro" },
	["<leader>pr"] = { "Resume", "Resume [P]omodoro" },
	["<leader>pns"] = { "Show", "[P]omodoro [n]otification [s]how" },
	["<leader>pnh"] = { "Hide", "[P]omodoro [n]otification [h]ide" },
}

for key, value in pairs(pomodoro_commands) do
	map("n", key, "<cmd>:Timer" .. value[1] .. "<cr>", { desc = value[2], silent = true })
end

-- Obsidian mappings
local obsidian_maps = {
	["<leader>oo"] = { "QuickSwitch", "[O]bsidian [o]pen" },
	["<leader>os"] = { "Search", "[O]bsidian [s]earch" },
	["<leader>on"] = { "New", "[O]bsidian [n]new note" },
	["<leader>or"] = { "Rename", "[O]bsidian [r]ename note" },
	["<leader>ot"] = { "Today", "[O]bsidian [t]oday" },
	["<leader>oy"] = { "Yesterday", "[O]bsidian [y]esterday" },
	["<leader>om"] = { "Tomorrow", "[O]bsidian to[m]orrow" },
	["<leader>ol"] = { "Template", "[O]bsidian temp[l]ate" },
	["<leader>oe"] = { "ExtractNote", "[O]bsidian [e]xtract to new note" },
	["<leader>ow"] = { "Workspace", "[O]bsidian [w]orkspace" },
}

for key, value in pairs(obsidian_maps) do
	map({ "n", "v" }, key, "<cmd>:Obsidian" .. value[1] .. "<cr>", { desc = value[2], silent = true })
end

-- Dadbod mappings
local dadbod_maps = {
	["<leader>du"] = { "DBUI", "[D]adbod [U]I" },
	["<leader>dt"] = { "DBUIToggle", "[D]adbod [T]oggle" },
	["<leader>da"] = { "DBUIAddConnection", "[D]adbod [A]dd connection" },
	["<leader>df"] = { "DBUIFindBuffer", "[D]adbod [F]ind buffer" },
}

for key, value in pairs(dadbod_maps) do
	map({ "n", "v" }, key, "<cmd>:" .. value[1] .. "<cr>", { desc = value[2], silent = true })
end

map(
	{ "n", "v" },
	"<leader>ds",
	":lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>(DBUI_SaveQuery)', true, true, true), 'n', false)",
	{ desc = "[D]adbod [S]ave query", silent = true }
)

-- Theme mappings
local themes = {
	["lrd"] = "rose-pine-main",
	["ln"] = "nordic",
	["lrl"] = "rose-pine-dawn",
	["lkk"] = "kanagawa",
	["lkl"] = "kanagawa-lotus",
	["lyy"] = "tokyonight-night",
	["lyr"] = "tokyonight-day",
	["lcc"] = "catppuccin-mocha",
	["lcl"] = "catppuccin-latte",
}

for key, theme in pairs(themes) do
	map(
		{ "n", "v" },
		"<leader>" .. key,
		"<cmd>colorscheme " .. theme .. "<cr>",
		{ desc = "Theme: " .. theme, silent = true }
	)
end

-- Other mappings
map({ "n", "v" }, "<leader>cp", "<cmd>:echo expand('%:p') <cr>", { desc = "[C]ode [P]ath", silent = true })
map({ "n", "v" }, "<leader>fd", function()
	telescope.find_files({ search_dirs = { "~/dot_jake" } })
end, { desc = "[F]ind in [D]otfiles" })
map({ "n", "v" }, "<leader>fc", function()
	telescope.find_files({ search_dirs = { "~/cht" } })
end, { desc = "[F]ind [C]heats" })

-- AI Tools
map(
	{ "n", "v" },
	"<leader>ia",
	"<cmd>CodeCompanionActions<cr>",
	{ noremap = true, silent = true, desc = "CC Actions" }
)
map(
	{ "n", "v" },
	"<leader>it",
	"<cmd>CodeCompanionChat Toggle<cr>",
	{ noremap = true, silent = true, desc = "cc chat" }
)
