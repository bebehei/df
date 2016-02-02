#!/bin/bash

BASE=$(dirname $(readlink -f $0))

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
	src=$(echo $line | awk '{print $1}')
	dst=$(echo $line | awk '{print $2}')

	mkdir -p $(dirname $dst)
	# if file is a symbolic link, remove the old one
	[[ -L $dst ]] && rm $dst
	ln -s $src $dst
done
