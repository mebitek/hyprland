#!/bin/bash

MUSIC_DIR=$HOME/Musica

previewdir="$HOME/.config/ncmpcpp/previews"

album="$(mpc --format %album% current 2>/dev/null)"
file="$(mpc --format %file% current 2>/dev/null | sed 's/local\:track\://g' | sed 's/%20/ /g')"
album_dir="${file%/*}"
[[ -z "$album_dir" ]] && exit 1
album_dir="$MUSIC_DIR/$album_dir"

covers="$(find "$album_dir" -type d -exec find {} -maxdepth 1 -type f -iregex ".*/.*\(${album}\|cover\|folder\|artwork\|front\).*[.]\(jpe?g\|png\|gif\|bmp\)" \;)"
src="$(echo -n "$covers" | head -n1)"
previewname="$previewdir/$(echo $file | base64).png"
[[ -e $previewname ]] || ffmpeg -y -i "$src" -an -vf scale=128:128 "$previewname" /dev/null 2>&1

notify-send -r 27072 "Now Playing" "$(mpc --format '%title% \n%artist% - %album%' current 2>/dev/null)" -i "$previewname"
