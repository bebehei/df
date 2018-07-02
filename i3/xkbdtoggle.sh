#!/usr/bin/env bash

# Q: But you could've solved it with an easy option in your X.org server!
# A: Yes, but I want to bootstrap my repository without root access.

KBDNOW=$(setxkbmap -query | awk '/^layout:/ { print $2 }')

case "${KBDNOW}" in
	us)
		setxkbmap "de"
		;;
	*)
		setxkbmap "us"
		xmodmap ~/.Xmodmap
		;;
esac
