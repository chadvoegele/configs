call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rsi'
call plug#end()

colorscheme desert
set guicursor=
set dictionary+=/usr/share/dict/cracklib-small " dictionary completion
set expandtab           " insert spaces instead of tabs
set expandtab           " insert spaces instead of tabs
set ignorecase
set nobackup            " disable backup files (filename~)
set nocompatible        " make Vim behave in a more useful way
set nostartofline       " keep cursor in the same column if possible
set nu                  " line numbering on
set numberwidth=1       " minimum num of cols to reserve for line numbers
set shiftwidth=2        " autoindent size
set showcmd
set smartcase
set softtabstop=2       " delete 2 spaces as tabs
set tabstop=2           " n space tab width
set virtualedit=block   " allow virtual editing in Visual block mode
set whichwrap=<,>,[,],h,l
set wildmode=longest,full " completion for :e
syntax on

" turbo navigation
nnoremap <silent> H hhhhh|vnoremap <silent> H hhhhh
nnoremap <silent> K kkkkk|vnoremap <silent> K kkkkk
nnoremap <silent> J jjjjj|vnoremap <silent> J jjjjj
nnoremap <silent> L lllll|vnoremap <silent> L lllll

" Ctrl-s to save
inoremap <C-s> <esc>:w<cr>
nnoremap <C-s> :w<cr>
inoremap <C-q> <esc>:q<cr>
nnoremap <C-q> :q<cr>

" Ctrl-; replaces escapes
inoremap <C-_> <esc>
nnoremap <C-_> <esc>
vnoremap <C-_> <esc>
onoremap <C-_> <Esc>
cnoremap <C-_> <Esc>

" undo/redo
nnoremap U <C-r>

" gu underlines
nnoremap gu- yyp<c-v>$r-
nnoremap gu= yyp<c-v>$r=
nnoremap gl- o<Esc>80i-<Esc>
nnoremap gl= o<Esc>80i=<Esc>

" fzf
nnoremap <C-p> :Files<cr>
