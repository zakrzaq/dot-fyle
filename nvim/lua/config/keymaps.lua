vim.g.mapleader = " "

-- Helper function for mapping multiple keys
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Basic mappings
map("i", "jj", "<ESC>")
map({ "n", "v" }, "nn", ":noh <CR>", { silent = true, desc = "No Highlight" })
map({ "i" }, "nnn", "<ESC>:noh<CR><ESC>i", { silent = true, desc = "No Highlight" })
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
  ["<C-k>"] = "k",
  ["<M-h>"] = "h",
  ["<M-j>"] = "j",
  ["<M-k>"] = "k",
  ["<M-l>"] = "l",
  ["<leader>h"] = "h",
  ["<leader>j"] = "j",
  ["<leader>k"] = "k",
  ["<leader>l"] = "l",
}
for key, dir in pairs(window_maps) do
  map("n", key, "<C-w>" .. dir)
end

map({ "n", "v" }, "<leader>p", "<C-w>s", { desc = "Split window horizontally" })
map({ "n", "v" }, "<leader>v", "<C-w>v", { desc = "Split window vertically" })

-- Buffer operations
map("n", "<C-q>", "<cmd>qa!<CR>", { desc = "[Q]uit nvim" })
map("n", "<space>w", "<cmd>write<cr>", { desc = "[W]rite changes" })
map("n", "<C-s>", "<cmd>Format<cr> <cmd>write<cr>", { desc = "[W]rite changes" })
map("n", "]b", "<cmd>bn<CR>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bp<CR>", { desc = "Previous buffer" })

-- Tab operations
map("n", "<C-q>", "<cmd>qa!<CR>", { desc = "[Q]uit nvim" })
map("n", "<space>w", "<cmd>write<cr>", { desc = "[W]rite changes" })
map("n", "<C-s>", "<cmd>Format<cr> <cmd>write<cr>", { desc = "[W]rite changes" })
map("n", "]b", "<cmd>bn<CR>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bp<CR>", { desc = "Previous buffer" })

-- Visual mode indentation
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Custom
map("n", "<C-f>", "<cmd>:silent !tmux neww tmux-sessionizer<CR>", { desc = "Create Tmux Session" })

-- Snacks
map({ "n", "v" }, "<leader>q", ":lua Snacks.bufdelete()<CR>", { silent = true, desc = "Delete buffer" })
map({ "n", "v" }, "<leader>Q", ":close<CR>", { silent = true, desc = "Close" })
map({ "n", "v" }, "<leader>e", ":lua Snacks.explorer()<CR>", { silent = true, desc = "Toggle Explorer" })
map({ "n", "v" }, "<C-b>", function()
  require("snacks").explorer()
end
, { silent = true, desc = "Toggle Explorer" })
map({ "n", "v" }, "<leader>gg", ":lua Snacks.lazygit()<CR>", { silent = true, desc = "Toggle LazyGit" })
map({ "n", "v" }, "<leader>rr", ":lua Snacks.rename_file()<CR>", { silent = true, desc = "Toggle LazyGit" })

map({ "n", "v" }, "<leader><space>", ":lua Snacks.picker.files()<CR>", { silent = true, desc = "Smart Find Files" })
map({ "n", "v" }, "<leader>,", ":lua Snacks.picker.buffers()<CR>", { silent = true, desc = "Buffers" })
map({ "n", "v" }, "<leader>/", ":lua Snacks.picker.grep()<CR>", { silent = true, desc = "Grep" })
map({ "n", "v" }, "<leader>:", ":lua Snacks.picker.command_history()<CR>", { silent = true, desc = "Command History" })
map(
  { "n", "v" },
  "<leader>n",
  ":lua Snacks.picker.notifications()<CR>",
  { silent = true, desc = "Notification History" }
)

map({ "n", "v" }, "<leader>fb", ":lua Snacks.picker.buffers()<CR>", { silent = true, desc = "Buffers" })
map(
  { "n", "v" },
  "<leader>fc",
  ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })<CR>",
  { silent = true, desc = "Find Config File" }
)
map({ "n", "v" }, "<leader>ff", ":lua Snacks.picker.files()<CR>", { silent = true, desc = "Find Files" })
map({ "n", "v" }, "<leader>fg", ":lua Snacks.picker.git_files() <CR>", { silent = true, desc = "Find Git Files" })
map({ "n", "v" }, "<leader>fp", ":lua Snacks.picker.projects() <CR>", { silent = true, desc = "Projects" })
map({ "n", "v" }, "<leader>fr", ":lua Snacks.picker.recent() <CR>", { silent = true, desc = "Recent" })

