#!/usr/bin/env bash

BASE="$(dirname "$(readlink -f "${0}")")"

die(){ error "$*"; exit 1; }
error(){ printf "\e[31m%s\e[0m\n" "$*" >&2; }
warn(){  printf "\e[33m%s\e[0m\n" "$*" >&2; }

# You can use another base or file by setting the
# environment DEPL_BASE or DEPL_FILE
DEPL_BASE="${DEPL_BASE:-${BASE}}"
DEPL_FILE="${DEPL_FILE:-${BASE}/deployment}"

[ -r "${DEPL_FILE}" ] || \
	die "Deployment-file '${DEPL_FILE}' not readable."

# If git submodule is already able to handle --jobs, use parallel fetch!
# If not, update everything in serial way.
git -C "${DEPL_BASE}" config --local submodule.fetchJobs 0
git -C "${DEPL_BASE}" submodule update --init --recursive

grep -v --perl-regexp -- '^\s*#' "${DEPL_FILE}" \
	| while read src dst ; do
	src="${src//\~/${HOME}}"
	dst="${dst//\~/${HOME}}"

	mkdir -p -- "$(dirname -- "${dst}")"
	# if file is a symbolic link, remove the old one
	if [[ "$(readlink -f -- "${BASE}/${src}")" != "$(readlink -f -- "${dst}")" ]]; then
		if [ -L "${dst}" ]; then
			printf "Updating link '%s'\n  old: '%s'\n  new: '%s'\n" \
							"${src}" \
							"$(readlink -f -- "${BASE}/${src}")" \
							"$(readlink -f -- "${dst}")"
			rm -- "${dst}"
		fi
		[ ! -e "${dst}" ] && ln -s -- "${BASE}/${src}" "${dst}"
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
