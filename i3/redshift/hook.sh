#!/bin/sh

case $1 in
	period-changed)
		exec notify-send "Redshift" "Period changed to $3"
		;;
	*)
		exec notify-send "Redshift" "Redshift just fired an unknown hook with these options: '$*'. Ah, of course, this notification is just here, to troll you! :-P"
		;;
esac
