local util = require("lspconfig/util")

local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<leader>K", vim.lsp.buf.signature_help, "Signature Documentation")
	nmap("gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
	nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
	nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		require("conform").format()
	end, { desc = "Format current buffer with LSP" })
end

local servers = {
	volar = {
		filetypes = { "vue", "json" },
	},
	tsserver = {
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
	},
	ruff = {},
	pyright = {},
	html = {},
	cssls = {},
	tailwindcss = {},
	emmet_ls = {},
	sqlls = {},
	marksman = {},
	dotls = {},
	bashls = {},
	jsonls = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = { globals = { "vim" } },
		},
	},
}

require("neodev").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local additional_tools = {
	"stylua",
	"black",
	"isort",
	"flake8",
	"eslint_d",
	"prettier",
	"prettier_d",
	"cspell",
}
require("mason").setup({
	ensure_installed = additional_tools,
})

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			root_dir = util.root_pattern(".git"),
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		})
	end,
})
