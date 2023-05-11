#!/bin/sh

[ ! -r ~/.config/mbsync/mbsyncrc ] && exit 0

# Download new mail
if ps -C mbsync >/dev/null; then
	exit 0
fi

mbsync -c ~/.config/mbsync/mbsyncrc -a -q

prefix="${HOME}/.mail/"

# Loop through every account in ~/.mail
for account in "$prefix"*; do
	# Find all unread mail whose file is newer that the last time this script was run and count them
	newcount=$(find "$account"/Inbox/new -type f -newer ~/.config/neomutt/.mailsynclast 2>/dev/null | wc -l)
	# Are there any new unread mail?
	if [ "$newcount" -gt "0" ]; then
		# Send a notification
		notify-send -i '/usr/share/icons/Dracula/scalable/apps/mail-generic.svg' "New Email" "${account#$prefix}\n$newcount new messages." &
	fi
done

# Update access time of a marker file
touch ~/.config/neomutt/.mailsynclast
