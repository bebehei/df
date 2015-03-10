#!/bin/bash

if [ -z $DEPLOY ]; then
	DEPLOY="./deployment"
fi
if [ ! -r $DEPLOY ]; then
	echo "Deployment-file $DEPLOY not readable." >&2
	exit 1
fi

git submodule update --init --recursive

BASE=$(readlink -f $(dirname $DEPLOY))

updLink(){
	mkdir -p $(dirname $2)
	# if file is a symbolic link, remove the old one
	[[ -L $2 ]] && rm $2
	ln -s $1 $2
}

cat $DEPLOY | while read line; do
	src=$(echo $line | cut -d ' ' -f 1)
	dst=$(echo $line | cut -d ' ' -f 2)

	# make a difference if destination has got leading slash
	#    leading slash -> absolute link
	# no leading slash -> link based on $HOME 
	if [[ "$dst" =~ ^/ ]]; then
		updLink $BASE/$src $dst
		else
			updLink $BASE/$src $HOME/$dst
	fi
done

updLink $BASE/deployment $HOME/.configrepo
