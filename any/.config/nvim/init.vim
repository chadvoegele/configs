call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
call plug#end()

lua << EOF
nvis = require('nvim-slime')
EOF

xmap <c-c><c-c> :lua nvis.paste.text() <CR>
