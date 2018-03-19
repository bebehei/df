#!/bin/sh

die(){ echo $* >&2; exit 1; }

profile=$1
profiledir=~/.display

[ -n "$profile" ] || die "No profile specified."
[ -f "$profiledir/$profile.cfg" ] || die "No profile '$profile' found."

grep -v '^\s*#' $profiledir/$profile.cfg \
	| while read output mode pos rotate primary; do

	echo "--output $output"
	if [ "$mode" == off ]; then
		echo "--off"
	else
		echo "--mode $mode"
		echo "--pos $pos"
		echo "${rotate:+--rotate $rotate}"
		echo "${primary:+--primary}"
	fi
done | xargs xrandr
