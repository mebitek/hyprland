#!/bin/sh
#
#
### Description:
#
# This script - let's call it 'updatenotif.sh' -
# can be used as a standalone as well as part
# of a waybar module in order to notify about
# Arch Linux package updates.
#
# Run this script at startup of your graphical
# environment. It will check for updates every
# 30 minutes.
#
#
### Dependencies:
#
# 'libnotify'
# 'pacman-contrib'
# 'fnott' (or a notification daemon of your choice),
# please also see: "https://wiki.archlinux.org/title/Desktop_notifications"
# 'papirus-icon-theme' (optional)
# 'fuzzel' (optional - waybar only)

[ "${ULOCKER}" != "$0" ] &&
	exec env ULOCKER="$0" flock -en "$0" "$0" "$@" || :

UPD=/tmp/updates
UPV=/tmp/upd_versions

sleep 9 && echo 0 >${UPD}

while [ -f ${UPD} ]; do
	checkupdates >${UPV}
	cat ${UPV} | wc -l >>${UPD}

	[ ! "$(tail -n 1 ${UPD})" -le "$(tail -n 2 ${UPD} | head -n 1)" ] &&
		notify-send -t 10000 "UPDATES" "$(tail -n 1 ${UPD})" --icon=/usr/share/icons/Dracula/scalable/apps/mx-updater.svg
	#
	#
	### Description:
	#
	# This script - let's call it 'updatenotif.sh' -
	# can be used as a standalone as well as part
	# of a waybar module in order to notify about
	# Arch Linux package updates.
	#
	# Run this script at startup of your graphical
	# environment. It will check for updates every
	# 30 minutes.
	#
	#
	### Dependencies:
	#
	# 'libnotify'
	# 'pacman-contrib'
	# 'fnott' (or a notification daemon of your choice),
	# please also see: "https://wiki.archlinux.org/title/Desktop_notifications"
	# 'papirus-icon-theme' (optional)
	# 'fuzzel' (optional - waybar only)

	[ "${ULOCKER}" != "$0" ] &&
		exec env ULOCKER="$0" flock -en "$0" "$0" "$@" || :

	UPD=/tmp/updates
	UPV=/tmp/upd_versions

	sleep 9 && echo 0 >${UPD}

	while [ -f ${UPD} ]; do
		checkupdates >${UPV}
		cat ${UPV} | wc -l >>${UPD}

		[ ! "$(tail -n 1 ${UPD})" -le "$(tail -n 2 ${UPD} | head -n 1)" ] &&
			notify-send -t 10000 "UPDATES" "$(tail -n 1 ${UPD})" \
				--icon=/usr/share/icons/Papirus-Dark/48x48/apps/mx-update.svg

		sleep 0.5h
	done

	# Source code: "https://bbs.archlinux.org/viewtopic.php?id=279522"g

	sleep 0.5h
done

# Source code: "https://bbs.archlinux.org/viewtopic.php?id=279522"
