" Vim indent file
" filetype: ledger

" Borrowed from indent/python.vim
" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

" Some preliminary settings
setlocal nolisp		" Make sure lisp indenting doesn't supersede us
setlocal autoindent	" indentexpr isn't much help otherwise

setlocal indentexpr=GetLedgerIndent(v:lnum)
setlocal indentkeys+=<:>,=elif,=except

" Only define the function once.
if exists("*GetLedgerIndent")
  finish
endif

" Come here when loading the script the first time.

let s:maxoff = 50	" maximum number of lines to look backwards for ()

function GetLedgerIndent(lnum)
  let cur_line_text = getline(a:lnum)
  if cur_line_text =~ '!\S\+'
    return 0
  endif
  if cur_line_text =~ '[~[:digit:]]\+/[~[:digit:]]' 
    && cur_line_text !~ '; \| ^!'
    return 0
    " return &sw
  endif
  if cur_line_text =~ '[:alpha]\+' && cur_line_text !~ ' ; \! ^!'
    echo "here"
    return &sw
  endif
  if cur_line_text !~ '\S\+' && getline(a:lnum-1) !~ '\S\+'
    return 0
  endif
  return -1
endfunction

" vim:sw=2
