require("plugins.lazy")

require("plugins.lualine")
require("plugins.treesitter")
require("plugins.gitsigns").setup()
require("plugins.lsp")
require("plugins.autocmp")
require("plugins.conform")

require("plugins.obsidian").setup()
require("plugins.codeium").setup()
require("plugins.codecomp").setup()
require("plugins.snacks").setup()
require("plugins.kulala").setup()

require("config.options")
require("config.autocmd")
require("config.keymaps")
