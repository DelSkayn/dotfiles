set termguicolors
set scrolloff=3

set autoindent
set noswapfile
set nowritebackup
set hidden
set cursorline
set expandtab
set hlsearch
set incsearch
set ignorecase
set smartcase
set gdefault
set inccommand=nosplit

syntax on
set hidden

let mapleader ="\<Space>"
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <leader>ft :NERDTreeToggle<CR>

nmap <silent> <leader>mc :make<CR>
autocmd filetype rust nmap <silent> <leader>mc :make check<CR>
autocmd filetype rust nmap <silent> <leader>md :make doc<CR>
autocmd filetype rust nmap <silent> <leader>mD :make doc --open<CR>

let g:SuperTabDefaultCompletionType = "<c-n>"

" auto start NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter *  if argc() == 0 && !exists("s:std_in") | NERDTree | endif
