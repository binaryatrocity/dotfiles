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
endif

" basic options
syntax on
set number
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
set tabstop=8
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
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" vundle bundles
Bundle 'gmarik/vundle'

" bundles on github
Bundle 'fholgado/minibufexpl.vim.git'
Bundle 'Lokaltog/vim-powerline.git'
Bundle 'Lokaltog/vim-distinguished.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'ervandew/supertab.git'
Bundle 'myusuf3/numbers.vim.git'

" toggle showing nerd-tree
:nmap <leader>e :NERDTreeToggle<CR>

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

" sudo save
cmap w!! w !sudo tee % >/dev/null

" Let's try some mouse stuff
set mouse=a
