#!/bin/bash
if [[ $# -eq 0 ]]; then
	find ~/Music -iname '*.mp3' -execdir mp3gain -q -k -p -r {} \+
else
	if [[ -d "$1" ]]; then
		find $1 -iname '*.mp3' -execdir mp3gain -q -k -p -r {} \+
	fi
fi
