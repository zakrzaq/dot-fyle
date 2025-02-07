" " Essential Settings
set nocompatible
syntax enable
filetype plugin indent on

" Basic Editor Configuration
set number
" set relativenumber
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set mouse=a
set clipboard=unnamed
set hidden
set cursorline
set signcolumn=yes
set updatetime=300

" Search settings
set hlsearch
set incsearch
set ignorecase
set smartcase

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Plugins
call plug#begin('~/.vim/plugged')

" Theme
Plug 'rose-pine/vim'

" File Navigation
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'

" Language Support
Plug 'vim-python/python-syntax'
Plug 'pangloss/vim-javascript'
Plug 'dense-analysis/ale'

" Git integration
Plug 'tpope/vim-fugitive'

call plug#end()

" Theme Configuration
set background=dark
colorscheme rosepine

" File type specific settings
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab

" ALE Configuration
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\   'javascript': ['eslint'],
\}
let g:ale_fixers = {
\   'python': ['black'],
\   'javascript': ['prettier'],
\}
let g:ale_fix_on_save = 1

" Key mappings
let mapleader = " "
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <C-p> :CtrlP<CR>

" Python and JavaScript specific settings
let g:python_highlight_all = 1
let g:javascript_plugin_jsdoc = 1
