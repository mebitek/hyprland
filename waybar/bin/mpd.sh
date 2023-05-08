#!/bin/bash

PLAYING_STATUS=$(mpc status 2>/dev/null | awk 'FNR==2 {print $1}' RS='[' FS=']')

if [[ $PLAYING_STATUS == "playing" ]]; then
	echo "set to pause"
	mpc pause 2>/dev/null
else
	echo "set to play"
	mpc play 2>/dev/null
fi
