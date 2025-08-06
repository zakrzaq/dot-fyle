require("plugins.lazy")

require("plugins.lualine")
require("plugins.treesitter").setup()
require("plugins.gitsigns").setup()
require("plugins.lsp").setup()
require("plugins.autocmp")
require("plugins.conform")
require("plugins.toggleterm").setup()
require("plugins.snacks").setup()

require("plugins.codecomp").setup()
require("plugins.codeium").setup()

require("config.options")
require("config.autocmd")
require("config.keymaps")
