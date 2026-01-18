#!/bin/sh

#correct some fast tipped cds
c() {
	if [ "${1}" = "d.." ]; then
		cd .. || return
		pwd
	fi
	if [ -d "${1}" ]; then
		cd "${1}" || return
		pwd
	fi
	return 0
}
