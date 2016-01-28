#!/bin/sh

count=0
waiting=30 #number of seconds it will display wehn host is not online

while true; do
	ping -c 1 $1 2>&1 >/dev/null && break
	sleep 1
	count=$(( $count + 1))
	if [ $count -gt $waiting ]; then
		count=0
		notify-send -i network-transmit "Host wait" "Still waiting for host '$1'."
	fi
done

notify-send -i network-transmit-receive "Host online!" "Host '$1' is now online!!!"
