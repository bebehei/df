#!/usr/bin/env bash

BASE=$(dirname $(readlink -f $0))

case $1 in
	XF86AudioPlay)
		playerctl play-pause
	;;
	XF86AudioNext)
		playerctl next
	;;
	XF86AudioPrev)
		playerctl previous
	;;
	XF86AudioStop)
		playerctl stop
	;;

	XF86AudioRaiseVolume)
		pulseaudio-ctl up
	;;
	XF86AudioLowerVolume)
		pulseaudio-ctl down
	;;
	XF86AudioMute)
		pulseaudio-ctl mute
	;;
	XF86MonBrightnessUp)
		xbacklight -inc 5%
	;;
	XF86MonBrightnessDown)
		xbacklight -dec 5%
	;;
	XF86Display)
		# TODO: Dual-setup of VGA/HDMI does not work
		# TODO: Setup for VGA requires adaptation of /sys/class/-path and xmon.sh params
		# If HDMI connected -> allow switching of display/default
		# If unplugged -> always switch to display
		if grep '^connected' /sys/class/drm/card*HDMI*/status &>/dev/null; then
			if xrandr --listmonitors | grep HDMI &>/dev/null; then
				$BASE/xmon.sh display
			else
				$BASE/xmon.sh default
			fi
		else
			$BASE/xmon.sh display
		fi
	;;
	*)
		echo "Unknown key '$1'" >&2
		exit 1
	;;
esac
