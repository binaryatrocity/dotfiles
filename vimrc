" system stuff
filetype off                      " for now, enabled after Vundle
set nocompatible                 " disable vi compatibility
set shell=/bin/bash               " set our shell, always bash
set laststatus=2                  " always show a status-bar
set encoding=utf-8                " always be unicode-ing
set hidden                        " hide abandoned buffers, don't close
set mouse=a                       " enable mouse support everywhere


" aesthetics
syntax enable                     " enable syntax processing
set scrolloff=4                   " always show 5 lines above/below cursor
set sidescrolloff=5               " always show 5 chars over
set display=lastline              " show as much as possible, no @s
set colorcolumn=80                " show bar at column # as a guide (pep8)


" tabs
set expandtab                     " make any tabs into spaces
set tabstop=4                     " turn them into 4 spaces
set softtabstop=4                 " even in insert mode
set shiftwidth=4                  " also 4 spaces for <</>> indenting


" interface
set nowrap                        " never wrap long lines
set number                        " show line numbers
set relativenumber                " show numbers relative to current line
set cursorline                    " highlight currently selected line
set wildmenu                      " command autocomplete bar
set lazyredraw                    " redraw only when needed
set showmatch                     " highlight matching brackets/parens
set incsearch                     " real-time searching while typing
set hlsearch                      " highlight search matches
set autoindent                    " auto-match surrounding indentation for newlines
set backspace=indent,start        " let backspace delete autoindent, not eol


" folding
set foldenable                    " turn on vim folding
set foldnestmax=8                 " stay out of fold-hell, only 10-deep
set foldmethod=indent             " unless told otherwise, fold on indents


" set Vundle runtime path and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins for Vundle to handle
Plugin 'VundleVim/Vundle.vim'                     " handle Vundle itself
Plugin 'fholgado/minibufexpl.vim'                 " mini-buffer explorer (tabs at top)
Plugin 'itchyny/lightline.vim'                    " status bar replacement
Plugin 'Lokaltog/vim-distinguished.git'           " ancient color-scheme, should replace
Plugin 'scrooloose/nerdtree.git'
Plugin 'ervandew/supertab.git'
Plugin 'nvie/vim-flake8.git'
Plugin 'kien/rainbow_parentheses.vim.git'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-syntastic/syntastic'
Plugin 'ejholmes/vim-forcedotcom'
Plugin 'LokiChaos/vim-tintin.git'
Plugin 'rust-lang/rust.vim'

" end vundle setup
call vundle#end()
colorscheme distinguished         " such colours


" autocmd check
if has("autocmd")
    filetype plugin indent on     " enable filetype detection
    " \8 to run Flake8 on python files
    autocmd FileType python map <buffer> <leader>8 :call Flake8()<CR>
    " set filetypes in odd extensions for decent highlighting
    autocmd BufNewFile,BufRead *.djhtml set filetype=html
    autocmd BufNewFile,BufRead *.raml set filetype=yaml
    autocmd BufNewFile,BufRead *.rs set filetype=rust
    autocmd BufNewFile,BufRead *.cls set filetype=apex
    autocmd BufNewFile,BufRead *.tt,*.tin set filetype=tt
    " for rainbow parentheses plugin
    autocmd VimEnter * RainbowParenthesesToggle
    autocmd Syntax * RainbowParenthesesLoadRound
    autocmd Syntax * RainbowParenthesesLoadSquare
    autocmd Syntax * RainbowParenthesesLoadBraces
endif

" [COMMANDS]
" close html/xml tags with a hotkey
imap ,/ </<C-X><C-O>
" turn off search-highlighting
nnoremap <leader><space> :nohlsearch<CR>
" highlight last inserted text
nnoremap gV `[v`]
" show invisible characters
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬
" don't be a noob - disable arrow keys everywhere
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" [PLUGIN COMMANDS]
" show nerd-tree bar
nmap <leader>e :NERDTreeToggle<CR>
" validate xml
nmap <leader>; :%w !xmllint --valid --noout -


" [Syntastic Settings]
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 3
