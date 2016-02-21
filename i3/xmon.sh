#!/bin/sh

die(){
	echo $* >&2
	exit 1
}

profile=$1
profiledir=~/.display

[ -n "$profile" ] || die "No profile specified."
[ -f "$profiledir/$profile.cfg" ] || die "No profile '$profile' found."
randrargs=""

while read line; do
	output=`echo $line | awk '{print $1}'`
	  mode=`echo $line | awk '{print $2}'`
	   pos=`echo $line | awk '{print $3}'`
	rotate=`echo $line | awk '{print $4}'`

	if [[ "$mode" == off ]]; then
		randrargs="$randrargs --output $output --off"
	elif [ -z "$rotate" ]; then
		randrargs="$randrargs --output --mode $mode --pos $pos"
	else
		randrargs="$randrargs --output $output --mode $mode --pos $pos --rotate $rotate"
	fi
done <<< "`grep -v '^\s*#' $profiledir/$profile.cfg`"
# this is ugly because of /bin/sh. I really should only support bash.
# http://stackoverflow.com/questions/16854280/modifying-variable-inside-while-loop-is-not-remembered

xrandr $randrargs
