#!/bin/bash

RESOLUTION="2880x1800"
MONITOR="eDP-1"
POSITION="0x0"
SCALE="1.25"

REFRESH=$(hyprctl monitors | grep $RESOLUTION | cut -d "@" -f2 | awk '{print $1}')
RR=${REFRESH:0:2}
if [[ $RR -eq 60 ]]; then
	RR=90
else
	RR=60
fi

hyprctl keyword monitor ${MONITOR},${RESOLUTION}@${RR},${POSITION},${SCALE}
