require("plugins.lazy")

require("plugins.lualine")
require("plugins.treesitter")
require("plugins.gitsigns").setup()
require("plugins.lsp")
require("plugins.autocmp")
require("plugins.conform")
require("plugins.dap").setup()
require("plugins.toggleterm").setup()

require("plugins.obsidian").setup()
require("plugins.codecomp").setup()
require("plugins.snacks").setup()
require("plugins.kulala").setup()

require("config.options")
require("config.autocmd")
require("config.keymaps")

if not vim.g.isPwC then
  require("plugins.codeium").setup()
end

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

vim.cmd("colorscheme everforest")
