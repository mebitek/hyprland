#!/bin/bash

PLAYING_STATUS=$(mpc status 2>/dev/null | awk 'FNR==2 {print $1}' RS='[' FS=']')

if [[ $PLAYING_STATUS == "playing" ]]; then
	TEXT=" "
	CLASS="playing"
elif [[ $PLAYING_STATUS == "paused" ]]; then
	TEXT=" "
	CLASS="paused"
elif [[ $PLAYING_STATUS == "stopped" ]]; then
	TEXT=" "
	CLASS="stopped"
fi

TOOLTIP="<span>test tooltip</span>"

printf '%s\n' "{\"class\":\"$CLASS\",\"text\":\"$TEXT\",\"tooltip\":\"$TOOLTIP\"}"
