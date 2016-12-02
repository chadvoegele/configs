#!/bin/bash
wallpaper_dir=$1
wallpapers=( "$wallpaper_dir"/* )
count=${#wallpapers[@]}
select=$(expr $RANDOM % $count)
/usr/bin/feh --bg-scale "${wallpapers[select]}"
