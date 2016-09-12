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

grep -v --perl-regexp '^\s*#' $DEPL_FILE | while read line; do
	dst=$(echo "${line//\~/$HOME}" | awk '{print $2}')
	# if file is a symbolic link, remove it
	[ -L $dst ] && rm $dst
done
