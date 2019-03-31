#!/bin/sh

#alias definitions
alias chmox="chmod +x"
alias cd..="cd .."

# Steam locomotive on acid!
alias LS='sl -F'
alias ls-l='sl -l'

alias quit="exit"
alias :q="exit"
alias :qa="exit"
alias :q!="exit"
alias :qw="exit"

alias vim="vim -p"
alias vi="vim -p"

alias nano='vim -p'
alias pico='vim -p'
alias emacs='gvim -p'
alias gedit='gvim -p'
alias kate='gvim -p'

# kitty is not installed on every remote host
# As kitty sets TERM=xterm-kitty, we should indicate
# to the remote host the xterm compatibility
alias ssh='TERM=xterm ssh'

alias fuck="sudo !!"

# only list the IO of <processname> with iotop
# io <processname>
io(){
	local sudo_needed
	[ ! -z "$(type sudo 2>/dev/null)" -a "$USER" != 'root' ] \
		&& sudo_needed="sudo"

	${sudo_needed} iotop -p$(pidof "$1" | sed 's/ / -p/g')
}

# open any file wihtout the knowledge of what type it is
alias of="xdg-open"

if [ ! -z "$(type sudo 2>/dev/null)" -a "$USER" != 'root' ]; then
	#create sudo aliases WITHOUT leading s
	for sudo in mount umount iftop iotop fsadm lvchange lvconvert lvcreate lvdisplay lvextend lvm lvmchange lvmconf lvmconfig lvmdiskscan lvmdump lvmetad lvmsadc lvmsar lvreduce lvremove lvrename lvresize lvs lvscan pvchange pvck pvcreate pvdisplay pvmove pvremove pvresize pvs pvscan vgcfgbackup vgcfgrestore vgchange vgck vgconvert vgcreate vgdisplay vgexport vgextend vgimport vgimportclone vgmerge vgmknodes vgreduce vgremove vgrename vgs vgscan vgsplit backup;
	do
		type $sudo > /dev/null 2>&1 && alias $sudo="sudo $sudo";
	done
	unset sudo

	#create sudo aliases WITH leading s
	for sudo in ps vim chown chmod;
	do
		type $sudo > /dev/null 2>&1  && alias s$sudo="sudo $sudo";
	done
	unset sudo

	type pacman >/dev/null 2>&1 && pacman(){
		local sudo_needed
		# Check if pacman has -S, -R or -U option
		# which should indicate in most times if we need sudo
		echo "$*" | grep -- "-[SRU]" >/dev/null 2>&1 \
			&& sudo_needed="sudo"
		${sudo_needed} /usr/bin/pacman $*
	}

fi

#END alias-definitions

alias pwedit="sudo vim -p /etc/{passwd,group,shadow,gshadow}"
alias cmdlist='find $(echo $PATH | tr ":" "\n") | awk -F / "{print \$NF}" | sort -u'
alias makepasswd='makepasswd --minchars=10 --maxchars=25 --count=10'

# set DPMS values in minutes
dpms(){
	[ -z "${1}" ] && echo "No time given!" && return 1
	local secs=`expr "60" "*" "${1}"`
	xset s off
	xset dpms "${secs}" "${secs}" "${secs}"
}

# scan your local network with nmap
#
# usage:
#  snet <nmap-args>
# example: (scan for every HP printer in the network)
#  snet -p jetdirect --open
#
# - get all non-linklocal IP addrs from ip
# - pipe the IPs through ipcalc to get the network ID
#   - this is neccessary to prevent scanning the same network twice
#   - likely to experience if connected via wifi and ethernet
# - xargs it to nmap at the end

alias snet="ip addr | \\grep -v "inet6" | \\grep inet | cut -d \" \" -f 6 | \\grep -v '127\\.0\\.[0-1]\\.[0-1]' | xargs -n 1 ipcalc | awk '/Network:/{print \$2}' | sort -u | xargs nmap"


DUNST_REPO=~/code/dunst
# Clone dunst into these paths to make it work
#git clone git@github.com:dunst-project/dunst.git $DUNST_REPO
# suffix the repos with .o to hide them from git, prefix with . to hide from myself
#git clone git@github.com:dunst-project/dunst-project.org.git $DUNST_REPO/.dunst-project.o
#git clone https://aur.archlinux.org/dunst-git.git $DUNST_REPO/.dunst-git.o

# Dunst specific aliases
alias dkill="pkill dunst"
alias dmake="make -j -C $DUNST_REPO"
alias drun="dkill; $DUNST_REPO/dunst -conf $DUNST_REPO/.testrc.o"
alias dgdb="dkill; gdb -ex run ${DUNST_REPO}/dunst -ex 'set confirm off' -ex bt"
alias dtest="dkill; gdb -cd ${DUNST_REPO}/test -ex run ${DUNST_REPO}/test/test -ex 'set confirm off' -ex bt"
alias dvalgrind="dkill; G_SLICE=always-malloc G_DEBUG=gc-friendly valgrind --num-callers=40 --leak-check=full --show-leak-kinds=definite --track-origins=yes ${DUNST_REPO}/dunst -startup_notification yes"
alias dhugo="(cd ${DUNST_REPO}/website && hugo server) &; xdg-open http://localhost:1313/"
alias dlog="journalctl -a --follow --since=\"\$(date '+%Y-%m-%d %H:%M' --date='last hour')\" --user -u dunst.service"
alias dmon="dbus-monitor path=/org/freedesktop/Notifications"
alias dunstify="${DUNST_REPO}/dunstify"

# build the whole history of your feature branch but stop on master
function dhistorybuild(){
	local ref="$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)"
	while ! git branch --contains 2>&1 | grep -q master; do
		git checkout HEAD~1 || return 1
		dmake clean || return 1
		dmake all dunstify test-valgrind doc-doxygen doc || return 1
		git status || return 1
	done
	git checkout "${ref}"
}

# Build the dunst package and run it directly

function dpkg(){
	set -x
	rm -rf ${DUNST_REPO}/.dunst-git.o/{dunst,pkg,src} # force a reclone and full rebuild
	rm -rf ${DUNST_REPO}/.dunst-git.o/dunst-git*.pkg.tar.xz
	set +x

	pushd ${DUNST_REPO}/.dunst-git.o
	sed -i "s%^source=.*%source=('git+file://${DUNST_REPO}#branch=${1:-master}')%" PKGBUILD
	makepkg -fi
	popd

	pkill dunst
}
