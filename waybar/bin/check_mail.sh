#!/bin/bash

#sync mail

~/bin/mailboxes_sync.sh

prefix="${HOME}/.mail/"

# Loop through every account in ~/.mail
TOOLTIP=""
CLASS="mail"
TEXT="<span rise='-1000'>󰇰</span>"
for account in "$prefix"*; do
	# Find all unread mail whose file is newer that the last time this script was run and count them
	newcount=$(find "$account"/Inbox/new -type f 2>/dev/null | wc -l)
	# Are there any new unread mail?
	if [ "$newcount" -gt "0" ]; then
		# Send a notification
		CLASS="newmail"
		TEXT="<span rise='-1000'>󰵂</span>"
		TOOLTIP=$(echo "$TOOLTIP\n${account#$prefix}:\t${newcount}")
	fi
done
if [[ -z $TOOLTIP ]]; then
	TOOLTIP="no new mail"
fi
printf '%s\n' "{\"class\":\"$CLASS\",\"text\":\"$TEXT\",\"tooltip\":\"$TOOLTIP\"}"
