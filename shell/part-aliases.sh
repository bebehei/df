#!/bin/sh

#alias definitions
alias cd..="cd .."

# Steam locomotive on acid!
alias LS='sl -F'
alias ls-l='sl -l'

alias quit="exit"
alias :q="exit"
alias :qa="exit"
alias :q!="exit"
alias :qw="exit"

if [ -n "$(type nvim 2>/dev/null)" ]; then
  alias vimdiff='nvim -d'
  alias vim="nvim -p"
  alias vi="nvim -p"
else
  alias vim="vim -p"
  alias vi="vim -p"
fi


# kitty is not installed on every remote host
# As kitty sets TERM=xterm-kitty, we should indicate
# to the remote host the xterm compatibility
alias ssh='TERM=xterm-256color ssh'

# open any file wihtout the knowledge of what type it is
alias of="xdg-open"

if [ ! -z "$(type sudo 2>/dev/null)" ] && [ "$USER" != 'root' ]; then
	#create sudo aliases WITHOUT leading s
	for sudo in mount umount iftop iotop fsadm lvchange lvconvert lvcreate lvdisplay lvextend lvm lvmchange lvmconf lvmconfig lvmdiskscan lvmdump lvmetad lvmsadc lvmsar lvreduce lvremove lvrename lvresize lvs lvscan pvchange pvck pvcreate pvdisplay pvmove pvremove pvresize pvs pvscan vgcfgbackup vgcfgrestore vgchange vgck vgconvert vgcreate vgdisplay vgexport vgextend vgimport vgimportclone vgmerge vgmknodes vgreduce vgremove vgrename vgs vgscan vgsplit backup;
	do
		type "${sudo}" > /dev/null 2>&1 && alias "${sudo}"="sudo ${sudo}";
	done
	unset sudo
fi

#END alias-definitions

alias cmdlist='find $(echo $PATH | tr ":" "\n") | awk -F / "{print \$NF}" | sort -u'
