#!/bin/bash
exec 5> debug_output.txt
BASH_XTRACEFD="5"
PS4='$LINENO: '

# By A.Ibrahim
# Start ownCloud through starting the docker image into a container using docker-compose. 
# For details:
# 	https://doc.owncloud.com/server/admin_manual/installation/docker/
#
# To mount the "My Book" HDD with 6TB and exFAT formate to the docker image you need to mount it as 
# user www-data user to be able to mount it to the docekr container and get the needed access rights.
#
# You need to execute this file as root


# To mount the "My Book" HDD as user "www-data:root" you will execute the following command
# where www-data uid = 33 and root group gid = 0
#
# for more details about how to mount the HDD in this URL
# https://help.ubuntu.com/community/Mount/USB
#
# About how to get the uid and gid 
# id www-data
# results looks like: uid=33(www-data) gid=33(www-data) groups=33(www-data)
# https://askubuntu.com/questions/468236/how-can-i-find-my-user-id-uid-from-terminal
# To check if the HDD mounted or not.
# Source URL: 
# https://serverfault.com/questions/50585/whats-the-best-way-to-check-if-a-volume-is-mounted-in-a-bash-script?newreg=6e739d554ec045dfbf6523330178b8af
#
# For Debugging technique please refer to article "How to debug bash scripts with two tools"
# https://www.techrepublic.com/article/how-to-debug-bash-scripts-with-two-easy-tools/

#These functions return exit codes: 0 = found, 1 = not found

isMounted    () { findmnt -rno SOURCE,TARGET "$1" >/dev/null;} #path or device
isDevMounted () { findmnt -rno SOURCE        "$1" >/dev/null;} #device only
isPathMounted() { findmnt -rno        TARGET "$1" >/dev/null;} #path   only

#where: -r = --raw, -n = --noheadings, -o = --output

# Mount the given storage with inputs
# Parameter 1:  
mountStorage ()
{
    set -x #start debugging
    HDD_PATH=$1
    HDD_LABEL=$2
    MOUNT_FLDR=$3
    # USERNAME='www-data'
    # GROUPNAME='root'
    USERNAME=$4
    GROUPNAME=$5

    UserID=`id -u $USERNAME`
    GroupID=`id -g $GROUPNAME`

    echo "=== Mount [$HDD_LABEL] HDD as user:$USERNAME($UserID) and group:$GROUPNAME($GroupID) to mounting point [$MOUNT_FLDR] ==="

    ### Check if a directory does not exist, if not create it ###
    if [ ! -d "$MOUNT_FLDR" ]
    then 
        echo "Mount point $MOUNT_FLDR DOES NOT exists." 
        mkdir "$MOUNT_FLDR"
        chown -R $USERNAME:$GROUPNAME "$MOUNT_FLDR"
        echo "Mount point $MOUNT_FLDR created sucessfully."
    else
        echo "Mount point $MOUNT_FLDR already exist. We Will use it." 
    fi

    if isMounted "$HDD_PATH"
    then
    	echo "HDD $HDD_PATH already mounted. Will be unmounted" 
        umount "$HDD_PATH"
        echo "UnMount point $HDD_PATH sucessfully."
    else
        echo "HDD $HDD_PATH is not mounted yet."
    fi

#    mount -t exfat "$HDD_DEVICE" "$MOUNT_FLDR" -o uid=$UserID,gid=$GroupID,utf8,dmask=027,fmask=137
    mount -t exfat --label "My Book" "$MOUNT_FLDR" -o uid=$UserID,gid=$GroupID,utf8,dmask=027,fmask=137
    echo "Mount [$HDD_LABEL] HDD completed sucessfully."
    set +x # Stop debugging
}

MY_BOOK_PATH="/media/aibrahim/My Book"
MY_BOOK_LABEL="My Book"
MY_BOOK_FLDR="/media/MyBook"

MY_SPACE_PATH="/media/aibrahim/MySpace"
MY_SPACE_DEVICE="/dev/sdc1"

mountStorage "$MY_BOOK_PATH" "$MY_BOOK_LABEL" "$MY_BOOK_FLDR" "www-data" "root"



### Check if a directory does not exist ###
# if [ ! -d "$MY_BOOK_FLDR" ] 
# then
#     echo "Mount point $MY_BOOK_FLDR DOES NOT exists." 
#     mkdir "$MY_BOOK_FLDR"
#     chown -R www-data:root "$MY_BOOK_FLDR"
# else
#     echo "Mount point $MY_BOOK_FLDR already exists." 
#     if isMounted "$MY_BOOK_DEVICE"
#     then
#     	echo "HDD $MY_BOOK_PATH already mounted. Will be unmounted" 
#         umount "$MY_BOOK_DEVICE"
#     fi
# fi
# mount -t exfat "$MY_BOOK_DEVICE" "$MY_BOOK_FLDR" -o uid=33,gid=0,utf8,dmask=027,fmask=137

echo "=== Mounting MyBook HDD Completed ==="
