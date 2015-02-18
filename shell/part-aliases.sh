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

alias quit="exit"

alias vim="vim -p"
alias vi="vim -p"

alias fuck="sudo !!"

# open any file wihtout the knowledge of what type it is
alias of="xdg-open"

if [ ! -z "$(type sudo 2>/dev/null)" ]; then
	#create sudo aliases WITHOUT leading s
	for sudo in wifi-menu netctl mount umount pacman shutdown reboot;
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

alias pwedit="vim -p /etc/{passwd,group,shadow,gshadow}"
alias pitime='time echo "scale=1000; 4*a(1)" | bc -l > /dev/null'
alias cmdlist='find $(echo $PATH | tr ":" "\n")'
alias makepasswd='makepasswd --minchars=10 --maxchars=25 --count=10'
alias snet='ip addr | \grep -v "inet6" | \grep inet | cut -d " " -f 6 | \grep -v 127.0.0.1/8 | xargs nmap -sP'
