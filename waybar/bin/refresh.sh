#!/bin/bash

RESOLUTION="2880x1800"
REFRESH=$(hyprctl monitors | grep $RESOLUTION | cut -d "@" -f2 | awk '{print $1}')
RR=${REFRESH:0:2}
TEXT="<span rise='-1000'>󱄄</span>"
if [[ $RR -eq 60 ]]; then
	CLASS="min"
else
	CLASS="max"
fi

TOOLTIP="${RR} Hz"
printf '%s\n' "{\"class\":\"$CLASS\",\"text\":\"$TEXT\",\"tooltip\":\"$TOOLTIP\"}"
