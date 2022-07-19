"--------------------------------------------------
" Plugins
"--------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'vifm/vifm.vim'			" File Manager
Plug 'vim-airline/vim-airline'  " Airline Statusbar
"Plug 'itchyny/lightline.vim'    " Lightline Statusbar
Plug 'scrooloose/nerdtree'		" Nerdtree
Plug 'ryanoasis/vim-devicons'	" Icons for Nerdtree
Plug 'vimwiki/vimwiki'			" Vim Wiki
Plug 'ap/vim-css-color'			" Color previews for CSS colors

call plug#end()


"--------------------------------------------------
" Vim Color Theme Variables
"--------------------------------------------------

let color = {
    \   'background' : '#292d3e',
    \   'foreground' : '#bfc7df',
    \   'black'      : '#292d3e',
    \   'red'        : '#f07178',
    \   'green'      : '#62de84',
    \   'yellow'     : '#ffcb6b',
    \   'blue'       : '#75a1ff',
    \   'magenta'    : '#f580ff',
    \   'cyan'       : '#60baec',
    \   'white'      : '#abb2bf',
    \}


"--------------------------------------------------
" General Settings
"--------------------------------------------------

syntax on
set number
set showcmd
filetype indent on
set expandtab
set smarttab
set showmatch
set incsearch
set hlsearch
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set fileformat=unix
set encoding=utf-8
set t_Co=256

" Removes '|' that act as seperators on splits
set fillchars+=vert:.


"--------------------------------------------------
" Key Bindings
"--------------------------------------------------

" Fast shortcut to do a replace
nnoremap <C-f> :%s//g<Left><Left>

" Uses homerow to switch to normal mode
imap jj <Esc>

" Indents and unindents with tab
nmap <Tab> >>4l
nmap <S-Tab> <<4h
"imap <Tab> <Esc>>>4la
"imap <S-Tab> <Esc><<4ha

" Uses Ctrl+hjkl to move between split/vsplit windows
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" Opens a terminal inside vim
map tt :new term://fish<CR>


"--------------------------------------------------
" Plugin Settings
"--------------------------------------------------

" NerdTree
" Uncomment to autostart the NERDTree
" autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
"let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=32

" LightLine
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }

" AirLine
let g:airline_powerline_fonts = 1
set laststatus=2
set noshowmode          " Disables -- INSERT -- notice
:let g:airline_theme='custom'

" Vim Wiki
let g:vimwiki_list = [{'path': '~/.vim/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]


"--------------------------------------------------
" Other Settings
"--------------------------------------------------

" Sets the cursor to line when in insert mode and block when in normal mode
" Article about subject here: https://stackoverflow.com/questions/6488683/how-to-change-the-cursor-between-normal-and-insert-modes-in-vim
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"

" Automatically deletes all trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e


"--------------------------------------------------
" Vim Specific Settings
"--------------------------------------------------

if !has('nvim')

endif


"--------------------------------------------------
" NeoVim Specific Settings
"--------------------------------------------------

if has('nvim')

endif

