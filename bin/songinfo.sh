#!/bin/bash

REQ=$($HOME/bin/songinfo.py)

TEXT=$(echo "${REQ}" | grep -v tmp)
FILE_NAME=$(echo "${REQ}" | grep tmp)

notify-send -r 27072 "Now Playing" "$TEXT" -i $FILE_NAME
kitty @ set-background-image $FILE_NAME
