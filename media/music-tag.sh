#!/bin/bash

if [[ $# -eq 0 ]]; then
	picard "~/Music/new-music/"
else
	if [[ -d "$1" ]]; then
		picard "$1"
	fi
fi