upath=~/bin
[[ ${path[(i)$upath]} -le ${#path} ]] || path=($upath $path)

ufpath=~/.config/zsh/compdef
[[ ${fpath[(i)$ufpath]} -le ${#fpath} ]] || fpath=($ufpath $fpath)
