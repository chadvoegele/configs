# completion
setopt autocd extendedglob
setopt autolist automenu nobeep

autoload -Uz compinit && compinit
zstyle :compinstall filename '/home/chad/.zshrc'

# http://zsh.sourceforge.net/Guide/zshguide06.html
zstyle ':completion:*' completer _complete _approximate
# https://askubuntu.com/questions/825625/how-can-i-extend-the-tab-key-auto-completion-in-the-terminal-to-text-in-the-midd/825654
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'
zstyle ':completion:*' rehash true  # https://wiki.archlinux.org/index.php/zsh
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:killall:*:*' command 'ps -e -o comm'
zstyle ':completion:*:ka:*:*' command 'ps -e -o comm'
compdef ka=killall
compdef smart_sudo=sudo
