#!/bin/bash

case "$1" in
	all)
		$0 docker
		$0 pacman
		;;
	docker)
		docker container prune --force
		docker image prune --force
		;;
	pacman)
		pacman -Scc
		;;
	*)
		echo "Please give parameter of: [all docker pacman]"
		;;
esac
