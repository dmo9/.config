#!/bin/bash
# creates two text files: one which contains a list of all pacman installed packages on the current
# system and the other which contains all the aur packages.
#
# These lists are then used to reinstall all programs on a fresh install.
# See https://wiki.archlinux.org/title/migrate_installation_to_new_hardware#Bottom_to_top
# for more details 

pacman -Qqen > pkglist.txt
pacman -Qqem > pkglist_aur.txt





