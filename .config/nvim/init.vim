set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'jlanzarotta/bufexplorer'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'fatih/hclfmt'
Plug 'fatih/vim-hclfmt'
Plug 'b4b4r07/vim-hcl'
Plug 'hashivim/vim-terraform'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'elzr/vim-json'
Plug 'majutsushi/tagbar'
Plug 'neomake/neomake'
Plug 'ekalinin/Dockerfile.vim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'posva/vim-vue'

" Color schemes
Plug 'fatih/molokai'
Plug 'dracula/vim'

" Generic autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Require for Golang autocompletion
Plug 'deoplete-plugins/deoplete-go'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Initialize plugin system
call plug#end()

let g:python3_host_prog = expand('~/neovim-venv/bin/python3')

let g:deoplete#enable_at_startup = 1

" Set leader key
let g:mapleader=","

filetype plugin on
filetype indent on

if exists('$TMUX')
  if has('nvim')
    set termguicolors
  endif
endif

set ttyfast
set nocp                        " Use non-compatible mode
set tabstop=2
set shiftwidth=2
set laststatus=2
set encoding=utf-8              " Set default encoding to UTF-8
set autoread                    " Automatically reread changed files without asking me anything
set autoindent                  
set backspace=indent,eol,start  " Makes backspace key more powerful.
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches

if has('mouse')
	set mouse=a                     "Enable mouse mode
endif

set noerrorbells             " No beeps
set number                   " Show line numbers
set showcmd                  " Show me what I'm typing
set noswapfile               " Don't use swapfile
set nobackup                 " Don't create annoying backup files
set splitright               " Split vertical windows right to the current windows
set splitbelow               " Split horizontal windows below to the current windows
set autowrite                " Automatically save before :next, :make etc.
set hidden
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set noshowmode               " We show the mode with airline or lightline
set completeopt=longest,menu,menuone " (select longest + show menu even if a single match is found)
set completeopt-=preview
set nocursorcolumn           " speed up syntax highlighting
set cursorline							 " Show position of cursor
set updatetime=300
set pumheight=10             " Completion window max size
set conceallevel=2           " Concealed text is completely hidden
"set shortmess+=c   					 " Shut off completion messages
set belloff+=ctrlg 					 " If Vim beeps during completion
set lazyredraw 								" Don't redraw while executing macros (good performance config)
set ruler " Show line, column number and relative position
set foldcolumn=0
set wildmenu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/vendor,*/coverage/*,*/doc/*,*/node_modules/*,*/build/*,*/go_appengine/*,*/.glide/*

inoremap jj <esc>


""""""""""""""""""""""""""
" Text
""""""""""""""""""""""""""
set expandtab
set smarttab
set ignorecase               " Search case insensitive...
set smartcase                " ... but not it begins with upper case 
set ffs=unix,dos,mac

"http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard^=unnamed
set clipboard^=unnamedplus " Copy to system clipboard

" increase max memory to show syntax highlighting for large files 
set maxmempattern=20000

" ~/.viminfo needs to be writable and readable. Set oldfiles to 1000 last
" recently opened files, :FzfHistory uses it
set viminfo='1000

set foldmethod=syntax
set foldnestmax=50
set nofoldenable

if has('persistent_undo')
  set undofile
  set undodir=~/.cache/vim
endif

" color
syntax enable
colorscheme molokai
let g:rehash256 = 1
set t_Co=256
set background=dark
set guifont=Hack

" Set error color
hi Error guifg=#c41d1d guibg=#c41d1d 


" vim-airline configuration
let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'

" Deoplete
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" JSON Plugin
let g:vim_json_syntax_conceal = 0

" Neomake
autocmd! BufWritePost * Neomake

""""""""""""""""""""""""""""""""""""""
" Go configuration
""""""""""""""""""""""""""""""""""""""
"let g:neomake_go_enabled_makers = ['go', 'gometalinter']
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

" deoplete-go settings
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#pointer = 1

" vim-go plugin configuration
let g:go_auto_sameids = 1
let g:go_auto_type_info = 0
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports" 
let g:go_highlight_build_constraints = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1

" Enable folding
let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']

" Use `gopls` instead of `gocode`
let g:go_info_mode="gopls"
let g:go_def_mode="gopls" 

let g:go_list_type = "quickfix"
let g:go_list_autoclose = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet'] " Only use govet
let g:go_metalinter_enabled = ['vet', 'errcheck']
"let g:go_metalinter_autosave_enabled = ['vet', 'golint'] " Only use govet
"let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']


au FileType go nmap <leader>gr <Plug>(go-rename)
au FileType go nmap <leader>gd :GoDef<CR>
au FileType go nmap <leader>gt <Plug>(go-test)
au FileType go nmap <leader>gf :GoFmt<CR>
au FileType go nmap <leader>gi :GoInfo<CR>
au FileType go nmap <leader>gc :GoCoverageToggle<CR>
au FileType go nmap <leader>t :TagbarToggle<CR>
au FileType go nmap <leader>gec :GoErrCheck<CR>
au FileType go nmap <leader>gD :GoDoc<CR>
au FileType go nmap <leader>gcs :GoDecls<CR>
au FileType go nmap <leader>gb :GoBuild<CR>

"""""""""""""""""""""""""""""""""""""
" C#
"" """"""""""""""""""""""""""""""""""
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_use_mono = 1
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete


""""""""""""""""""""""""""""""""""""""
" Misc
""""""""""""""""""""""""""""""""""""""
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
nmap <leader>S :source $MYVIMRC<cr>
