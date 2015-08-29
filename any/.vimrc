" Set syntax on
syntax on

" Indent automatically depending on filetype
filetype plugin on
filetype indent on
set autoindent

" Change colorscheme from default to delek
colorscheme chad
autocmd FileType todo highlight Todo cterm=NONE ctermfg=grey ctermbg=grey

" searching
set ignorecase 
set smartcase
set nohls               " no highlighting in search

set nu                  " line numbering on
set nocompatible        " make Vim behave in a more useful way
set nostartofline       " keep cursor in the same column if possible
set dir=~/.vim/swap     " keep swap files in one place
set bdir=~/.vim/backup  " keep backups in one place
set virtualedit=block   " allow virtual editing in Visual block mode
set numberwidth=1       " minimum num of cols to reserve for line numbers
set nobackup            " disable backup files (filename~)
set textwidth=80        " insert carriage return after n cols wide
set expandtab           " insert spaces instead of tabs
set tabstop=2           " n space tab width
set softtabstop=2       " delete 2 spaces as tabs
set expandtab           " insert spaces instead of tabs
set smarttab             
set shiftwidth=2        " autoindent size
set autoread            " automatically read files if edited outside of vim
set whichwrap=<,>,[,],h,l 
set backspace=indent,eol,start "allow backspace over everything, colemak.vim
set showcmd
set wildmode=longest,full " completion for :e
set wildmenu              " completion for :e
set dictionary+=/usr/share/dict/cracklib-small " dictionary completion

" ledger stuff
au BufNewFile,BufRead ledger*txt setf ledger | comp ledger
let g:ledger_maxwidth = 80
let g:ledger_fillstring = '      --      '
let g:ledger_detailed_first = 1
let g:ledger_highest_level_match = 1
let g:ledger_exact_only = 1
let g:ledger_include_original = 0
nnoremap <silent> glc :call ledger#transaction_state_toggle(line('.'), '* ')<CR>
set viminfo='10,\"100,:20,%,n~/.viminfo

" completion menu
" set completeopt=menuone
" <CR> will simply select the highlighted menu item just as C-Y does
inoremap <expr> <CR> pumvisible() ? "\<c-y>" : "\<c-g>u\<CR>"
" When the autocomplete menu is up, make C-N simulate the "Down" key
inoremap <expr> <C-N> pumvisible() ? "\<lt>c-n>" : "\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
" Make C-Space bring up the <C-N> completion menu, then simulate C-N C-P to
" remove the longest common text, and finally simlates the "Down" key to keep
" a matched highlight
inoremap <expr> <C-@> pumvisible() ? "\<lt>c-n>" : "\<lt>c-x>\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
set completeopt=menuone,menu,longest,preview

" nerd commenter options
let NERDSpaceDelims=1
map gn <plug>NERDCommenterToggle

"youcompleteme
let g:ycm_filetype_whitelist = {"cpp" : 1, "c" : 1, "h" : 1}

" omnicomplete for cpp
" replaced with youcompleteme
" au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
" let OmniCpp_NamespaceSearch = 1      
" let OmniCpp_GlobalScopeSearch = 1      
" let OmniCpp_ShowAccess = 1      
" let OmniCpp_MayCompleteDot = 1      
" let OmniCpp_MayCompleteArrow = 1      
" let OmniCpp_MayCompleteScope = 1      
" let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"
" tags requires ctags
set tags+=~/.vim/tags/stl,~/.vim/tags/boost

" clang_complete options
" let g:clang_close_preview = 1

" you complete me options
let g:ycm_autoclose_preview_window_after_insertion = 1

" surround.vim options
xmap <Leader>s <Plug>Vsurround
xmap <Leader>S <Plug>VSurround
" surround text 
" unmap the capital S surround, need for insert
xmap gS <Plug>VSurround
xmap gs <Plug>Vsurround

" turbo navigation, colemak.vim
nnoremap <silent> H hhhhh|vnoremap <silent> H hhhhh
nnoremap <silent> K kkkkk|vnoremap <silent> K kkkkk
nnoremap <silent> J jjjjj|vnoremap <silent> J jjjjj
nnoremap <silent> L lllll|vnoremap <silent> L lllll

" home/end of line, colemak.vim
nnoremap <silent> <expr> <C-j> 0
nnoremap <C-l> $

