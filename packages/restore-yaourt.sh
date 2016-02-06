#! /bin/bash
for x in $(cat yaourt_list.txt); do
	sudo yaourt -S --noconfirm $x
done
