" Imports the .vimrc settings
source ~/.vimrc

"--------------------------------------------------
" Plugins
"--------------------------------------------------
call plug#begin('~/.config/nvim/plugged')

Plug 'neovim/nvim-lspconfig'                " Official Language Support Plugin
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Improves syntax highlighting
Plug 'lewis6991/spellsitter.nvim'           " Spell checker that uses TreeSitter
Plug 'lukas-reineke/indent-blankline.nvim'  " Shows tabs
Plug 'vim-airline/vim-airline'              " Airline Statusbar
Plug 'tpope/vim-fugitive'                   " A Powerful Git Integration Tool
Plug 'lewis6991/gitsigns.nvim'              " Adds git decorations
Plug 'vimwiki/vimwiki'			                " Vim Wiki
Plug 'adelarsq/neofsharp.vim'               " Syntax Support for FSharp
Plug 'williamboman/mason.nvim'              " Manages external LSP servers
Plug 'tweekmonster/startuptime.vim'         " Shows startuptime slowdowns

" Autocompletion
Plug 'hrsh7th/nvim-cmp'                     " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp'                 " LSP source form nvim-cmp
Plug 'L3MON4D3/LuaSnip'                     " Snippets Plugin
Plug 'saadparwaiz1/cmp_luasnip'             " Snippets source for nvim-cmp
Plug 'onsails/lspkind-nvim'                 " Adds icons besides the names

" Telescope
Plug 'nvim-lua/plenary.nvim'                " Dependency for Telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}

" NerdTree
Plug 'ryanoasis/vim-devicons'	              " Icons for Nerdtree
Plug 'scrooloose/nerdtree'		              " Nerdtree

" Visual Plugins
Plug 'ap/vim-css-color'		      	          " Color previews for CSS colors

" Colortheme plugins
Plug 'joshdick/onedark.vim'                 " One Colorscheme
Plug 'gruvbox-community/gruvbox'            " Gruvbox Colorscheme

" Unused Plugins
"Plug 'vifm/vifm.vim'                       " File Manager
"Plug 'itchyny/lightline.vim'               " Lightline Statusbar
"Plug 'kyazdani42/nvim-web-devicons'        " Optional icons for nvim-tree
"Plug 'kyazdani42/nvim-tree.lua'            " Project File Explorer

call plug#end()

" Loads init.lua to load all plugin settings
lua require('plugns')


"--------------------------------------------------
" Colorscheme Settings
"--------------------------------------------------

set termguicolors
colorscheme gruvbox
let g:airline_theme='gruvbox'

" Uses terminal background over Vim theme background (Useful for transparency)
hi Normal guibg=NONE ctermbg=NONE


"--------------------------------------------------
" NeoVim Specific Settings
"--------------------------------------------------

" Enables spellcheck
set spell


"--------------------------------------------------
" Plugin Settings
"--------------------------------------------------

" AirLine
let g:airline_powerline_fonts = 1
let g:airline_detect_spell = 0                " Hides spell
let g:airline#extensions#tabline#enabled = 1  " Enables airline for tab bar
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Changes from powerline to straight tabs
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'

set laststatus=2
set noshowmode                                " Disables -- INSERT -- notice


"--------------------------------------------------
" Vim Wiki Settings
"--------------------------------------------------

" Has VimWiki use Markup
let g:vimwiki_list = [{'path': '~/.config/nvim/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

filetype plugin on  " The Github page recommends this setting is enabled

" Remaps increasing/decreasing task completion
nmap <Leader>[ glp
nmap <leader>] gln

" Show diagnostic signs in number column
set signcolumn=yes:1


"--------------------------------------------------
" NerdTree Settings
"--------------------------------------------------

" Quickly opens NerdTree, mirrors it, moves it to bottom, and resizes it
nnoremap <silent> T :NERDTreeVCS \| :NERDTreeMirror<CR> \| <C-w>J \| :resize 20<CR>

" Remaps keys that interfere with my window navigation keymaps
let g:NERDTreeMapJumpNextSibling='\j'
let g:NERDTreeMapJumpPrevSibling='\k'

" Makes file icons larger
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'

" Other settings
"let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1    " Shows hidden files by default
let NERDTreeMinimalUI = 1   " No clue what this does :)
let g:NERDTreeWinSize=24    " Default horizontal width
