#!/bin/bash

case "$1" in
	all)
		$0 docker
		$0 pacman
		;;
	docker)
		docker container ls --filter status=exited --format '{{.ID}}' | xargs -r docker container rm
		docker image     ls --filter dangling=true --format='{{.ID}}' | xargs -r docker image rm 
		;;
	pacman)
		pacman -Scc
		;;
	*)
		echo "Please give parameter of: [all docker pacman]"
		;;
esac
