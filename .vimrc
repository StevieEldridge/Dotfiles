"--------------------------------------------------
" General Settings
"--------------------------------------------------

" enables syntax highlighting
syntax on

" number of spaces in a <Tab>
set tabstop=2
set softtabstop=2
set expandtab
set smarttab

" enable autoindents
set autoindent
set smartindent
filetype indent on
filetype plugin indent on

" number of spaces used for autoindents
set shiftwidth=2

" adds line numbers
set number

" columns used for the line number
set numberwidth=3

" highlights the matched text pattern when searching
set incsearch
set hlsearch

" open splits intuitively
set splitbelow
set splitright

" navigate buffers without losing unsaved work
set hidden

" start scrolling when 8 lines from top or bottom
set scrolloff=6

" Save undo history
set undofile

" Enable mouse support
set mouse=a

" case insensitive search unless capital letters are used
set ignorecase
set smartcase

" set termguicolors
set t_Co=256

" Compatibility settings
set fileformat=unix
set encoding=utf-8

" Other
set showcmd
set showmatch


"--------------------------------------------------
" Key Bindings
"--------------------------------------------------

" Fast shortcut to do a replace
nnoremap <C-f> :%s//cg<Left><Left><Left>

" Uses homerow to switch to normal mode
imap jj <Esc>

" Indents and unindents with tab
nmap <Tab> >>2l
nmap <S-Tab> <<2h
"imap <Tab> <Esc>>>2la
"imap <S-Tab> <Esc><<2ha

" Makes line navigation easier
nmap J <C-d>
nmap K <C-u>

" Quickly navigates through buffers
nmap <silent> H :bprevious<CR>
nmap <silent> L :bnext<CR>

" Quickly navigates through tabs
nmap <C-h> gT
nmap <C-l> gt


" Uses Ctrl+hjkl to move between horz/vert windows
tmap <C-h> <C-\><C-n><C-w>h
tmap <C-j> <C-\><C-n><C-w>j
tmap <C-k> <C-\><C-n><C-w>k
tmap <C-l> <C-\><C-n><C-w>l
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <silent> <C-Right> :vertical resize +3<CR>
nmap <silent> <C-Left> :vertical resize -3<CR>
nmap <silent> <C-Up> :resize +3<CR>
nmap <silent> <C-Down> :resize -3<CR>

" Opens a terminal inside vim
map tt :new term://fish<CR>


"--------------------------------------------------
" Other Settings
"--------------------------------------------------

" Sets the cursor to line when in insert mode and block when in normal mode
" Article about subject here: https://stackoverflow.com/questions/6488683/how-to-change-the-cursor-between-normal-and-insert-modes-in-vim
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"

" Automatically deletes all trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
