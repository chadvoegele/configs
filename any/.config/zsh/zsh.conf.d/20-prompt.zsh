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
  # ref: http://www.nparikh.org/unix/prompt.php
  # ref: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
  local prompt_color_Bblack='%{\e[1;90m%}' #bold black
  local prompt_color_black='%{\e[0;30m%}' #bold black
  local prompt_color_default='%{\e[0m%}'   #default
  local prompt_color_blue='%{\e[0;34m%}'   #blue
  local prompt_color_Bred='%{\e[1;91m%}'   #bold red
  local prompt_color_magenta='%{\e[0;35m%}'   #magenta

  local prompt_normal_mode="||"
  local prompt_insert_mode=$prompt_color_Bred">>"
  if [[ -z $KEYMAP ]]; then
    local prompt_vim_status="%F$prompt_insert_mode%f";
  else
    local prompt_vim_status="%F${${KEYMAP/vicmd/$prompt_normal_mode}/(main|viins)/$prompt_insert_mode}%f";
  fi

  if [ ! -z $SSH_CONNECTION ]; then
    local prompt_ssh_conn="$prompt_color_black@%m"
  else
    local prompt_ssh_conn=""
  fi

  local prompt_line="$prompt_color_Bblack%n$prompt_ssh_conn$prompt_color_default:$prompt_color_blue%~$prompt_vim_status$prompt_color_default "
  PS1="$(print $prompt_line)"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd prompt_chad_precmd
