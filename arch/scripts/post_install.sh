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


#  get the chitubox binary from their site
# the aur package needs this
wget -c 'https://sac.chitubox.com/software/download.do?softwareId=17839&softwareVersionId=v1.9.5&fileName=CHITUBOX_V1.9.5.tar.gz' -o CHITUBOX_V1.9.5.tar.gz
# install all the main packages 
# install all the aur packages using yay
d ~/.config/arch
pacman -S --needed - < pkglist.txt
yay -S --needed - < pkglist_aur.txt

# remove the chitubox file because we dont need it anymore 
rm ~/CHITUBOX_V1.9.5.tar.gz


# set fish as the default shell
chsh -s /usr/bin/fish

# add github user credentials 
echo -n Enter git email:
read -s email
git config --global user.email $email
git config --global user.name "David O'Brien"