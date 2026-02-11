#!/bin/bash

#PLAYING_STATUS=$(mpc status 2>/dev/null | awk 'FNR==2 {print $1}' RS='[' FS=']')
PLAYING_STATUS=$(playerctl -p jellyfin-tui status)

if [[ -n $1 && $1 == "next" ]]; then
  echo "next song"
  playerctl next 2>/dev/null
  exit
elif [[ -n $1 ]]; then
  exit
fi

if [[ $PLAYING_STATUS == "Playing" ]]; then
  echo "set to pause"
  playerctl pause 2>/dev/null
else
  echo "set to play"
  playerctl play 2>/dev/null
fi
