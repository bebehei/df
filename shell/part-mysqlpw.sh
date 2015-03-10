#!/bin/sh

#The function will find the given user and search for a mysql-password
#in the home-directory, which will get printed out!
#arg1: user where to find a config-file
#      if not given, it uses the current user in the $HOME and $USER-Variable

function mysqlpw() {
    local H=$HOME
    local U=$USER

    # use different user, if arg1 given
	if [ ! -z $1 ]; then

        # check if given user is even existing
	    if ! id $1 >/dev/null 2>/dev/null; then
	        echo user $1 not existing >&2
	        return 1
        fi

		U=$1
		H=`grep ^$1: /etc/passwd | cut -d ":" -f 6`

	fi;

    local mysql_cnf="$H/.my.cnf"

	if [ ! -e $mysql_cnf ]; then
	    echo $mysql_cnf not existing >&2 && return 1
	fi

	if [ ! -r $mysql_cnf ]; then
	    echo $mysql_cnf not readable >&2 && return 1
	fi

    local PW=`(grep "password=" $mysql_cnf || echo undefined) | cut -d "=" -f 2`

	echo MySQL-Password for user $U is $PW
}
