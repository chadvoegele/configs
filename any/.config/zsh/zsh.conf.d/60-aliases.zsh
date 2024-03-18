# functions
function open_file_or_dir() {
  if [[ $# -eq 0 ]]; then
    ls --color=auto;
  elif [[ $# -eq 1 && -d $1 ]]; then
    builtin cd $1;
  else
    /usr/bin/o $@;
  fi
}

smart_sudo () {
    if [[ $# -gt 0 ]]; then
      # bad fix for open_file_or_dir. fix when understand zsh fns with sudo
      if [[ $1 = "o" ]]; then
        sudo open_file $argv[2,-1]
      else
        #test if the first parameter is a alias
        if [[ -n $aliases[$1] ]]; then
            #if so, substitute the real command
            sudo ${=aliases[$1]} $argv[2,-1]
        else
            #else just run sudo as is
            sudo $argv
        fi
      fi
    else
        #if no parameters were given, then assume we want a root shell
        sudo -s
    fi
}

#aliases
alias -g D='&> /dev/null &!'

alias ls='ls --color=auto'
alias mv='mv -i'
alias cp='cp -i'
alias md='mkdir -p'
alias less='less -i'
alias sudo='sudo ' # this makes sudo use local aliases
alias s='smart_sudo'
alias o=open_file_or_dir
alias g=git
alias v=nvim
alias t=txt
function rgl() { rg --pretty --ignore-case "$@" | less --RAW-CONTROL-CHARS --no-init --quit-if-one-screen }
alias rg=rgl
function jql() { jq --color-output "$@" | less --RAW-CONTROL-CHARS --no-init --quit-if-one-screen }
alias jq=jql
