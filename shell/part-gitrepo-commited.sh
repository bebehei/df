#!/bin/sh

cfgrepo=`readlink ~/.profile.d/gitrepo-commited.sh`
repo=`dirname $cfgrepo`
changes=`git -C $repo status --porcelain | wc -l`

if [ $changes -gt 0 ]; then
	echo -e '\e[01;31m'
	echo '####################################'
	echo '# GIT-config-Repo is not commited! #'
	echo '####################################'
	echo -e '\e[0m'
fi
