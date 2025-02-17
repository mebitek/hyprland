#!/bin/bash

# Checking and installing dependencies
dependencies=("hyprpicker" "convert")
for dep in "${dependencies[@]}"; do
	command -v "$dep" &>/dev/null || {
		echo "$dep not found, please install it."
		exit 1
	}
done

# Get color from hyprpicker
color=$(hyprpicker -a)

# Set image path for notification
image=/tmp/${color}.png

# Generate color image using ImageMagick
magick -size 32x32 xc:"$color" "$image"

# Display notification with color information
if [[ "$color" ]]; then
	dunstify -t 3000 -u low -a colorpicker -i "$image" "$color, copied to clipboard."
fi
