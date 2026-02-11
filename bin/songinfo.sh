#!/usr/bin/env bash

SEP=$'\x1f'

playerctl -p jellyfin-tui --follow metadata \
  --format "{{status}}${SEP}{{title}}${SEP}{{artist}}${SEP}{{album}}${SEP}{{mpris:artUrl}}" |
  while IFS=$'\x1f' read -r STATUS TRACK ARTIST ALBUM ARTURL; do

    # reagisce solo se effettivamente in Playing
    [[ "$STATUS" != "Playing" ]] && continue

    ARTURL="${ARTURL#file://}"
    TEXT="$TRACK\n$ARTIST\n$ALBUM"

    if [[ -n "$ARTURL" && -f "$ARTURL" ]]; then
      notify-send -r 27072 "Now Playing" "$TEXT" -i "$ARTURL"
      kitty @ set-background-image "$ARTURL"
    else
      notify-send -r 27072 "Now Playing" "$TEXT"
    fi

  done
