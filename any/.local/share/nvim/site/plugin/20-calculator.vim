function Calc(str)
  return system("echo -e `calc 'config(\"display\", 4),; config(\"tilde\", 0),; config(\"tab\", \"off\"),; " . a:str ."'`\"\\c\"")
endfunction
command! -nargs=+ Calc :echo Calc("<args>")

map <silent> gc<space> :s/.*/\=Calc(submatch(0))/<CR>:noh<CR>
vnoremap <silent> gc<space> :s/\%V.*\%V/\=Calc(submatch(0))/<CR>:noh<CR>
map <silent> gc= :s/.*/\=submatch(0) . "=" . Calc(submatch(0))/<CR>:noh<CR>
vnoremap <silent> gc= :s/\%V.*\%V/\=submatch(0) . "=" . Calc(submatch(0))/<CR>:noh<CR>
