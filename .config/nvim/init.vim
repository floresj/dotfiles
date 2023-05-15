" Configure Plug dependencies
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'jlanzarotta/bufexplorer'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'fatih/hclfmt'
Plug 'fatih/vim-hclfmt'
Plug 'b4b4r07/vim-hcl'
Plug 'hashivim/vim-terraform'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'ekalinin/Dockerfile.vim'
Plug 'posva/vim-vue'
Plug 'mileszs/ack.vim'
Plug 'cespare/vim-toml'
Plug 'othree/html5.vim'
Plug 'mzlogin/vim-markdown-toc'
Plug 'dhruvasagar/vim-table-mode'
Plug 'plasticboy/vim-markdown'
" If you have nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'jparise/vim-graphql'
Plug 'prisma/vim-prisma'
Plug 'luukvbaal/nnn.nvim'
Plug 'stevearc/oil.nvim'

" Color schemes
Plug 'fatih/molokai'
Plug 'jacoborus/tender.vim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'EdenEast/nightfox.nvim'
Plug 'nyoom-engineering/nyoom.nvim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sainnhe/sonokai'

" Initialize plugin system
call plug#end()


set nocompatible
let g:python3_host_prog = expand('$HOME/.config/nvim/venv/bin/python')

" Set leader key
let g:mapleader=","

filetype off
filetype plugin indent on

" color
syntax enable
" let g:rehash256 = 1
set t_Co=256
set background=dark
set guifont=Hack
colorscheme sonokai

if (has("termguicolors"))
 set termguicolors
endif

nmap <C-P> :FZF<CR>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

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
set shortmess+=c   					 " Shut off completion messages
set belloff+=ctrlg 					 " If Vim beeps during completion
set lazyredraw 								" Don't redraw while executing macros (good performance config)
set ruler " Show line, column number and relative position
set foldcolumn=0
set wildmenu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/vendor,*/coverage/*,*/doc/*,*/node_modules/*,*/build/*,*/go_appengine/*,*/.glide/*,*/site-packages/*,*/venv/*,*/dependencies/python*

" inoremap jj <esc>

let g:vim_markdown_conceal = 1

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
set shada='1000

set foldmethod=syntax
set foldnestmax=50
set nofoldenable

if has('persistent_undo')
  set undofile
  set undodir=~/.cache/nvim
endif


" colorscheme tender
" colorscheme molokai

" vim-airline configuration
let g:airline_powerline_fonts = 1
let g:airline_theme='tender'


""""""""""""""""""""""""""""""""""""""
" Coc extensions to install
""""""""""""""""""""""""""""""""""""""

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
nmap <leader>S :source $MYVIMRC<CR>



""""""""""""""""""""""""""""""""
" coc.nvim
"
""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.json5 setfiletype json
let g:coc_filetype_map = {
  \ 'json.json5': 'json',
  \ }

let g:coc_global_extensions = [
      \'coc-eslint',
      \'coc-tsserver',
      \'coc-json', 
      \'coc-pyright', 
      \'coc-markdownlint',
      \]

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

hi CocSearch ctermfg=12 guifg=#18A3FF
hi CocMenuSel ctermbg=109 guibg=#13354A

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gl <Plug>(coc-diagnostics-toggle)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>


function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

nnoremap <silent> <space>i  :call CocAction('runCommand', 'editor.action.organizeImport')<CR>
"""""""""""

""""""""""""""""""""""""""""""""""""""
" NERDCommenter
""""""""""""""""""""""""""""""""""""""

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" To use NERDCommenter with Vue files, you can use its "hooks" feature to temporarily change the filetype. Click for an example.
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction


""""""""""""""""""""""""""""""""""""""
" vim-table-mode
""""""""""""""""""""""""""""""""""""""

" Enable markdown-compatible tables
let g:table_mode_corner='|'


let g:LanguageClient_serverCommands = {
    \ 'vue': ['vls']
    \ }

" Run gofmt on save
" autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()


"""""""""""""""""""""""""""""""""""""""
" Non-standard Makefile names
"""""""""""""""""""""""""""""""""""""""
autocmd BufEnter Makefile.local :setlocal filetype=make
autocmd BufEnter Makefile.* :setlocal filetype=make


""""""""""""""""""""""""""""""""""""""""
" Yapf
""""""""""""""""""""""""""""""""""""""""
au FileType python nmap <leader>f :Yapf<CR>

""""""""""""""""""""""""""""""""""""""""
" Typescript
""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>oi :call CocAction('runCommand', 'tsserver.organizeImports')<CR>
nmap <leader>rn <Plug>(coc-rename)

""""""""""""""""""""""""""""""""""""""""
" Python Deoplete
""""""""""""""""""""""""""""""""""""""""
" let g:python3_host_prog = '$HOME/.config/nvim/env/bin/python'
" let g:deoplete#sources#jedi#enable_short_types = 1
" let g:deoplete#sources#jedi#show_docstring = 1
com! FormatJSON %!python -m json.tool

command! FmtJSON :execute '%!jq .'

aug python
  au!
  au BufWrite *.py call CocAction('format')
aug END



lua << EOF
require("nnn").setup()
require("oil").setup({
  columns = {
    "icon"
  }
})
require("nvim-web-devicons").setup()
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
EOF
