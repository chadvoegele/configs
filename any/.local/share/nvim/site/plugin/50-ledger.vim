au BufNewFile,BufRead ledger*txt setf ledger | comp ledger
let g:ledger_maxwidth = 80
let g:ledger_fillstring = '      --      '
let g:ledger_detailed_first = 1
let g:ledger_highest_level_match = 1
let g:ledger_exact_only = 1
let g:ledger_include_original = 0
autocmd Filetype ledger set foldmethod=syntax
nnoremap <silent> glc :call ledger#transaction_state_toggle(line('.'), '*')<CR>
