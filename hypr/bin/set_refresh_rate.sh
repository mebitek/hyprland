#!/bin/bash

MONITOR="eDP-1"
RESOLUTION="2880x1800"
POSITION="0x0"
SCALE="1.25"

RR=$(hyprctl monitors -j | jq -r --arg m "$MONITOR" '.[] | select(.name == $m) | .refreshRate | floor')

if [[ $RR -le 60 ]]; then
  NEW=90
else
  NEW=60
fi

hyprctl eval "hl.monitor({ output = \"${MONITOR}\", mode = \"${RESOLUTION}@${NEW}\", position = \"${POSITION}\", scale = ${SCALE} })"
