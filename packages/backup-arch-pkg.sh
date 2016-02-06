#! /bin/bash
yaourt -Q | grep local/ | cut -d '/' -f 2 | cut -d ' ' -f 1 > yaourt_list.txt
sudo pacman -Qeq | grep -v "$(cat yaourt_list.txt)" > pacman_list.txt
