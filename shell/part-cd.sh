#!/bin/sh

#correct some fast tipped cds
function c {
	if [ $1 == "d.." ]; then
		cd ..;
		pwd;
	fi
	if [ -d $1 ]; then
		cd $1;
		pwd;
	fi
	return 0;
}
