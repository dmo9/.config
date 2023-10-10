#!/bin/bash

# install all the main packages 
pacman -S --needed - < pkglist.txt

# install all the aur packages using yay
# Alternatively to yay, aurutils could be used and a local repo created.
# Then, install the packages with pacman.
yay -S --needed - < pkglist.txt