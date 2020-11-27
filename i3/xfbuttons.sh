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

	XF86AudioMicMute)
		pulseaudio-ctl mute-input
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
		brightnessctl s +2.5%
	;;
	XF86MonBrightnessDown)
		brightnessctl s 2.5%-
	;;
	*)
		echo "Unknown key '$1'" >&2
		exit 1
	;;
esac
