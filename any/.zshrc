if [[ -d ~/.config/zsh/zsh.conf.d ]]
then
  for file in ~/.config/zsh/zsh.conf.d/*
  do
    source $file
  done
fi
