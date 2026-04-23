#!/bin/bash

#PLAYING_STATUS=$(mpc status 2>/dev/null | awk 'FNR==2 {print $1}' RS='[' FS=']')
PLAYING_STATUS=$(playerctl -p jellyfin-tui status)

if [[ -n $1 && $1 == "next" ]]; then
  echo "next song"
  playerctl -p jellyfin-tui next 2>/dev/null
  exit
elif [[ -n $1 ]]; then
  exit
fi

if [[ $PLAYING_STATUS == "Playing" ]]; then
  echo "set to pause"
  playerctl -p jellyfin-tui pause 2>/dev/null
else
  echo "set to play"
  playerctl -p jellyfin-tui play 2>/dev/null
fi
