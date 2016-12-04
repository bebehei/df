#!/bin/bash

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
		xbacklight -inc 10%
	;;
	XF86MonBrightnessDown)
		xbacklight -dec 10%
	;;
		
esac
