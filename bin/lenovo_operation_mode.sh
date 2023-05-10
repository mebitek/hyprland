#!/bin/bash

INTELLIGENT="0x0"
EXTREME="0x1"
BATTERY="0x2"

echo '\_SB.PCI0.LPC0.EC0.SPMO' >/proc/acpi/call
ACTUAL_MODE=$(
	tr -d '\0' </proc/acpi/call
)

echo $ACTUAL_MODE

if [[ $ACTUAL_MODE == $BATTERY ]]; then
	echo "actual mode is ${BATTERY}, setting to INTELLIGENT"
	echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x000FB001' >/proc/acpi/call
	notify-send -r 6660 -t 10000 "System Performance Mode: Intelligent Cooling" --icon=/usr/share/icons/Dracula/scalable/apps/preferences-system-performance.svg
elif [[ $ACTUAL_MODE == $INTELLIGENT ]]; then
	echo "actual mode is ${INTELLIGENT}, setting to EXTREME"
	echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0012B001' >/proc/acpi/call
	notify-send -r 6660 -t 10000 "System Performance Mode: Extreme Performance" --icon=/usr/share/icons/Dracula/scalable/apps/preferences-system-performance.svg
elif [[ $ACTUAL_MODE == $EXTREME ]]; then
	echo "actual mode is ${EXTREME}, setting to BATTERY"
	echo '\_SB.PCI0.LPC0.EC0.VPC0.DYTC 0x0013B001' >/proc/acpi/call
	notify-send -r 6660 -t 10000 "System Performance Mode: Battery Saving" --icon=/usr/share/icons/Dracula/scalable/apps/preferences-system-performance.svg
else
	echo "invalid mode"
	exit 1
fi

echo '\_SB.PCI0.LPC0.EC0.SPMO' >/proc/acpi/call
ACTUAL_MODE=$(
	tr -d '\0' </proc/acpi/call
)

echo $ACTUAL_MODE
exit 0
