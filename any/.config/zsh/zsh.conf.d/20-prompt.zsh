zle_highlight=(isearch:underline,bold)

function zle-keymap-select {
  prompt_chad_precmd
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-init {
  prompt_chad_precmd
}
zle -N zle-line-init

# help from prompt_adam2_setup. Thanks Adam2!
prompt_chad_precmd () {
  local prompt_line

  # ref: http://www.nparikh.org/unix/prompt.php
  # ref: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
  prompt_color_Bblack='%{\e[1;30m%}' #bold black
  prompt_color_black='%{\e[0;30m%}' #bold black
  prompt_color_default='%{\e[0m%}'   #default
  prompt_color_blue='%{\e[0;34m%}'   #blue
  prompt_color_Bred='%{\e[1;31m%}'   #bold red
  prompt_color_magenta='%{\e[0;35m%}'   #magenta

  prompt_normal_mode="||"
  prompt_insert_mode=$prompt_color_Bred">>"
  if [[ -z $KEYMAP ]]; then
    prompt_vim_status="%F$prompt_insert_mode%f";
  else
    prompt_vim_status="%F${${KEYMAP/vicmd/$prompt_normal_mode}/(main|viins)/$prompt_insert_mode}%f";
  fi

  if [ ! -z $SSH_CONNECTION ]; then
    prompt_ssh_conn="$prompt_color_black@%m"
  else
    prompt_ssh_conn=""
  fi

  if [ ! -z $DOCKER_CERT_PATH ]; then
    machine="${DOCKER_CERT_PATH##*/}"
    prompt_docker_machine="$prompt_color_magenta(${machine})$prompt_color_default"
  else
    prompt_docker_machine=""
  fi

  prompt_line="$prompt_color_Bblack%n$prompt_ssh_conn$prompt_docker_machine$prompt_color_default:$prompt_color_blue%~$prompt_vim_status$prompt_color_default "
  PS1="$(print $prompt_line)"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd prompt_chad_precmd
