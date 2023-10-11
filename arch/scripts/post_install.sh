#!/bin/bash
# yay is an AUR helper that kinda makes it easier to sync (aka install) packages from Arch user
# repository (AUR)

# install yay
# Alternatively to yay, aurutils could be used and a local repo created.
# Then, install the packages with pacman. 
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay 
makepkg -si
rm -rf yay

# copy the configuration repo to the new system
rm -rf ~/.config
cd ~
git clone https://github.com/dmo9/.config


# install all the main packages 
# install all the aur packages using yay
cd ~/.config/arch
pacman -S --needed - < pkglist.txt
yay -S --needed - < pkglist_aur.txt


# set fish as the default shell
chsh -s /usr/bin/fish

# add github user credentials 
echo -n Enter git email:
read -s email
git config --global user.email $email
git config --global user.name "David O'Brien"