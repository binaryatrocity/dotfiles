set shell=/bin/bash
set nocompatible
set laststatus=2
set encoding=utf-8

filetype off

" autocmd 
if has("autocmd")
    " enable file type detection
    "filetype on
    filetype indent on
    filetype plugin on
    set ofu=syntaxcomplete#Complete
    autocmd FileType python map <buffer> <leader>8 :call Flake8()<CR>
endif

" basic options
syntax on
set number
set relativenumber
set nowrap
set autoindent

set backspace=indent,eol,start
set complete-=i
set showmatch
set smarttab
set incsearch

set ruler
set showcmd
set wildmenu
set foldmethod=indent
set foldcolumn=1

if !&scrolloff
    set scrolloff=1
endif
if !&sidescrolloff
    set sidescrolloff=5
endif
set display+=lastline

" spaces not tabs, etc
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" show invisible characters
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" multi-file
set hidden

" shortcut to silently run commands
command -nargs=1 Run <bar>execute ':silent !'.<q-args> <bar>execute ':redraw!'

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" lets setup vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
call vundle#rc()

" vundle bundles
Plugin 'gmarik/Vundle.vim'

" bundles on github
Plugin 'fholgado/minibufexpl.vim.git'
Plugin 'Lokaltog/vim-powerline.git'
Plugin 'Lokaltog/vim-distinguished.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'ervandew/supertab.git'
Plugin 'myusuf3/numbers.vim.git'
Plugin 'majutsushi/tagbar.git'
Plugin 'nvie/vim-flake8.git'
Plugin 'kien/rainbow_parentheses.vim.git'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'tmhedberg/SimpylFold'
Plugin 'ejholmes/vim-forcedotcom'

call vundle#end()
filetype plugin indent on

" toggle showing nerd-tree
:nmap <leader>e :NERDTreeToggle<CR>
" toggle showing tagbar
nmap <leader>r :TagbarToggle<CR>

" end tags with a key
imap ,/ </<C-X><C-O>

" xml validation
:nmap <leader>; :%w !xmllint --valid --noout -

" toggle line wrap
:nmap <leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>

" dem fancy colors
set t_Co=256
"colorscheme ir_black  " for macvim
colorscheme distinguished

" force django templates to use html syntax
au BufNewFile,BufRead *.djhtml set filetype=html
au BufNewFile,BufRead *.raml set filetype=yaml

" sudo save
cmap w!! w !sudo tee % >/dev/null

" Let's try some mouse stuff
set mouse=a

" Mark the 80th column. PEP8 yo
set colorcolumn=80

" rainbow parens
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
