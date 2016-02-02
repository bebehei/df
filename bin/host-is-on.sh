#!/bin/sh

if [ $# -eq 0 ]; then
	echo "No host given!" >&2
	exit 1
fi

# repeat a notification if the host is not online after this amount of seconds yet
waiting=30

count=0
while ! ping -W 1 -w 1 -c 1 $1 2>&1 >/dev/null; do
	sleep 1
	count=$(( $count + 1))
	if [ $count -gt $waiting ]; then
		count=0
		notify-send -i network-transmit "Host wait" "Still waiting for host '$1'."
	fi
done

notify-send -i network-transmit-receive "Host online!" "Host '$1' is now online!!!"
