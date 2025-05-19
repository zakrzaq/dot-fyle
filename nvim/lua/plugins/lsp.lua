local util = require("lspconfig/util")

-- Function to define keymaps when an LSP client attaches to a buffer
local on_attach = function(_, bufnr)
	-- Helper function for creating normal mode keymaps
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	-- Define LSP keymaps
	nmap("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<leader>K", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Keymaps for diagnostics (errors, warnings, etc.)
	nmap("gl", "<cmd>lua vim.diagnostic.open_float()<cr>", "Open floating diagnostics window")
	nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Go to previous diagnostic")
	nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Go to next diagnostic")

	-- Buffer-local command to format the buffer using conform.nvim
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		require("conform").format({ bufnr = bufnr }) -- Specify buffer number for precision
	end, { desc = "Format current buffer with LSP" })
end

-- Define default settings for each LSP server
-- These settings will be merged with the default lspconfig settings
local servers = {
	volar = {
		filetypes = { "vue", "json" }, -- Specify filetypes for volar
	},
	ts_ls = { -- TypeScript Language Server
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
	},
	ruff = {}, -- Ruff (Python linter/formatter)
	pyright = {}, -- Pyright (Python static analysis)
	html = {}, -- HTML Language Server
	cssls = {}, -- CSS Language Server
	tailwindcss = {}, -- Tailwind CSS Language Server
	emmet_ls = {}, -- Emmet Language Server
	sqlls = {}, -- SQL Language Server
	marksman = {}, -- Markdown Language Server
	dotls = {}, -- Dot Language Server (Graphviz)
	bashls = {}, -- Bash Language Server
	jsonls = {}, -- JSON Language Server
	lua_ls = { -- Lua Language Server
		settings = { -- Use 'settings' key for server-specific settings
			Lua = {
				workspace = { checkThirdParty = false },
				telemetry = { enable = false },
				diagnostics = { globals = { "vim" } }, -- Add 'vim' to recognized globals
			},
		},
	},
}

-- Setup neodev.nvim for better Neovim Lua development experience
require("neodev").setup()

-- Define capabilities for LSP client (used by nvim-cmp)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Define additional tools to be installed by mason (formatters, linters, etc.)
local additional_tools = {
	"stylua",      -- Lua formatter
	"eslint_d",    -- ESLint daemon
	"prettier",    -- Prettier (general code formatter)
	"prettier_d",  -- Prettier daemon
	"ruff",        -- Ruff (Python)
	"pyright",     -- Pyright (Python)
	"cspell",      -- Code spell checker
	"sqlfmt",      -- SQL formatter
}

-- Setup mason.nvim to manage language servers and tools
require("mason").setup({
	ensure_installed = additional_tools, -- Ensure additional tools are installed
})

-- Setup mason-lspconfig.nvim to bridge mason and nvim-lspconfig
require("mason-lspconfig").setup({
	-- Ensure LSP servers defined in the 'servers' table are installed
	ensure_installed = vim.tbl_keys(servers),
	automatic_installation = true, -- Automatically install servers if missing

	-- Define handlers for setting up LSP servers
	-- This replaces the separate mason_lspconfig.setup_handlers call
	handlers = {
		-- Default handler for servers not explicitly listed below
		function(server_name)
			local server_settings = servers[server_name] or {} -- Get settings from the 'servers' table

			require("lspconfig")[server_name].setup({
				-- Use root_dir from the 'servers' table if defined, otherwise use the default
				root_dir = server_settings.root_dir or util.root_pattern(".git"),
				capabilities = capabilities,
				on_attach = on_attach,
				settings = server_settings.settings, -- Pass server-specific settings
				filetypes = server_settings.filetypes, -- Pass server-specific filetypes
			})
		end,

		-- You can add specific handlers for individual servers here if needed
		-- For example:
		-- ["lua_ls"] = function()
		--   require("lspconfig").lua_ls.setup({
		--     -- Specific settings for lua_ls that override the default handler
		--     settings = { Lua = { ... } },
		--     on_attach = on_attach, -- Still include on_attach
		--     capabilities = capabilities, -- Still include capabilities
		--   })
		-- end,
	},
})


