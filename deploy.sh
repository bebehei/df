#!/bin/bash

BASE=$(dirname $(readlink -f $0))

error(){ echo -e "\e[31m$*\e[0m"; }
warn(){  echo -e "\e[33m$*\e[0m"; }

# You can use another base or file by setting the
# environment DEPL_BASE or DEPL_FILE
DEPL_BASE=${DEPL_BASE:-$BASE}
DEPL_FILE=${DEPL_FILE:-$BASE/deployment}

if [ ! -r $DEPL_FILE ]; then
	echo "Deployment-file '$DEPL_FILE' not readable." >&2
	exit 1
fi

git -C $DEPL_BASE submodule update --init --recursive

grep -v --perl-regexp '^\s*#' $DEPL_FILE | while read line; do
	src=$(echo "${line//\~/$HOME}" | awk '{print $1}')
	dst=$(echo "${line//\~/$HOME}" | awk '{print $2}')

	mkdir -p $(dirname $dst)
	# if file is a symbolic link, remove the old one
	if [[ "$(readlink -f $BASE/$src)" != "$(readlink -f $dst)" ]]; then
		if [ -L $dst ]; then
			echo -e "Updating link '$src'\n  old: '$(readlink -f $BASE/$src)'\n  new: '$(readlink -f $dst)'"
			rm $dst
		fi
		[ ! -e $dst ] && ln -s $BASE/$src $dst
	fi
done

git -C $DEPL_BASE log -p $DEPL_FILE \
	| sed -n -e '/^+++/d' -e '/^+\s*#/d' -e 's/^\+//p' \
	| sort -u \
	| comm -23 - <(grep -v --perl-regexp '^\s*#' $DEPL_FILE | sort -u) \
	| while read line; do
		src=$(echo "${line//\~/$HOME}" | awk '{print $1}')
		dst=$(echo "${line//\~/$HOME}" | awk '{print $2}')


		if [[ "$(readlink -f $BASE/$src)" == "$(readlink -f $dst)" ]]; then
			if [ "x$print_header" == "x" ]; then
				echo "Stale Link Checker"
				echo "It's a good practice to remove doubled and stale links."
				print_header=printed
			fi
			error "Doubled link: '$dst'"
		elif [ -L "$dst" ]; then
			if [ "x$print_header" == "x" ]; then
				echo "Stale Link Checker"
				echo "It's a good practice to remove doubled and stale links."
				print_header=printed
			fi
			warn "Stale link: '$dst'"
		fi
	done
