" place cursor where we left off
if line("'\"") > 1 && line("'\"") <= line("$")
  exe "normal! g`\""
endif

" completion
set completeopt=longest,menu,preview
inoremap <expr> <C-@> pumvisible() ? "\<lt>c-n>" : "\<lt>c-x>\<lt>c-o>"
