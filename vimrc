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
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
endif

" basic options
syntax on
set number
set nowrap
set autoindent

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

" toggle showing nerd-tree
:nmap <leader>e :NERDTreeToggle<CR>

" end tags with a key
imap ,/ </<C-X><C-O>

" toggle line wrap
:nmap <leader>w :setlocal wrap!<CR>:setlocal wrap?<CR>

" dem fancy colors
set t_Co=256
colorscheme distinguished 
