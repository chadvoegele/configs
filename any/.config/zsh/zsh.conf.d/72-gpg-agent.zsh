export GPG_TTY=$(tty)

command -v gpg-connect-agent
if [[ $? -eq 0 ]]
then
  # Refresh gpg-agent tty in case user switches into an X session
  gpg-connect-agent updatestartuptty /bye >/dev/null
fi
