#!/bin/sh

if [ "${BASH_VERSION}" ] && [ -r /usr/share/doc/pkgfile/command-not-found.bash ]; then
	. /usr/share/doc/pkgfile/command-not-found.bash
fi

if [ "${ZSH_VERSION}" ] && [ -r /usr/share/doc/pkgfile/command-not-found.zsh ]; then
	. /usr/share/doc/pkgfile/command-not-found.zsh
fi
