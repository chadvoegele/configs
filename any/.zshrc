# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

#word chars
# by default: export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
WORDCHARS='*?[]~=&;!#$%^(){}-'

#no flow control
setopt noflowcontrol
stty -ixon -ixoff

setopt autopushd              # dirs
setopt PUSHD_IGNORE_DUPS      # ignore duplicates in dir stack
setopt RM_STAR_WAIT           # pause before confirming rm *
setopt SHARE_HISTORY          # share history between open shells
setopt appendhistory          # append new history instead of overwriting

# jump dirs!
# cdpath=( . ~/jump )

# ~/bin/zsh scripts
if [[ -d ~/bin/zsh ]] && [[ ! -z `ls ~/bin/zsh` ]]; then
  for file in ~/bin/zsh/*; do
    source $file
  done
fi

# prompt
. ~/.config/zsh/prompt
unset zle_bracketed_paste     # paste as if typing, must go after prompt

# titles
. ~/.config/zsh/titles

# key bindings
. ~/.config/zsh/bindkeys

# completion
. ~/.config/zsh/completion

# aliases
. ~/.config/zsh/aliases

#local settings
[[ -f ~/.zsh_localrc ]] && .  ~/.zsh_localrc

# set environment vars if they are not set
if [ -z "$DE" ] || ! [[ $PATH =~ "/home/chad/bin" ]]; then
  # set environment vars
  DE="generic"
  EDITOR="vim"
  PRINTER="HP_LaserJet_1022"
  BROWSER="google-chrome"
  typeset -U path
  path=(~/bin $path)
  export DE EDITOR PRINTER BROWSER
fi

# Start X if it is vc1 and X hasn't been started already
if [ -z "$DISPLAY" ] && [ $(tty) = /dev/tty1 ]; then
  startx -- -dpi 96 vt1
logout
else
  if [ -z "$SSH_AUTH_SOCK" ] || [ ! -w "$SSH_AUTH_SOCK" ]; then
    pid_ssh_agent=`pidof ssh-agent`
    if [ -z $pid_ssh_agent ]; then
      ssh-agent -s > ~/.ssh/ssh-agent.sh
    fi
    if [ -f ~/.ssh/ssh-agent.sh ]; then
        source ~/.ssh/ssh-agent.sh >/dev/null
    fi
  fi
fi
