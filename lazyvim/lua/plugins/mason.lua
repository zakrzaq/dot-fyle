return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- TypeScript
        "typescript-language-server",
        "prettier",

        -- Python
        "pyright",
        "ruff",
        "ruff-lsp",
      },
    },
  },
}
