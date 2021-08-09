#!/bin/bash

mount_point=$(lsblk | grep sd |sed -n '2 p' | awk -F" " {'print $7'})
backup_dir="$mount_point/sz96-backup"
backup_list="$HOME/Documents $HOME/Downloads $HOME/Pictures $HOME/Videos $HOME/.config $HOME/Audio $HOME/org"

if [[ -z "$mount_point" ]]
then
    read -sr -n 1 -p "Do you want to mount your backup device(Y/n)" ans
    printf "\n"
    case "$ans" in
	y|Y )
	    device=$(lsblk | grep part | grep sd | awk {'print $1'} | awk -F"└─" {'print $2'})
	    sudo mount "/dev/$device" ~/media/
	    mount_point=$(lsblk | grep sd |sed -n '2 p' | awk -F" " {'print $7'})
	    backup_dir="$mount_point/sz96-backup";;
	* )
	    echo "No available backup device. Exit program." && exit 0;;
    esac
fi

rsync -auvzP $backup_list $backup_dir

read -sr -n 1 -p "Do you want to umount the backup device?(Y/n)" choice
printf "\n"

case "$choice" in
    n|N ) echo "backup finished";;
    * ) sudo umount "$mount_point" && echo "backup finished";;
esac
