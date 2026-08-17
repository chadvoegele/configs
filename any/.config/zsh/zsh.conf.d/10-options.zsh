# History (from https://michael.stapelberg.ch/posts/2026-08-09-zsh-history-truncation-bug/)
## Load 4000 lines of history (for Ctrl+R backward search), but save O(∞)
HISTSIZE=4000
HISTFILE=~/.histfile
SAVEHIST=10000000

## Do not save (adjacent) duplicate entries
setopt HIST_IGNORE_DUPS

## Append history entries to `~/.histfile` when commands are run.
setopt INC_APPEND_HISTORY
## …but do not share history (enabled by default in NixOS’s /etc/zshrc).
unsetopt SHARE_HISTORY


WORDCHARS='*?[]~=&;!#$%^(){}-'

export DE="generic"
export EDITOR="nvim"
export PAGER="less"
export LS_COLORS='rs=0:di=34:ln=36:mh=00:pi=40;33:so=35:do=35:bd=40;33:cd=40;33:or=40;31:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=32'

setopt no_flow_control
stty -ixon -ixoff
setopt auto_pushd               # dirs
setopt pushd_ignore_dups        # ignore duplicates in dir stack
setopt rm_star_wait             # pause before confirming rm *
setopt interactive_comments     # allow comments
