if [ -z "$SSH_AUTH_SOCK" ] || [ ! -w "$SSH_AUTH_SOCK" ]; then
  pid_ssh_agent=`pidof ssh-agent`
  if [ -z $pid_ssh_agent ]; then
    ssh-agent -s > ~/.ssh/ssh-agent.sh
  fi
  if [ -f ~/.ssh/ssh-agent.sh ]; then
      source ~/.ssh/ssh-agent.sh >/dev/null
  fi
fi
