#!/bin/sh
#check if git-repo has new entries
if [ ! -f $HOME/.configrepo ]; then
    echo ".configrepo missing!"
    return 1
fi
cfgrepo=`readlink $HOME/.configrepo`
repo=`dirname $cfgrepo`
changes=`cd $repo && git status --porcelain | wc -l`

if [ $changes -gt 0 ]; then
	echo -e '\e[01;31m'
	echo '####################################'
	echo '# GIT-config-Repo is not commited! #'
	echo '####################################'
	echo -e '\e[0m'
fi
