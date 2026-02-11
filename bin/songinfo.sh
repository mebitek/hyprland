#!/bin/bash

playerctl -p jellyfin-tui metadata --format "{{title}} - {{artist}}" --follow | while read -r line; do
  # Inserisci qui il tuo comando personalizzato
  ARTIST=$(playerctl -p jellyfin-tui metadata artist)
  TRACK=$(playerctl -p jellyfin-tui metadata title)
  ALBUM=$(playerctl -p jellyfin-tui metadata album)
  FILE_NAME=$(playerctl -p jellyfin-tui metadata | grep artUrl | cut -d":" -f3)

  TEXT="$TRACK\n$ARTIST\n$ALBUM"

  if [[ $FILE_NAME != "" ]]; then
    notify-send -r 27072 "Now Playing" "$TEXT" -i $FILE_NAME
    kitty @ set-background-image $FILE_NAME
  else
    notify-send -r 27072 "Now Playing" "$TEXT"
  fi

done
