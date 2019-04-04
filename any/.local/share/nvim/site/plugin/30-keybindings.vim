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
nnoremap <C-j> :Buffers<cr>
