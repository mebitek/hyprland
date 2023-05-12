#!/bin/bash

INTELLIGENT="0x0"
EXTREME="0x1"
BATTERY="0x2"

echo '\_SB.PCI0.LPC0.EC0.SPMO' >/proc/acpi/call
ACTUAL_MODE=$(
	tr -d '\0' </proc/acpi/call
)

if [[ $ACTUAL_MODE == $BATTERY ]]; then
	MODE="Battery Saving"
	CLASS="battery"
	TEXT="<span size='large' rise='-1000'>󱤆</span>"
elif [[ $ACTUAL_MODE == $INTELLIGENT ]]; then
	MODE="Intelligent Cooling"
	CLASS="intelligent"

	TEXT="<span size='large' rise='-1000'>󱤋</span>"
elif [[ $ACTUAL_MODE == $EXTREME ]]; then
	MODE="Extreme Performance"
	CLASS="extreme"
	TEXT="<span size='large'rise='-1000'>󰓅</span>"
else
	MODE="Invalid"
	CLASS="invalid"
	TEXT="<span size='large' rise='-1000'>󰂭</span>"
fi

printf '%s\n' "{\"class\":\"$CLASS\",\"text\":\"$TEXT\",\"tooltip\":\"$MODE\"}"
