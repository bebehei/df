#!/bin/sh
#The function will find the given user and search for a mysql-password in its
#Home-direcotory, which will get printed out!
#arg1: user where to find a config-file
#      if not given, it uses the current user in the $HOME and $USER-Variable
function mysqlpw() {
	if [[ -z $1 ]]; then
		H=$HOME
		U=$USER
		elif [[ `id $1` ]]; then
			U=$1;
			H=$(grep ^${1}: /etc/passwd | cut -d":" -f 6);
		else 
			return 1;
	fi;

	echo MySQL-Password for user $U is $(grep "password=" $H/.my.cnf | cut -d"=" -f 2);
}
