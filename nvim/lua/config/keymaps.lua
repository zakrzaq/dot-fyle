vim.g.mapleader = " "

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

map("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })
map("n", "]t", ":tabnext<CR>", { desc = "Next tab" })
map("n", "[t", ":tabprevious<CR>", { desc = "Previous tab" })
map("n", "]b", ":bn<CR>", { desc = "Next tab" })
map("n", "[b", ":bp<CR>", { desc = "Previous tab" })
map('n', '<leader>z', '<C-^>', { noremap = true, silent = true })
map("v", "<", "<gv", { silent = true })
map("v", ">", ">gv", { silent = true })

map("n", "<C-q>", ":qa!<CR>", { desc = "Quit!" })
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>x", ":x<CR>", { desc = "Save and quit file" })
map("n", "<leader>q", ":bd<CR>", { desc = "Close buffer" })
map("n", "<leader>Q", "<C-w>c", { desc = "Close current pane/window" })

map("n", "<leader>uh", ":nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "<leader>ue", ":Explore<CR>", { desc = "Explorer" })
map("n", "<leader>ut", ":terminal<CR>", { desc = "Terminal" })
map({ "n", "v" }, "<leader>up", "<cmd>:echo expand('%:p') <cr>", { desc = "[C]ode [P]ath", silent = true })
map({ "n", "v" }, "<leader>ul", "<cmd>:colorscheme rose-pine-dawn<CR>", { desc = "[U]se [L]ight Theme" })
map({ "n", "v" }, "<leader>ud", "<cmd>:colorscheme nord<CR>", { desc = "[U]se [D]ark Theme" })

map("i", "jj", "<ESC>", { desc = "Escape" })
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map({ "n", "v" }, "<leader>y", '"+y', { desc = "[Y]ank to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "[P]aste from system clipboard" })

map("n", "gl", ":lua vim.diagnostic.open_float()<cr>", { desc = "Diagnostics float" })


local center_maps = { "<C-d>", "<C-u>", "n", "N" }
for _, key in ipairs(center_maps) do
  map("n", key, key .. "zz")
end


-- SNACKS
map({ "n", "v" }, "<leader>q", ":lua Snacks.bufdelete()<CR>", { silent = true, desc = "Delete buffer" })
map({ "n", "v" }, "<leader>Q", ":close<CR>", { silent = true, desc = "Close" })
map({ "n", "v" }, "<leader>e", ":lua Snacks.explorer()<CR>", { silent = true, desc = "Toggle Explorer" })
map({ "n", "v" }, "<C-b>", function()
  require("snacks").explorer()
end
, { silent = true, desc = "Toggle Explorer" })
map({ "n", "v" }, "<leader>gg", ":lua Snacks.lazygit()<CR>", { silent = true, desc = "Toggle LazyGit" })
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

-- TERMINAL
map({ "n", "v" }, "<leader>t", ":ToggleTerm<CR>", { silent = true, desc = "Toggle Terminal" })
map({ "t" }, "<leader>t", function()
  require("toggleterm").toggle()
end
, { silent = true, desc = "Toggle Terminal" })
map({ "n", "v" }, "<leader>tn", ":TermNew<CR>", { silent = true, desc = "Term New" })
map({ "n", "v" }, "<leader>ts", ":TermSelect<CR>", { silent = true, desc = "Term Select" })

-- OBSIDIAN
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
  require("dapui").toggle()
end, { desc = "Toggle UI", silent = true })
map({ "n", "v" }, "<leader>db", function()
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
map({ "n", "v" }, "<leader>dL", function()
  require("dap").list_breakpoints()
end, { desc = "List reakpoints", silent = true })
map({ "n", "v" }, "<leader>de", function()
  require("dap").set_exception_breakpoints({ "all" })
end, { desc = "Set Exception Breakpoints", silent = true })

-- CODE COMPANION
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

-- COPILOT
map("i", "<M-enter>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true

-- KULALA
map({ "n", "v" }, "<leader>Rs", ":lua require('kulala').run() <CR>", { silent = true, desc = "Run Request" })

-- LOAD PLUGINS
map("n", "<leader>Lk", function()
  require('plugins.kulala').setup()
end, { desc = "Enable Kulala" })
map("n", "<leader>Lo", function()
  require("plugins.obsidian").setup()
end, { desc = "Enable Obsidian" })
map("n", "<leader>Ld", function()
  require("plugins.dap").setup()
end, { desc = "Enable DAP" })

-- TRANSPARENCY
local is_transparent = false

function ToggleTransparency()
  is_transparent = not is_transparent

  if is_transparent then
    vim.cmd('hi Normal guibg=NONE')  
    vim.cmd('hi VertSplit guibg=NONE')  
    vim.cmd('hi StatusLine guibg=NONE')
  else
    vim.cmd('hi Normal guibg=#282828')
    vim.cmd('hi VertSplit guibg=#282828')
    vim.cmd('hi StatusLine guibg=#282828')
  end
end
-- Map the leader key to toggle transparency
map('n', '<Leader>uT', ':lua ToggleTransparency()<CR>', { noremap = true, silent = true })


