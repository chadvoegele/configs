for user_path in "$user_paths[@]"
do
  [[ ${path[(i)$user_path]} -le ${#path} ]] || path=($user_path $path)
done

for user_comp_path in "$user_comp_paths[@]"
do
  [[ ${fpath[(i)$user_comp_path]} -le ${#fpath} ]] || fpath=($user_comp_path $fpath)
done
