#!/bin/bash
# this script has been designed to run before archinstall in order to
# to set everthing up for installing arch linux.





function mountDisks()
{
    mkdir /mnt/boot 
    mkdir -p $backupDiskMntPoint

    mount $BACKUP_DISK_ROOT_PART $backupDiskMntPoint
    mount $PRIMARY_DISK_BOOT_PART /mnt/boot 
    mount $PRIMARY_DISK_ROOT_PART /mnt
}

function unmountPrimaryDisk()
{
    umount $PRIMARY_DISK_BOOT_PART
    umount $PRIMARY_DISK_ROOT_PART
}

function partitionPrimaryDisk()
{
    parted -a optimal $PRIMARY_DISK_BOOT_PART mkpart "EFI system partition" fat32 0% $bootPartitionSize set 1 esp on
    parted -a optimal $PRIMARY_DISK_ROOT_PART mkpart "root partition" ext4 $bootPartitionSize 100% set 2 root on
}

function connectToWifi(){
    nmtui
}


function formatPrimaryDisk()
{
    unmountDisks
    mkfs.ext4 $PRIMARY_DISK_ROOT_PART
    mkfs.fat -F 32 $PRIMARY_DISK_BOOT_PART
}

function installEssentialPackages(){
    pacstrap -K /mnt $essentialPackages
}

function genfstab()
{
    genfstab -U /mnt >> /mnt/etc/fstab
}



help()
{
   # Display Help
   echo "Usage: commandName [OPTIONS]"
   echo "This script is used to install arch linux."
   echo
   echo "OPTIONS"
   echo "   -m     mounts the primary and backup drives"
   echo "   -h     displays this help message"
   echo "   -u     unmounts the primary disk"
   echo "   -w     setup wifi via nmtui"
   echo "   -c     wipes the primary disk & does a clean install. Be careful!"
   echo "   -r     copies files from the backup disk to the primary disk"
   echo "   -l     list the paths of the primary & backup disks"
}

# https://www.redhat.com/sysadmin/arguments-options-bash-scripts


if [ $EUID != 0 ]
then
    echo "ERROR: must be root"
else

    # set disk envs
    # set -gx 
    backupDiskMntPoint=/mnt/media/backup
    bootPartitionSize="500 MiB"
    essentialPackages="base linux linux-firmware fish efibootmgr grub sudo archlinux-keyring networkmanager"
    bootloaderId="DOB_OS"
    BACKUP_DISK_ROOT_PART="/dev/disk/by-id/ata-WDC_WD5000LPCX-24C6HT0_WD-WX31A2510N4Y-part1"
    PRIMARY_DISK_BOOT_PART="/dev/disk/by-id/nvme-CT500P3PSSD8_2244E680491F-part1"
    PRIMARY_DISK_ROOT_PART="/dev/disk/by-id/nvme-CT500P3PSSD8_2244E680491F-part2"

    while getopts ":hmuwcrl" option; do
        case $option in
            h) # display Help
                help
                exit;;

            m) # mount the drives
                mountDisks
                exit;;

            u) #unmount the primary disk 
                unmountPrimaryDisk;;

            w) # connect to wifi 
                connectToWifi
                exit;;

            c) # perform a clean install 
                while true; do
                    read -p "You've selected to do a clean install on the primary disk; this will erase all its contents. Proceed? [Y/N] " yn
                    case $yn in
                        [Yy]*) 
                            pacman -Syu
                            partitionPrimaryDisk
                            formatPrimaryDisk
                            installEssentialPackages
                            genfstab
                            exit;;
                        [Nn]* ) 
                            exit;;
                        * )
                            echo "Please answer yes or no.";;
                    esac
                done;;

            l)
                echo "Primary disk boot partition: $PRIMARY_DISK_BOOT_PART"
                echo "Primary disk root partition: $PRIMARY_DISK_ROOT_PART"
                echo "Backup disk root partition: $BACKUP_DISK_ROOT_PART"
                exit;;

            r) #restore from backup
                ECHO "RESTORE FROM BACKUP";;
            
            
            \?) # Invalid option
                echo "Error: Invalid option"
                exit;;

        esac
    done    
fi

