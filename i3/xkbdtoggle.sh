#!/usr/bin/env bash

# Q: But you could've solved it with an easy option in your X.org server!
# A: Yes, but I want to bootstrap my repository without root access.

KBDLIST=$HOME/.i3/kbdlist

KBDNOW=$(setxkbmap -query | awk '/^layout:/ { print $2}')

cat $KBDLIST $KBDLIST \
	| grep -A 1 "^$KBDNOW$" \
	| grep -v $KBDNOW \
	| cat - $KBDLIST \
	| head -n 1 \
	| xargs setxkbmap

if [[ "us" == "$(setxkbmap -query | awk '/^layout:/ { print $2}')" ]]; then
	xmodmap ~/.Xmodmap
fi