map({ "n", "v" }, "<leader>gb", ":lua Snacks.picker.git_branches() <CR>", { silent = true, desc = "Git Branches" })
map({ "n", "v" }, "<leader>gl", ":lua Snacks.picker.git_log() <CR>", { silent = true, desc = "Git Log" })
map({ "n", "v" }, "<leader>gL", ":lua Snacks.picker.git_log_line() <CR>", { silent = true, desc = "Git Log Line" })
map({ "n", "v" }, "<leader>gs", ":lua Snacks.picker.git_status() <CR>", { silent = true, desc = "Git Status" })
map({ "n", "v" }, "<leader>gS", ":lua Snacks.picker.git_stash() <CR>", { silent = true, desc = "Git Stash" })
map({ "n", "v" }, "<leader>gd", ":lua Snacks.picker.git_diff() <CR>", { silent = true, desc = "Git Diff (Hunks)" })
map({ "n", "v" }, "<leader>gf", ":lua Snacks.picker.git_log_file() <CR>", { silent = true, desc = "Git Log File" })

map({ "n", "v" }, "<leader>sb", ":lua Snacks.picker.lines() <CR>", { silent = true, desc = "Buffer Lines" })
map({ "n", "v" }, "<leader>.", ":lua Snacks.picker.lines() <CR>", { silent = true, desc = "Buffer Lines" })
map({ "n", "v" }, "<leader>sB", ":lua Snacks.picker.grep_buffers() <CR>", { silent = true, desc = "Grep Open Buffers" })
map({ "n", "v" }, "<leader>sg", ":lua Snacks.picker.grep() <CR>", { silent = true, desc = "Grep" })
map(
  { "n", "v" },
  "<leader>sw",
  ":lua Snacks.picker.grep_word() <CR>",
  { silent = true, desc = "Visual selection or word" }
)

map({ "n", "v" }, '<leader>s"', ":lua Snacks.picker.registers() <CR>", { silent = true, desc = "Registers" })
map({ "n", "v" }, "<leader>s/", ":lua Snacks.picker.search_history() <CR>", { silent = true, desc = "Search History" })
map({ "n", "v" }, "<leader>sa", ":lua Snacks.picker.autocmds() <CR>", { silent = true, desc = "Autocmds" })
map(
  { "n", "v" },
  "<leader>sc",
  ":lua Snacks.picker.command_history() <CR>",
  { silent = true, desc = "Command History" }
)
map({ "n", "v" }, "<leader>sC", ":lua Snacks.picker.commands() <CR>", { silent = true, desc = "Commands" })
map({ "n", "v" }, "<leader>sd", ":lua Snacks.picker.diagnostics() <CR>", { silent = true, desc = "Diagnostics" })
map({ "n", "v" }, "<leader>sD", ":lua Snacks.picker.diagnostics_buffer() <CR>", { silent = true, desc = "Diagnostics" })
map({ "n", "v" }, "<leader>sh", ":lua Snacks.picker.help() <CR>", { silent = true, desc = "Help Pages" })
map({ "n", "v" }, "<leader>sm", ":lua Snacks.picker.marks() <CR>", { silent = true, desc = "Marks" })
map({ "n", "v" }, "<leader>sp", ":lua Snacks.picker.lazy() <CR>", { silent = true, desc = "Search for Plugin Spec" })
map({ "n", "v" }, "<leader>su", ":lua Snacks.picker.undo() <CR>", { silent = true, desc = "Undo History" })
map({ "n", "v" }, "gd", ":lua Snacks.picker.lsp_definitions() <CR>", { silent = true, desc = "Goto Definition" })
map(
  { "n", "v" },
  "gr",
  ":lua Snacks.picker.lsp_references() <CR>",
  { silent = true, nowait = true, desc = "References" }
)
map({ "n", "v" }, "<leader>ss", ":lua Snacks.picker.lsp_symbols() <CR>", { silent = true, desc = "LSP Symbols" })
map(
  { "n", "v" },
  "<leader>sS",
  ":lua Snacks.picker.lsp_workspace_symbols() <CR>",
  { silent = true, desc = "LSP Workspace Symbols" }
)
map({ "n", "v" }, "<leader>st", ":lua Snacks.picker.todo_comments() <CR>", { silent = true, desc = "Todo" })
map(
  { "n", "v" },
  "<leader>sT",
  ":lua Snacks.picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME' } }) <CR>",
  { silent = true, desc = "Todo" }
)

