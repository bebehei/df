#!/bin/sh
#alias definitions
alias chmox="chmod +x"
alias cd..="cd .."
alias ddd="killall -USR1 dd"
alias sddd="sudo killall -USR1 dd"

alias killlall="killall"
alias kilall="killall"
alias kilal="killall"
alias killlal="killall"

# Steam locomotive on acid!
alias LS='sl -F'
alias ls-l='sl -l'

alias quit="exit"
alias :q="exit"

alias vim="vim -p"
alias vi="vim -p"

alias fuck="sudo !!"

# open any file wihtout the knowledge of what type it is
alias of="xdg-open"

if [ ! -z "$(type sudo 2>/dev/null)" -a "$USER" != 'root' ]; then
	#create sudo aliases WITHOUT leading s
	for sudo in wifi-menu netctl mount umount pacman shutdown reboot iftop fsadm lvchange lvconvert lvcreate lvdisplay lvextend lvm lvmchange lvmconf lvmconfig lvmdiskscan lvmdump lvmetad lvmsadc lvmsar lvreduce lvremove lvrename lvresize lvs lvscan pvchange pvck pvcreate pvdisplay pvmove pvremove pvresize pvs pvscan vgcfgbackup vgcfgrestore vgchange vgck vgconvert vgcreate vgdisplay vgexport vgextend vgimport vgimportclone vgmerge vgmknodes vgreduce vgremove vgrename vgs vgscan vgsplit;
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
fi

#END alias-definitions

alias pwedit="svim -p /etc/{passwd,group,shadow,gshadow}"
alias cmdlist='find $(echo $PATH | tr ":" "\n")'
alias makepasswd='makepasswd --minchars=10 --maxchars=25 --count=10'

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
