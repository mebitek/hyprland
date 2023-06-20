#!/bin/bash

PLAYING_STATUS=$(mpc status 2>/dev/null | awk 'FNR==2 {print $1}' RS='[' FS=']')

if [[ -n $1 && $1 == "next" ]]; then
	echo "next song"
	mpc next 2>/dev/null
	exit
elif [[ -n $1 ]]; then
	exit
fi

if [[ $PLAYING_STATUS == "playing" ]]; then
	echo "set to pause"
	mpc pause 2>/dev/null
else
	echo "set to play"
	mpc play 2>/dev/null
fi
