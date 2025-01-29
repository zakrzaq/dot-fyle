" Minimal vimrc for Python and JavaScript development

" Ensure Python and Node.js are installed for LSP and plugins
" You might need these for LSP servers: pip install pyright, npm install -g typescript-language-server

" Use vim-plug to manage plugins
call plug#begin('~/.vim/plugged')

" Theme: Rose Pine
Plug 'rose-pine/neovim', { 'as': 'rose-pine' }

" Python Plugins
Plug 'psf/black', { 'branch': 'stable' }       " Python formatter (black)
Plug 'davidhalter/jedi-vim'                    " Python autocompletion

" JavaScript Plugins
Plug 'pangloss/vim-javascript'                 " JavaScript syntax support
Plug 'maxmellon/vim-jsx-pretty'                " JSX/React syntax support

" LSP and Autocompletion
Plug 'neovim/nvim-lspconfig'                   " Language Server Protocol (LSP) configurations
Plug 'hrsh7th/nvim-cmp'                        " Autocompletion plugin (modern and compatible with LSP)
Plug 'hrsh7th/cmp-nvim-lsp'                    " LSP source for nvim-cmp
Plug 'hrsh7th/cmp-buffer'                      " Buffer source for nvim-cmp
Plug 'hrsh7th/cmp-path'                        " Path source for nvim-cmp

call plug#end()

" Set the colorscheme to rose-pine
set termguicolors
colorscheme rose-pine

" Enable LSP for Python and JavaScript
lua << EOF
local lspconfig = require'lspconfig'
lspconfig.pyright.setup{}      -- Python LSP
lspconfig.tsserver.setup{}     -- JavaScript/TypeScript LSP
EOF

" Autocomplete configuration with nvim-cmp
lua << EOF
local cmp = require'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    }
})
EOF

" Enable autoformatting for Python with black
" autocmd BufWritePre *.py execute ':Black'

" General settings
set number                       " Show line numbers
" set relativenumber               " Show relative line numbers
set tabstop=4                    " Tab width
set shiftwidth=4                 " Indentation level
set expandtab                    " Convert tabs to spaces
set autoindent                   " Enable auto-indent
set smartindent                  " Smart indenting on new lines
set clipboard=unnamedplus        " Use system clipboard
syntax on                        " Enable syntax highlighting
filetype plugin indent on        " Enable file type detection and indentation
