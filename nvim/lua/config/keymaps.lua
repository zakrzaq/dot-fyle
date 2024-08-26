vim.g.mapleader = " "

vim.keymap.set("n", "<leader>ue", vim.cmd.Explore, { desc = "Nvim Explorer" })
vim.keymap.set("i", "jj", "<ESC>", { silent = true })

-- move selected up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- center screen when searching/navigating
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
-- vim.keymap.({ "n", "x" }, "x", '"_x')

-- COPY/PASTE --
vim.keymap.set({ "n", "v" }, "<C-a>", "ggVG", { desc = "Select [A]ll" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "[Y]ank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "[P]aste from system clipboard" })

-- GENERAL --
vim.keymap.set("n", "<C-q>", "<cmd>qa!<CR>", { desc = "[Q]uit nvim" })
vim.keymap.set("n", "<space>w", "<cmd>write<cr>", { desc = "[W]write changes" })
vim.keymap.set("n", "<C-s>", "<cmd>Format<cr> <cmd>write<cr>", { desc = "[W]write changes" })
vim.keymap.set("n", "]b", "<cmd>:bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", "<cmd>:bp<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<M-h>", "<C-w>h")
vim.keymap.set("n", "<M-j>", "<C-w>j")
vim.keymap.set("n", "<M-k>", "<C-w>k")
vim.keymap.set("n", "<M-l>", "<C-w>l")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Close buffer --
vim.keymap.set("n", "<leader>q", "<cmd>Bdelete<CR>", { desc = "[Q]uit current buffer" })

-- NeoGit --
vim.keymap.set("n", "<leader>gn", "<cmd>:Neogit<CR>", { desc = "[N]eo[G]it" })

-- CUSTOM --
vim.keymap.set("n", "<C-f>", "<cmd>:silent !tmux neww tmux-sessionizer<CR>", { desc = "Create Tmux Session" })

-- TELESCOPE --
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "[F]ind existing [b]uffers" })
vim.keymap.set("n", "<leader>/", function()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = true,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").find_files, { desc = "Search Files" })
vim.keymap.set("n", "<C-p>", require("telescope.builtin").git_files, { desc = "Search Git Files" })

vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [h]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [w]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [g]rep" })
vim.keymap.set(
	"n",
	"<leader>sb",
	require("telescope.builtin").current_buffer_fuzzy_find,
	{ desc = "[S]earch in [b]uffer" }
)
vim.keymap.set(
	"n",
	"<leader>sd",
	require("telescope.builtin").diagnostics,
	{ desc = "[S]earch buffer [D]iagnostics" }
)
vim.keymap.set("n", "<leader>st", "<cmd>:TodoTelescope<CR>", { desc = "[S]earch [T]odos" })
vim.keymap.set("n", "<leader>ss", "<cmd>:Telescope lsp_document_symbols<CR>", { desc = "[S]earch document [s]ymbol" })
vim.keymap.set(
	"n",
	"<leader>sS",
	require("telescope.builtin").lsp_dynamic_workspace_symbols,
	{ desc = "[S]earch workspace [S]ymbol" }
)
vim.keymap.set("n", "<leader>sc", function()
	require("telescope.builtin").lsp_document_symbols({ symbols = { "class" } })
end, { desc = "[S]earch document [c]lasses" })
vim.keymap.set("n", "<leader>sf", function()
	require("telescope.builtin").lsp_document_symbols({ symbols = { "function" } })
end, { desc = "[S]earch document [f]functions" })
vim.keymap.set("n", "<leader>sm", function()
	require("telescope.builtin").lsp_document_symbols({ symbols = { "method" } })
end, { desc = "[S]earch document [m]ethods" })
vim.keymap.set("n", "<leader>sr", function()
	require("telescope.builtin").marks()
end, { desc = "[S]earch ma[r]ks" })
vim.keymap.set("n", "<leader>gs", "<cmd>:Telescope git_status<CR>", { desc = "[G]it [S]atus" })
vim.keymap.set("n", "<leader>gc", "<cmd>:Telescope git_commits<CR>", { desc = "[G]it [C]ommits" })
vim.keymap.set("n", "<leader>gb", "<cmd>:Telescope git_branches<CR>", { desc = "[G]it [B]ranches" })
vim.keymap.set("n", "<leader>gt", "<cmd>:Telescope git_stash<CR>", { desc = "[G]it s[T]ash" })
vim.keymap.set(
	"n",
	"<leader>gl",
	"<cmd>:Gitsigns toggle_current_line_blame<cr>",
	{ silent = true, desc = "[G]it b[L]ame line" }
)
vim.keymap.set("n", "<leader>gL", "<cmd>:Gitsigns blame_line<CR>", { desc = "[G]it b[L]ame popup" })

-- NEOTREE --
vim.keymap.set({ "n", "v" }, "<leader>t", ":Neotree toggle<CR>", { silent = true, desc = "Neo[T]ree Toggle" })

-- URL-OPEN --
vim.keymap.set(
	"n",
	"<leader>uo",
	"<esc>:URLOpenUnderCursor<cr>",
	{ silent = true, desc = "[u][u]RL under cursor open" }
)
vim.keymap.set("n", "<leader>us", "<esc>:URLOpenHighlightAll<cr>", { silent = true, desc = "[u]RL highlight all" })
vim.keymap.set(
	"n",
	"<leader>uS",
	"<esc>:URLOpenHighlightAllClear<cr>",
	{ silent = true, desc = "[u]RL clear highlight all" }
)

-- TROUBLE --
vim.keymap.set("n", "<leader>xx", function()
	require("trouble").toggle()
end, { desc = "toggle diagnosti[X]" })
vim.keymap.set("n", "<leader>xw", function()
	require("trouble").toggle("workspace_diagnostics")
end, { desc = "toggle [W]orkspace diagnostics" })
vim.keymap.set("n", "<leader>xd", function()
	require("trouble").toggle("document_diagnostics")
end, { desc = "toggle [D]ocument diagnostics" })
vim.keymap.set("n", "<leader>xq", function()
	require("trouble").toggle("quickfix")
end, { desc = "toggle [Q]uickfix" })
vim.keymap.set("n", "<leader>xl", function()
	require("trouble").toggle("loclist")
end, { desc = "toggle [L]loclist" })
vim.keymap.set("n", "gR", function()
	require("trouble").toggle("lsp_references")
end)

-- POMODORO --
vim.keymap.set("n", "<leader>pss", "<cmd>:TimerStart 25m<cr>", { desc = "Start [P]omodoro 25m", silent = true })
vim.keymap.set("n", "<leader>psl", "<cmd>:TimerStart55m<cr>", { desc = "Start [P]omodoro 55m", silent = true })
vim.keymap.set("n", "<leader>pb5", "<cmd>:TimerStart 5m<cr>", { desc = "Start [P]omodoro break 5m", silent = true })
vim.keymap.set("n", "<leader>pbl", "<cmd>:TimerStart 15m<cr>", { desc = "Start [P]omodoro break 15m", silent = true })
vim.keymap.set("n", "<leader>pe", "<cmd>:TimerStop<cr>", { desc = "Stop [P]omodoro", silent = true })
vim.keymap.set("n", "<leader>pp", "<cmd>:TimerPause<cr>", { desc = "Pause [P]omodoro", silent = true })
vim.keymap.set("n", "<leader>pr", "<cmd>:TimerResume<cr>", { desc = "Resume [P]omodoro", silent = true })
vim.keymap.set("n", "<leader>pns", "<cmd>:TimerShow<cr>", { desc = "[P]omodoro [n]otification [s]how", silent = true })
vim.keymap.set("n", "<leader>pnh", "<cmd>:TimerHide<cr>", { desc = "[P]omodoro [n]otification [h]ide", silent = true })

-- OBSIDIAN --
vim.keymap.set(
	{ "n", "v" },
	"<leader>oo",
	"<cmd>:ObsidianQuickSwitch<cr>",
	{ desc = "[O]bsidian [o]pen", silent = true }
)
vim.keymap.set({ "n", "v" }, "<leader>os", "<cmd>:ObsidianSearch<cr>", { desc = "[O]bsidian [s]earch", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>on", "<cmd>:ObsidianNew<cr>", { desc = "[O]bsidian [n]new note", silent = true })
vim.keymap.set(
	{ "n", "v" },
	"<leader>or",
	"<cmd>:ObsidianRename<cr>",
	{ desc = "[O]bsidian [r]ename note", silent = true }
)
vim.keymap.set({ "n", "v" }, "<leader>ot", "<cmd>:ObsidianToday<cr>", { desc = "[O]bsidian [t]odayn", silent = true })
vim.keymap.set(
	{ "n", "v" },
	"<leader>oy",
	"<cmd>:ObsidianYesterday<cr>",
	{ desc = "[O]bsidian [y]esterday", silent = true }
)
vim.keymap.set(
	{ "n", "v" },
	"<leader>om",
	"<cmd>:ObsidianTomorrow<cr>",
	{ desc = "[O]bsidian to[m]orrow", silent = true }
)
vim.keymap.set(
	{ "n", "v" },
	"<leader>ol",
	"<cmd>:ObsidianTemplate<cr>",
	{ desc = "[O]bsidian temp[l]ete", silent = true }
)
vim.keymap.set(
	{ "n", "v" },
	"<leader>oe",
	"<cmd>:ObsidianExtractNote <cr>",
	{ desc = "[O]bsidian [e]extract to new note", silent = true }
)
vim.keymap.set(
	{ "n", "v" },
	"<leader>ow",
	"<cmd>:ObsidianWorkspace <cr>",
	{ desc = "[O]bsidian [e]extract to new note", silent = true }
)

-- DADBOD --
vim.keymap.set({ "n", "v" }, "<leader>du>", "<cmd>:DBUI<cr>", { desc = "[D]adbod [U]I", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>dt>", "<cmd>:DBUIToggle<cr>", { desc = "[D]adbod [T]ogge", silent = true })
vim.keymap.set(
	{ "n", "v" },
	"<leader>da>",
	"<cmd>:DBUIAddConnection<cr>",
	{ desc = "[D]adbod [A]dd connection", silent = true }
)
vim.keymap.set(
	{ "n", "v" },
	"<leader>df>",
	"<cmd>:DBUIFindBuffer<cr>",
	{ desc = "[D]adbod [F]ind buffer", silent = true }
)
vim.keymap.set(
	{ "n", "v" },
	"<leader>ds",
	":lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>(DBUI_SaveQuery)', true, true, true), 'n', false)",
	{ desc = "[D]adbod [S]ave query", silent = true }
)
-- THEMES --
vim.keymap.set(
	{ "n", "v" },
	"<leader>lrd",
	"<cmd>:colorscheme rose-pine<cr>",
	{ desc = "[L]ook [R]ose-Pine [D]ark", silent = true }
)
vim.keymap.set(
	{ "n", "v" },
	"<leader>lrl",
	"<cmd>:colorscheme rose-pine-dawn<cr>",
	{ desc = "[L]ook [R]ose-Pine [L]ight", silent = true }
)

-- OTHER --
vim.keymap.set({ "n", "v" }, "<leader>cp", "<cmd>:echo expand('%:p') <cr>", { desc = "[C]ode [P]ath", silent = true })
vim.keymap.set({ "n", "v" }, "<leader>fd", function()
	require("telescope.builtin").find_files({ search_dirs = { "~/dot_jake" } })
end, { desc = "[F]ind in [D]otfiles" })
vim.keymap.set({ "n", "v" }, "<leader>fc", function()
	require("telescope.builtin").find_files({ search_dirs = { "~/cht" } })
end, { desc = "[F]ind [C]heats" })
