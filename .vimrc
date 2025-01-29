" Minimal vimrc for Python and JavaScript development

" Use vim-plug to manage plugins
call plug#begin('~/.vim/plugged')

" Rose Pine theme
Plug 'rose-pine/neovim', { 'as': 'rose-pine' }

" Python-specific plugins
Plug 'psf/black', { 'branch': 'stable' }       " Python formatter (black)
Plug 'davidhalter/jedi-vim'                    " Python autocompletion

" JavaScript-specific plugins
Plug 'pangloss/vim-javascript'                 " JavaScript syntax support
Plug 'maxmellon/vim-jsx-pretty'                " JSX/React syntax support

" LSP and autocompletion for both languages
Plug 'neovim/nvim-lspconfig'                   " Language Server Protocol (LSP) configurations
Plug 'hrsh7th/nvim-compe'                      " Autocompletion

call plug#end()

" Set the colorscheme to rose-pine
set termguicolors
colorscheme rose-pine

" Enable LSP for Python and JavaScript
lua << EOF
require'lspconfig'.pyright.setup{}    " Python LSP
require'lspconfig'.tsserver.setup{}   " JavaScript/TypeScript LSP
EOF

" Autocomplete settings
set completeopt=menuone,noinsert,noselect
let g:compe = {
    \ 'enabled': v:true,
    \ 'autocomplete': v:true,
    \ 'min_length': 1,
    \ 'preselect': 'enable',
    \ 'throttle_time': 80,
    \ 'source_timeout': 200,
    \ 'incomplete_delay': 400,
    \ 'max_abbr_width': 100,
    \ 'max_kind_width': 100,
    \ 'max_menu_width': 100,
    \ 'documentation': v:true,
    \ 'source': {
    \   'path': v:true,
    \   'buffer': v:true,
    \   'nvim_lsp': v:true,
    \   'nvim_lua': v:true,
    \   'vsnip': v:false,
    \   'ultisnips': v:false,
    \   'luasnip': v:false
    \ }
\}

" Enable autoformatting for Python with black
autocmd BufWritePre *.py execute ':Black'

" Basic editor settings
syntax on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set number
set relativenumber
