#!/bin/bash
# After chrooting into the fresh arch installation, run this script. 

function setUpBootloader(){
    grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=$bootloaderId
    grub-mkconfig -o /boot/grub/grub.cfg
}

function installYay(){
    echo Installing yay, the aur helper package...
    echo _________________________________________
    cd /tmp
    pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    chown -R dob /tmp/yay
    cd yay 
    runuser dob -c "makepkg -si"
    rm -rf /tmp/yay
}

function installFreeRTOS(){
    # install freeRTOS kernel
    cd /opt
    git clone -b smp https://github.com/FreeRTOS/FreeRTOS-Kernel --recurse-submodules
    chown -R dob:dob /opt/FreeRTOS-Kernel
}

function installPicoProbe(){
    cd /opt 
    git clone https://github.com/raspberrypi/picoprobe

    cd picoprobe
    git submodule update --init
    mkdir build
    cd build
    runuser dob -c "cmake .."  # must be run as dob or env's won't be recognized
    make -j4
    chown -R dob:dob /opt/picoprobe


}

function installPicoSDK(){
    # install pico sdk 
    cd /opt
    git clone https://github.com/raspberrypi/pico-sdk.git
    cd pico-sdk
    git submodule update --init
    chown -R dob:dob /opt/pico-sdk

}

function setupPicoUdevRules(){
    
    # create a symlink to udev rules so the pico devices show up with the same /dev name everytime/ i.e /dev/pico
     ln -s /homne/dob/.config/udev/99-pico.rules /etc/udev/rules.d/99-pico.rules

}

function installPicoOpenOCD(){
    # install openocd
    cd /opt
    git clone https://github.com/raspberrypi/openocd.git --branch rp2040 --depth=1
    cd openocd
    ./bootstrap
    ./configure
    make -j4
    make install 
    chown -R dob:dob /opt/openocd
 

}

function installPicotool(){
    cd /opt
    git clone https://github.com/raspberrypi/picotool.git
    cd picotool
    mkdir build
    sleep 0.1
    cd build
    runuser dob -c "cmake .."
    make
    chown -R dob:dob /opt/picotool

    
    # so it doesnt have to be run as sudo 
    cp /opt/picotool/udev/99-picotool.rules /etc/udev/rules.d/

}

function rmExtraneousFolders(){
    # remove extra, unnecessary folders
    rm -rf ~/Documents
    rm -rf ~/Music
    rm -rf ~/Pictures
    rm -rf ~/Public
    rm -rf ~/Templates
    rm -rf ~/Videos

}

function installPacmanPackagesFromList(){
    pacman -S --needed - < /home/dob/.config/pkglist.txt
}

function installAURs(){
    path="/home/dob/.config/arch/pkglist_aur.txt"
    sudo -u dob yay -S --noconfirm - < $path
    rm /home/dob/CHITUBOX_V1.9.5.tar.gz
}

function enableStartupServices(){

    systemctl enable gdm.service   # enable gnome at startup
    systemctl enable telnet.socket # to connect to tcp server for pico
    systemctl enable cups.service  # for printing
    systemctl enable NetworkManager.service # for wifi

}

function setDefaultShellToFish(){
    # set fish as the default shell
    echo Setting fish as the default shell...
    chsh -s /usr/bin/fish
}

function setUpGit(){
    # add github user credentials 
    echo Setting up git on this machine...
    echo Enter git email:
    read email
    git config --global user.email $email
    git config --global user.name "David O'Brien"
}

function chownClion(){
    chown -R dob:dob /opt/clion
}

if [ $EUID != 0 ]
then
    echo "ERROR: must be run as root"
    exit
else 
    setUpBootloader
    installYay
    installPicoSDK
    installPicoProbe
    installPicoOpenOCD
    installPicotool
    installFreeRTOS
    chownClion
    rmExtraneousFolders
    installAURs
    installPacmanPackagesFromList
    enableStartupServices
    setDefaultShellToFish
fi 