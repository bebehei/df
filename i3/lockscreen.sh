#!/usr/bin/env bash

[ -f "~/.lockvars" ] && [ -r "~/.lockvars" ] && . ~/.lockvars

LOCK_TIME=${LOCK_TIME:-3}
LOCK_NOTIFY_TIME=${LOCK_NOTIFY_TIME:-15}

SOCK_PATH="/run/user/${UID}/i3/locksock-${XDG_SESSION_ID:-unknown}"

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
	  -f force lock
	  -l execute the locker
	  -n send notification
	  -d execute the xautolock daemon
	  -h help

	Mind, that the options are order-sensitive:
	  -lf != -fl && -l == -lf

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
	socat /dev/null "UNIX-LISTEN:${SOCK_PATH}" &
	local socat_pid=$!

	${LOCK_CMD} \
	  -t \
	  -n \
	  -i ~/.lockscreen
	kill ${socat_pid}
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

daemon_signallistener(){
	dbus-monitor --system --profile path=/org/freedesktop/login1 2>/dev/null \
		| while read _ _ _ _ _ _ _ signal _; do
			case "${signal}" in
				PrepareForSleep) $0 -fl & ;;
				*) true;;
			esac
		done
}

daemon_xautolock() {
	# Do not use -secure option, as we have to use -locknow
	xautolock \
	  -time $LOCK_TIME \
	  -locker "$0 -l" \
	  -nowlocker "$0 -fl" \
	  -notify $LOCK_NOTIFY_TIME \
	  -notifier "$0 -n" \
	  -noclose
}

# Listen for signals from the DBus Service as
# xautolock does not always catch system sleeps
daemon(){
	daemon_signallistener &
	local pid_signal=$!

	daemon_xautolock &
	local pid_xautolock=$!

	trap "kill ${pid_xautolock} ${pid_signal} && wait" SIGTERM SIGQUIT
	wait
}

force=0

while getopts ":hdfln" opt; do
	case $opt in
		h)
			usage
			;;
		f)
			force=1
			;;
		l)
			[ -S "${SOCK_PATH}" ] \
				|| (checkfull && (lock || encrypt_the_chest))
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
