#!/bin/bash

usage() {
	echo "utility to set wallpaper on hyprland."
	echo
	echo "Syntax: set_wallpaper.sh [-i|-d|-l|-h]"
	echo "options:"
	echo "h           Print this help."
	echo "i <path>    Load wallpaper"
	echo "d <path>    Load random wallpapers from provided directory"
	echo "l <file>    Load random wallpapers from provided list"
	echo
	exit 0
}

kill_sway() {
	ps aux | grep -i swaybg >/dev/null
	if [[ $? -eq 0 ]]; then
		killall swaybg
	fi
}

check_file() {
	if [[ ! -f "${1}" ]]; then
		echo "Error: $1 is not a valid file"
		exit 1
	fi
}

load_image() {
	check_file "${1}"
	kill_sway
	swaybg -i "${1}" 2>/dev/null &
	echo $1
	exit 0
}

load_from_dir() {
	if [[ ! -d "${1}" ]]; then
		echo "Error: "${1}" is not a valid directory"
		exit 1
	fi
	FILE=$(find "${1}" -type f | shuf -n 1)
	load_image "${FILE}"
}

load_from_list() {
	check_file "${1}"
	FILE=$(shuf -n 1 "${1}")
	cp ${FILE} ~/.cache/wallpaper.png
	load_image "${FILE}"
}

[ $# -eq 0 ] && usage
[ $# -gt 2 ] && usage

while getopts ":i:d:l:h" option; do
	case $option in
	i)
		load_image "${OPTARG}"
		exit 0
		;;
	d)
		load_from_dir "${OPTARG}"
		exit 0
		;;
	l)
		load_from_list "${OPTARG}"
		exit 0
		;;
	h | *)
		usage
		exit 0
		;;
	esac
done
