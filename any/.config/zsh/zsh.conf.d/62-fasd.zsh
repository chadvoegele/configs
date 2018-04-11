function setup_fasd() {
  eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"
  alias a='fasd -a'
  # function to execute built-in cd
  fasd_cd() {
    if [ $# -le 1 ]; then
      fasd "$@"
    else
      local _fasd_ret="$(fasd -e 'printf %s' "$@")"
      [ -z "$_fasd_ret" ] && return
      [ -d "$_fasd_ret" ] && cd "$_fasd_ret" || printf %s\n "$_fasd_ret"
    fi
  }
  alias j='fasd_cd -d'
}

command -v fasd > /dev/null
FASD_EXISTS=$?
if [[ ${FASD_EXISTS} -eq 0 ]]
then
  setup_fasd
fi
