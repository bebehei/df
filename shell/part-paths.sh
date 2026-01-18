#!/bin/sh

function set_path(){
	if [[ -d "$1" ]]; then
		export PATH=$1:$PATH
	fi
}

set_path ~/.local/bin/
set_path ~/.bin

export GOPATH=$HOME/.go
export GOBIN=$HOME/.gobin
set_path $GOPATH/bin
set_path $GOBIN
