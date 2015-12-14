#!/bin/sh
function set_path(){
	if [[ -d "$1" ]]; then
		export PATH=$1:$PATH
	fi
}

set_path ~/.local/bin/
set_path ~/bin
