#!/bin/sh
#check if git-repo has new entries
if [[ $(cd $(dirname $(readlink $HOME/.bashrc)) && git status -s) ]]; then
	echo -e '\e[01;31m'
	echo '####################################'
	echo '# GIT-config-Repo is not commited! #'
	echo '####################################'
	echo -e '\e[0m'
fi