" Half page up/down, colemak.vim
nnoremap <silent> <expr> <C-k> (winheight(0)/2) . "\<C-u>"
nnoremap <silent> <expr> <C-j> (winheight(0)/2) . "\<C-d>"

" key mapping
nnoremap ; :
vnoremap ; :
" Ctrl-s to save
inoremap <C-s> <esc>:w<cr>
nnoremap <C-s> :w<cr>
inoremap <C-q> <esc>:q<cr>
nnoremap <C-q> :q<cr>

" emacs keys in insert mode
inoremap <C-p> <C-o>k
inoremap <C-n> <C-o>j
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-d> <C-o>x
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0

" space, return in normal mode enter spaces, returns
nnoremap <Space> i<Space><Esc><Right>
nnoremap <Return> i<Return><Esc>

" spell check
nnoremap gs z=

" undo/redo
nnoremap U <C-r>
nnoremap u u

" code folding
nnoremap go zo " open fold under cursor
nnoremap gO zO " open all folds under cursor
nnoremap gr zr " decrease the foldlevel by one
nnoremap gm zm " increases the foldlevel by one
nnoremap gR zR " decreases the foldlevel to zero
nnoremap gk zc " "k"lose fold
nnoremap gf zf " create new fold

" gu underlines
nnoremap gu- yyp<c-v>$r-
nnoremap gu= yyp<c-v>$r=
nnoremap gl- o<Esc>80i-<Esc> 
nnoremap gl= o<Esc>80i=<Esc> 

" tab navigation
nnoremap gtt gt
nnoremap gtn :tabn<CR>
nnoremap gtp :tabp<CR>
nnoremap gtc :tabnew<CR>
nnoremap gtd :tabclose<CR>
nnoremap gt1 :tabn 1<CR>
nnoremap gt2 :tabn 2<CR>
nnoremap gt3 :tabn 3<CR>
nnoremap gt4 :tabn 4<CR>
nnoremap gt5 :tabn 5<CR>
nnoremap gt6 :tabn 6<CR>
nnoremap gt7 :tabn 7<CR>
nnoremap gt8 :tabn 8<CR>
nnoremap gt9 :tabn 9<CR>

" this conflicts with decrease fold. Need to remap
" shortcut for checktime to update file vim
nnoremap gr :checktime<CR>

" Calculator, fully working now!
function NewCalc(str)
  return system("echo -e `calc 'config(\"display\", 4),; config(\"tilde\", 0),; config(\"tab\", \"off\"),; " . a:str ."'`\"\\c\"")
endfunction
command! -nargs=+ NewCalc :echo NewCalc("<args>")

map <silent> gc<space> :s/.*/\=NewCalc(submatch(0))/<CR>:noh<CR>
vnoremap <silent> gc<space> :s/\%V.*\%V/\=NewCalc(submatch(0))/<CR>:noh<CR>
map <silent> gc= :s/.*/\=submatch(0) . "=" . NewCalc(submatch(0))/<CR>:noh<CR>
vnoremap <silent> gc= :s/\%V.*\%V/\=submatch(0) . "=" . NewCalc(submatch(0))/<CR>:noh<CR>

" slime
let g:slime_target = "tmux"

" dbtext sqlite3
let g:dbext_default_profile_c2g_sql_rating = 'type=SQLITE:SQLITE_bin=/usr/bin/sqlite3:dbname=/home/chad/inc/class2go_db/exercises/sql/rating.db'
let g:dbext_default_profile_c2g_sql_social = 'type=SQLITE:SQLITE_bin=/usr/bin/sqlite3:dbname=/home/chad/docs/edu/class2go_database/exercises/sql_social_net/social.db'
let g:dbext_default_profile_c2g_sql_socialtrig = 'type=SQLITE:SQLITE_bin=/usr/bin/sqlite3:dbname=/home/chad/docs/edu/class2go_database/exercises/sql_triggers/social.db'
let g:dbext_default_profile_c2g_sql_movieview = 'type=SQLITE:SQLITE_bin=/usr/bin/sqlite3:dbname=/home/chad/docs/edu/class2go_database/exercises/sql_view_modification/movie.db'
let g:dbext_default_profile_c2g_sql_socialtrigchal = 'type=SQLITE:SQLITE_bin=/usr/bin/sqlite3:dbname=/home/chad/docs/edu/class2go_database/exercises/sql_triggers_challenge/social.db'