---- Terminal
map({ "n", "v" }, "<leader>t", ":lua Snacks.terminal.toggle()<CR>", { silent = true, desc = "Toggle Terminal" })
map({ "t" }, "<leader>tt", function()
  require("snacks").terminal.toggle()
end
, { silent = true, desc = "Toggle Terminal" })
map({ "n", "v" }, "<C-j>", ":lua Snacks.terminal.toggle()<CR>", { silent = true, desc = "Toggle Terminal" })
map({ "t" }, "<C-j>", function()
  require("snacks").terminal.toggle()
end
, { silent = true, desc = "Toggle Terminal" })

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

-- DAP / debugger
map({ "n", "v" }, "<leader>dt", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle breakpoint", silent = true })
map({ "n", "v" }, "<leader>dc", function()
  require("dap").continue()
end, { desc = "Continue", silent = true })
map({ "n", "v" }, "<leader>di", function()
  require("dap").step_into()
end, { desc = "Step Into", silent = true })
map({ "n", "v" }, "<leader>do", function()
  require("dap").step_over()
end, { desc = "Step Over", silent = true })
map({ "n", "v" }, "<leader>du", function()
  require("dap").step_out()
end, { desc = "Step Out", silent = true })
map({ "n", "v" }, "<leader>dr", function()
  require("dap").repl.open()
end, { desc = "Open REPL", silent = true })
map({ "n", "v" }, "<leader>dl", function()
  require("dap").run_last()
end, { desc = "Run Last", silent = true })
map({ "n", "v" }, "<leader>dq", function()
  require("dap").terminate()
  require("dapui").close()
  require("nvim-dap-virtual-text").toggle()
end, { desc = "Terminate", silent = true })
map({ "n", "v" }, "<leader>db", function()
  require("dap").list_breakpoints()
end, { desc = "List reakpoints", silent = true })
map({ "n", "v" }, "<leader>de", function()
  require("dap").set_exception_breakpoints({ "all" })
end, { desc = "Set Exception Breakpoints", silent = true })

-- CodeCompanionChat
map({ "n", "v" }, "<leader>at", ":CodeCompanionChat Toggle<CR>", { silent = true, desc = "CodeCompanion Toggle" })
map({ "n", "v" }, "<C-M-i>", ":CodeCompanionChat Toggle<CR>", { silent = true, desc = "CodeCompanion Toggle" })
map({ "n", "v" }, "<leader>aa", ":CodeCompanionActions<CR>", { silent = true, desc = "CodeCompanion Actions" })
map({ "n", "v" }, "<leader>af", ":CodeCompanionChat Add<CR>", { silent = true, desc = "CodeCompanion Add" })
map({ "v" }, "<leader>ae", ":CodeCompanionChat Ask explain<CR>", { silent = true, desc = "Explain Code" })
map({ "v" }, "<leader>ar", ":CodeCompanionChat Ask review<CR>", { silent = true, desc = "Review Code" })
map({ "v" }, "<leader>ad", ":CodeCompanionChat Ask document<CR>", { silent = true, desc = "Document Code" })
map({ "v" }, "<leader>aT", ":CodeCompanionChat Ask test<CR>", { silent = true, desc = "Generate Tests" })
map({ "n" }, "<leader>ac", ":CodeCompanionChat Close<CR>", { silent = true, desc = "Close Current Chat" })
map({ "n" }, "<leader>an", ":CodeCompanionChat Rename<CR>", { silent = true, desc = "Rename Current Chat" })

-- Copilot
map("i", "<M-enter>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true

-- Other mappings
map({ "n", "v" }, "<leader>cp", "<cmd>:echo expand('%:p') <cr>", { desc = "[C]ode [P]ath", silent = true })

map({ "n", "v" }, "<leader>Rs", ":lua require('kulala').run() <CR>", { silent = true, desc = "Run Request" })
