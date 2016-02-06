#!/bin/sh
#alias definitions
alias chmox="chmod +x"
alias cd..="cd .."
alias gits="git status"
alias subl='subl3'
alias ddd="killall -USR1 dd"
alias sddd="sudo killall -USR1 dd"

alias killlall="killall"
alias kilall="killall"
alias kilal="killall"
alias killlal="killall"

alias les="less"

alias quit="exit"

alias vim="vim -p"
alias vi="vim -p"

alias cp='cp -v'
alias mv='mv -v'

alias youtube-dl='youtube-dl -o "%(title)s.%(ext)s"'
alias ym3='youtube-dl -o "%(title)s.%(ext)s" --extract-audio --audio-format mp3'

alias grep="grep --color=auto"
alias ls='ls --color=auto'

alias fuck="sudo !!"
alias fu='sudo "$BASH" -c "$(history -p !!)"'

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
alias shuttle='sshuttle --dns -v -r smonkey@menkar.uberspace.de 0/0'
alias backupnow='sudo borgmatic && echo $(date +"%Y%m%d") > ~/.borgbackup.log'
alias notify='notify-send Terminal "Process has been finished"'
alias screen-off='xset -display :0.0 dpms force off '

# DEBIAN:
alias sag='sudo apt-get'
#alias key-renew='apt-key adv --keyserver keyserver.ubuntu.com --recv-keys'
#alias key-repair-all='wget -q http://archive.getdeb.net/getdeb-archive.key -O- | sudo apt-key add - '

# ARCH:
alias cower-update='cd /tmp && cower -vdu && cd | grep /tmp'
alias pacman-update='sudo pacman -Syu'
