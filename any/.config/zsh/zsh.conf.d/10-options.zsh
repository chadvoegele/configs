HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
WORDCHARS='*?[]~=&;!#$%^(){}-'

export DE="generic"
export EDITOR="nvim"
export LS_COLORS='rs=0:di=34:ln=36:mh=00:pi=40;33:so=35:do=35:bd=40;33:cd=40;33:or=40;31:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=32'

setopt no_flow_control
stty -ixon -ixoff
setopt auto_pushd               # dirs
setopt pushd_ignore_dups        # ignore duplicates in dir stack
setopt rm_star_wait             # pause before confirming rm *
setopt share_history            # share history between open shells
setopt append_history           # append new history instead of overwriting
setopt interactive_comments     # allow comments
