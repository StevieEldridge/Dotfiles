syntax on
set number
set showcmd
filetype indent on
set showmatch
set incsearch
set hlsearch
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set fileformat=unix
set encoding=utf-8


" Sets default clipboard to the system clipboard
" Requires gvim/nvim/vim-xll installed
set clipboard=unnamedplus
vnoremap <C-c> "+y
map <C-p> "+P

nnoremap <C-f> :%s//g<Left><Left>

" Automatically deletes all trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" Paste from system clipboard with ctrl+i instead of shift insert
map <S-Insert> <C-i>
imap jj <Esc>

" Sets the cursor to line when in insert mode and block when in normal mode
" Article about subject here: https://stackoverflow.com/questions/6488683/how-to-change-the-cursor-between-normal-and-insert-modes-in-vim
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"
