#!/usr/bin/bash

[ -f "~/.lockvars" ] && [ -r "~/.lockvars" ] && . ~/.lockvars

LOCK_TIME=${LOCK_TIME:-3}
LOCK_NOTIFY_TIME=${LOCK_NOTIFY_TIME:-15}

SOCK_PATH="/run/user/${UID}/i3/locksock"

if [ -n "${WAYLAND_DISPLAY}" ]; then
	LOCK_CMD="swaylock"
else
	LOCK_CMD="i3lock -p win"
fi

PROGNAME=$(basename $0)

error(){
	echo -e '\e[01;31m'$*'\e[0m' >&2
}

usage(){
	#TODO
	cat >&2 <<-FIN
	Usage:
	  -L lock now via xautolock
	  -n send notification
	  -d execute the xautolock daemon
	  -h help
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
	socat - "UNIX-LISTEN:${SOCK_PATH}" &
	${LOCK_CMD} \
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
			[ ! -S "${SOCK_PATH}" ] \
				&& checkfull \
				&& (lock || encrypt_the_chest)
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
