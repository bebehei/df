#!/usr/bin/bash

[ -f "~/.lockvars" ] && [ -r "~/.lockvars" ] && . ~/.lockvars

LOCK_TIME=${LOCK_TIME:-3}
LOCK_NOTIFY_TIME=${LOCK_NOTIFY_TIME:-15}

PROGNAME=$(basename $0)

error(){
	echo -e '\e[01;31m'$*'\e[0m' >&2
}

usage(){
	#TODO
	cat >&2 <<-FIN
	Usage:
	  -f force lock
	  -l execute the locker
	  -n send notification
	  -d execute the xautolock daemon
	  -h help

	  Mind, that the options are order-sensitive. -lf != -fl && -l == -lf
		(-fl is probably the thing you want)
	FIN
	exit 1
}

checkfull(){
	[ 1 -eq "$force" ] || ~/.bin/checknofullscreen
}

encrypt_the_chest(){
	if command -v systemctl &>/dev/null; then
		systemctl hibernate || shutdown now
	else
		shutdown now
	fi
}

lock(){
	i3lock \
	  -p win \
	  -t \
	  -i ~/.lockscreen
}

notification(){
	notify-send \
	  -a lockscreen \
	  -c lock-warn \
	  -u critical \
	  -t 100 \
	  -i system-lock-screen \
	  "Locking Screen" \
	  "Will Lock Screen in 15s"
}

daemon(){
	# Do not use -secure option, as we have to use -locknow
	xautolock \
	  -time $LOCK_TIME \
	  -locker "$0 -l" \
	  -nowlocker "$0 -fl" \
	  -notify $LOCK_NOTIFY_TIME \
	  -notifier "$0 -n" \
	  -noclose
}

force=0

while getopts ":hdfLln" opt; do
	case $opt in
		h)
			usage
			;;
		L)
			xautolock -locknow

			# If xautolock is disabled, -locknow won't work.
			# Therefore in addition we enable it again and
			# lock it then again, to make sure it's locked.
			xautolock -enable
			sleep 1
			xautolock -locknow
			;;
		f)
			force=1
			;;
		l)
			checkfull && (lock || encrypt_the_chest)
			;;
		n)
			checkfull && notification
			;;
		d)
			daemon
			;;
		\?)
			error "Invalid option: -${opt}"
			usage
			;;
		:)
			error "Option -${opt} requires an argument."
			usage
			;;
	esac
done
