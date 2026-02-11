#!/bin/bash

#PLAYING_STATUS=$(mpc status 2>/dev/null | awk 'FNR==2 {print $1}' RS='[' FS=']')
PLAYING_STATUS=$(playerctl -p jellyfin-tui status)

if [[ $PLAYING_STATUS == "Playing" ]]; then
  TEXT=" "
  CLASS="playing"
elif [[ $PLAYING_STATUS == "Paused" ]]; then
  TEXT=" "
  CLASS="paused"
elif [[ $PLAYING_STATUS == "Stopped" ]]; then
  TEXT=" "
  CLASS="stopped"
fi

ARTIST=$(playerctl -p jellyfin-tui metadata artist)
TRACK=$(playerctl -p jellyfin-tui metadata title)
ALBUM=$(playerctl -p jellyfin-tui metadata album)
FILE_NAME=$(playerctl -p jellyfin-tui metadata | grep artUrl | cut -d":" -f3)

INFO="$TRACK\n$ARTIST\n$ALBUM"

TOOLTIP="<span>$INFO</span>"

printf '%s\n' "{\"class\":\"$CLASS\",\"text\":\"$TEXT\",\"tooltip\":\"$TOOLTIP\"}"
