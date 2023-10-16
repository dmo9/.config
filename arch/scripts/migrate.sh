#!/bin/bash
# creates two text files: one which contains a list of all pacman installed packages on the current
# system and the other which contains all the aur packages.
#
# These lists are then used to reinstall all programs on a fresh install.
# See https://wiki.archlinux.org/title/migrate_installation_to_new_hardware#Bottom_to_top
# for more details 

# create the lists
pacman -Qqen > ~/.config/arch/pkglist.txt
pacman -Qqem > ~/.config/arch/pkglist_aur.txt

# push everything to git 
cd ~/.config
git add --all
git commit -m "yeet"
git push 





