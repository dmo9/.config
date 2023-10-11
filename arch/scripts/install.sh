#!/bin/bash
# this script has been designed to run before archinstall in order to
# to setup the wifi. Archinstall won't run without an internet connection.
# Then, the script loads the latest configuration file 


# do some magic to get the adapter working 
echo Setting up the wifi adapter...
modprobe -r b44 b43 b43legacy ssb brcmsmac bcma wl
modprobe wl
systemctl restart iwd

# fill in the SSID information
echo Enter SSID:
read ssid
echo -n Enter wifi password:
read -s password
echo
iwctl --passphrase $password station wlan0 connect $ssid
sleep 3

# get the latest version of our linux configuration repo which contains all other scripts 
# & configuration files which should be copied to the new ~/.config folder   
cd /mnt
git clone https://github.com/dmo9/linux_config


# start the arch install with the latest configuration file 
cd /mnt/linux_config/.config/arch
archinstall --config user_configuration.json
