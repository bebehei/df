#! /bin/bash
for x in $(cat pacman_list.txt); do
	sudo pacman -S $x
	if [ $? -ne 0 ] ; then
		yaourt -S --noconfirm $x
	fi
done
