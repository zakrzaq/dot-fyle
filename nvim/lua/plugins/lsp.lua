local M = {}

function M.init()
	-- write functionaly to be executed
end

function M.setup()
	local installed, lspconfig = pcall(require, "lspconfig")
	if not installed then
		vim.notify("Plugin '<package-name>' is not installed")
		return
	end

	local mason_lspconfig = require("mason-lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	require("mason").setup({
		automatic_installation = {
			"ts_ls",
			"html",
			"cssls",
			"ruff",
			"black",
			"prettierd",
			"prettier",
			"stylua",
			"sqruff",
			"pylsp",
			"pyright",
			"debugpy",
			"js-debug-adapter",
		},
	})

	M.init()

	mason_lspconfig.setup({
		handlers = {
			function(server_name)
				local on_attach = function(client, bufnr)
					vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
					local opts = { noremap = true, silent = true }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>F", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end

				lspconfig[server_name].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
		},
	})

	-- lsp.setup({
	-- 	-- setup params here
	-- })
end

return M

-- local util = require("lspconfig/util")
--
-- local on_attach = function(_, bufnr)
-- 	local nmap = function(keys, func, desc)
-- 		if desc then
-- 			desc = "LSP: " .. desc
-- 		end
-- 		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
-- 	end
--
-- 	-- Define LSP keymaps
-- 	nmap("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
-- 	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
-- 	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
-- 	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
-- 	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
-- 	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
-- 	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
-- 	nmap("<leader>K", vim.lsp.buf.signature_help, "Signature Documentation")
--
-- 	-- Keymaps for diagnostics (errors, warnings, etc.)
-- 	nmap("gl", "<cmd>lua vim.diagnostic.open_float()<cr>", "Open floating diagnostics window")
-- 	nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Go to previous diagnostic")
-- 	nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Go to next diagnostic")
--
-- 	-- Buffer-local command to format the buffer using conform.nvim
-- 	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
-- 		require("conform").format({ bufnr = bufnr }) -- Specify buffer number for precision
-- 	end, { desc = "Format current buffer with LSP" })
-- end
--
-- -- Define default settings for each LSP server
-- -- These settings will be merged with the default lspconfig settings
-- local servers = {
-- 	volar = {
-- 		filetypes = { "vue", "json" }, -- Specify filetypes for volar
-- 	},
-- 	ts_ls = {                      -- TypeScript Language Server
-- 		filetypes = {
-- 			"javascript",
-- 			"javascriptreact",
-- 			"javascript.jsx",
-- 			"typescript",
-- 			"typescriptreact",
-- 			"typescript.tsx",
-- 		},
-- 	},
-- 	ruff = {},       -- Ruff (Python linter/formatter)
-- 	pyright = {},    -- Pyright (Python static analysis)
-- 	html = {},       -- HTML Language Server
-- 	cssls = {},      -- CSS Language Server
-- 	tailwindcss = {}, -- Tailwind CSS Language Server
-- 	emmet_ls = {},   -- Emmet Language Server
-- 	sqlls = {},      -- SQL Language Server
-- 	marksman = {},   -- Markdown Language Server
-- 	dotls = {},      -- Dot Language Server (Graphviz)
-- 	bashls = {},     -- Bash Language Server
-- 	jsonls = {},     -- JSON Language Server
-- 	lua_ls = {       -- Lua Language Server
-- 		settings = {   -- Use 'settings' key for server-specific settings
-- 			Lua = {
-- 				workspace = { checkThirdParty = false },
-- 				telemetry = { enable = false },
-- 				diagnostics = { globals = { "vim" } },
-- 			},
-- 		},
-- 	},
-- }
--
-- require("neodev").setup()
--
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
--
-- local additional_tools = {
-- 	"stylua",    -- Lua formatter
-- 	"eslint_d",  -- ESLint daemon
-- 	"prettier",  -- Prettier (general code formatter)
-- 	"prettier_d", -- Prettier daemon
-- 	"ruff",      -- Ruff (Python)
-- 	"pyright",   -- Pyright (Python)
-- 	"cspell",    -- Code spell checker
-- 	"sqlfmt",    -- SQL formatter
-- }
--
-- require("mason").setup({
-- 	ensure_installed = additional_tools,
-- })
--
-- require("mason-lspconfig").setup({
-- 	ensure_installed = vim.tbl_keys(servers),
-- 	automatic_installation = true,
--
-- 	handlers = {
-- 		function(server_name)
-- 			local server_settings = servers[server_name] or {}
--
-- 			require("lspconfig")[server_name].setup({
-- 				root_dir = server_settings.root_dir or util.root_pattern(".git"),
-- 				capabilities = capabilities,
-- 				on_attach = on_attach,
-- 				settings = server_settings.settings,
-- 				filetypes = server_settings.filetypes,
-- 			})
-- 		end,
--
-- 	},
-- })
