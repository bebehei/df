#!/bin/sh

case $1 in
	display)
		xrandr \
			--output HDMI1 --off \
			--output DP1 --off \
			--output VIRTUAL1 --off \
			--output eDP1  --mode 1920x1080 --pos    0x0    --rotate normal \
			--output HDMI2 --off \

		;;
	hdmi)
		xrandr \
			--output HDMI1 --off \
			--output DP1 --off \
			--output VIRTUAL1 --off \
			--output eDP1  --off \
			--output HDMI2 --mode 1920x1080 --pos    0x0    --rotate normal \

		;;
	right)
		xrandr \
			--output HDMI1 --off \
			--output DP1 --off \
			--output VIRTUAL1 --off \
			--output eDP1  --mode 1920x1080 --pos    0x0    --rotate normal \
			--output HDMI2 --mode 1920x1080 --pos 1920x0    --rotate normal \

		;;
	left)
		xrandr \
			--output HDMI1 --off \
			--output DP1 --off \
			--output VIRTUAL1 --off \
			--output eDP1  --mode 1920x1080 --pos 1920x0    --rotate normal \
			--output HDMI2 --mode 1920x1080 --pos    0x0    --rotate normal \

		;;
	mirror)
		xrandr \
			--output HDMI1 --off \
			--output DP1 --off \
			--output VIRTUAL1 --off \
			--output eDP1  --mode 1920x1080 --pos    0x0    --rotate normal \
			--output HDMI2 --mode 1920x1080 --pos    0x0    --rotate normal \

		;;
	*)
		echo "give one of the following values as argument:" >&2
		echo "    hdmi" >&2
		echo "    display" >&2
		echo "    mirror" >&2
		echo "    right" >&2
		echo "    left" >&2
		exit 1
esac
