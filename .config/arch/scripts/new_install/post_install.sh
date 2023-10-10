#!/bin/bash
# yay is an AUR helper that kinda makes it easier to sync (aka install) packages from Arch user
# repository (AUR)

# install yay
# Alternatively to yay, aurutils could be used and a local repo created.
# Then, install the packages with pacman. 
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay 
makepkg -si
rm -rf yay


# install all the main packages 
# install all the aur packages using yay
cd ../migration
cd /mnt/linux_config/.config/arch
pacman -S --needed - < pkglist.txt
yay -S --needed - < pkglist_aur.txt

# copy the configuration repo to the new system
cp /mnt/linux_config ~/linux_config

