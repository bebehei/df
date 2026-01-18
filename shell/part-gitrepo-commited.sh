#!/bin/sh

case "$-" in
	*i*)
		# This shell is interactive, if not ignore this part
		# If printing this in non-interactive shells, it'll may prevent scp to work
		repo="$(dirname "$(readlink -f ~/.profile.d/10-gitrepo-commited.sh)")"
		changes="$(git -C "${repo}" status --porcelain | wc -l)"

		if [ "${changes}" -gt 0 ]; then
			printf '\e[01;31m\n'                            >&2
			printf '####################################\n' >&2
			printf '# GIT-config-Repo is not commited! #\n' >&2
			printf '####################################\n' >&2
			printf '\e[0m\n'                                >&2
		fi
		;;
esac
