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


local function list_and_select_buffers()
  local bufs = vim.api.nvim_list_bufs()
  local buf_infos = {}

  for _, bufnr in ipairs(bufs) do
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buflisted then
      local fname = vim.api.nvim_buf_get_name(bufnr)
      table.insert(buf_infos, {
        nr = bufnr,
        name = fname == "" and "[No Name]" or vim.fn.fnamemodify(fname, ":t"),
        path = fname,
      })
    end
  end

  table.sort(buf_infos, function(a, b) return a.nr < b.nr end)

  local display_strings = {}
  for _, info in ipairs(buf_infos) do
    table.insert(display_strings, string.format("%d: %s", info.nr, info.name))
  end

  vim.ui.select(display_strings, {
    prompt = "Select a buffer:",
  }, function(choice)
    if not choice then return end
    -- Extract the buffer number from the start of the string
    local bufnr = tonumber(string.match(choice, "^%d+"))
    if bufnr then
      vim.api.nvim_set_current_buf(bufnr)
    end
  end)
end

vim.g.mapleader = " "
local keymap = vim.keymap.set

keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

keymap("n", "<leader>,", list_and_select_buffers, { desc = "List and select buffers" })

keymap("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
keymap("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })
keymap("n", "]t", ":tabnext<CR>", { desc = "Next tab" })
keymap("n", "[t", ":tabprevious<CR>", { desc = "Previous tab" })
keymap("n", "]b", ":bn<CR>", { desc = "Next tab" })
keymap("n", "[b", ":bp<CR>", { desc = "Previous tab" })
keymap('n', '<leader>z', '<C-^>', { noremap = true, silent = true })
keymap("v", "<", "<gv", { silent = true })
keymap("v", ">", ">gv", { silent = true })

keymap("n", "<C-q>", ":qa!<CR>", { desc = "Quit!" })
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>x", ":x<CR>", { desc = "Save and quit file" })
keymap("n", "<leader>q", ":bd<CR>", { desc = "Close buffer" })
keymap("n", "<leader>Q", "<C-w>c", { desc = "Close current pane/window" })

keymap("n", "<leader>uh", ":nohlsearch<CR>", { desc = "Clear search highlights" })
keymap("n", "<leader>ue", ":Explore<CR>", { desc = "Explorer" })
keymap("n", "<leader>ut", ":terminal<CR>", { desc = "Terminal" })
keymap({ "n", "v" }, "<leader>up", "<cmd>:echo expand('%:p') <cr>", { desc = "[C]ode [P]ath", silent = true })
keymap({ "n", "v" }, "<leader>ul", "<cmd>:colorscheme rose-pine-dawn<CR>", { desc = "[U]se [L]ight Theme" })
keymap({ "n", "v" }, "<leader>ud", "<cmd>:colorscheme nord<CR>", { desc = "[U]se [D]ark Theme" })

keymap("i", "jj", "<ESC>", { desc = "Escape" })
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")
keymap({ "n", "v" }, "<leader>y", '"+y', { desc = "[Y]ank to system clipboard" })
keymap({ "n", "v" }, "<leader>p", '"+p', { desc = "[P]aste from system clipboard" })

local center_maps = { "<C-d>", "<C-u>", "n", "N" }
for _, key in ipairs(center_maps) do
  keymap("n", key, key .. "zz")
end


vim.cmd("colorscheme retrobox")
