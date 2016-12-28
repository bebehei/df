#!/bin/bash

case "$1" in
	all)
		$0 docker
		$0 pacman
		;;
	docker)
		docker ps -a | awk '/Exited/{print $1}' | xargs -r docker rm
		docker images | awk '/none/{print $3}' | xargs -r docker rmi
		;;
	pacman)
		pacman -Scc
		;;
	*)
		echo "Please give parameter of: [all docker pacman]"
		;;
esac
