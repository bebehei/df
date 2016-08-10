#!/bin/sh

case "$-" in
	*i*)
		# This shell is interactive, if not ignore this part
		# If printing this in non-interactive shells, it'll may prevent scp to work
		cfgrepo=`readlink ~/.profile.d/10-gitrepo-commited.sh`
		repo=`dirname $cfgrepo`
		changes=`git -C $repo status --porcelain | wc -l`

		if [ $changes -gt 0 ]; then
			echo -e '\e[01;31m'                            >&2
			echo -e '####################################' >&2
			echo -e '# GIT-config-Repo is not commited! #' >&2
			echo -e '####################################' >&2
			echo -e '\e[0m'                                >&2
		fi
		;;
esac
