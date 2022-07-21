" Imports the .vimrc settings
source ~/.vimrc

"--------------------------------------------------
" Plugins
"--------------------------------------------------
call plug#begin('~/.config/nvim/plugged')

Plug 'neovim/nvim-lspconfig'            " Official Language Support Plugin
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Improves syntax highlighting
Plug 'vim-airline/vim-airline'          " Airline Statusbar
Plug 'tpope/vim-fugitive'               " A Powerful Git Integration Tool
Plug 'lewis6991/gitsigns.nvim'          " Adds git decorations
Plug 'vimwiki/vimwiki'			        " Vim Wiki

" Telescope
Plug 'nvim-lua/plenary.nvim'            " Dependency for Telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}

" NvimTree
Plug 'kyazdani42/nvim-web-devicons'     " Optional icons for nvim-tree
Plug 'kyazdani42/nvim-tree.lua'         " Project File Explorer

" Visual Plugins
Plug 'ap/vim-css-color'			    " Color previews for CSS colors

" Colortheme plugins
Plug 'joshdick/onedark.vim'         " One Colorscheme
Plug 'gruvbox-community/gruvbox'    " Gruvbox Colorscheme

" Unused Plugins
"Plug 'vifm/vifm.vim'                   " File Manager
"Plug 'itchyny/lightline.vim'           " Lightline Statusbar
"Plug 'scrooloose/nerdtree'		        " Nerdtree
"Plug 'ryanoasis/vim-devicons'	        " Icons for Nerdtree

call plug#end()

" Loads init.lua to load all plugin settings
lua require('plugns')


"--------------------------------------------------
" Colorscheme Settings
"--------------------------------------------------

set termguicolors
colorscheme gruvbox
let g:airline_theme='gruvbox'

" Uses the terminal background over theme background (Useful for transparency)
"hi Normal guibg=NONE ctermbg=NONE


"--------------------------------------------------
" Plugin Settings
"--------------------------------------------------

" AirLine
let g:airline_powerline_fonts = 1
set laststatus=2
set noshowmode          " Disables -- INSERT -- notice

" Vim Wiki
let g:vimwiki_list = [{'path': '~/.config/nvim/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" Show diagnostic signs in number column
set signcolumn=yes:1


"--------------------------------------------------
" NeoVim Only Keybindings
"--------------------------------------------------

" NVim Tree Toggle
nnoremap <silent> T :NvimTreeToggle<CR>
