#!/bin/bash

# By A.Ibrahim
# Different ways to check if HDD is mounted.
# Source URL: 
# https://serverfault.com/questions/50585/whats-the-best-way-to-check-if-a-volume-is-mounted-in-a-bash-script?newreg=6e739d554ec045dfbf6523330178b8af

MY_BOOK_PATH="/media/aibrahim/My Book"
MY_BOOK_DEVICE="/dev/sdc1"

MY_SPACE_PATH="/media/aibrahim/MySpace"
MY_SPACE_DEVICE="/dev/sdb1"

#These functions return exit codes: 0 = found, 1 = not found

isMounted    () { findmnt -rno SOURCE,TARGET "$1" >/dev/null;} #path or device
isDevMounted () { findmnt -rno SOURCE        "$1" >/dev/null;} #device only
isPathMounted() { findmnt -rno        TARGET "$1" >/dev/null;} #path   only

#where: -r = --raw, -n = --noheadings, -o = --output


if isPathMounted "$MY_BOOK_PATH";      #Spaces in path names are ok.
   then echo "My Book path $MY_BOOK_PATH is mounted"
   else echo "My Book path $MY_BOOK_PATH is not mounted"
fi

if isDevMounted "$MY_BOOK_DEVICE"; 
   then echo "My Book device $MY_BOOK_DEVICE is mounted"
   else echo "My Book device $MY_BOOK_DEVICE is not mounted"
fi

#Universal:
if isMounted "$MY_SPACE_PATH"; 
   then echo "MySpace path $MY_SPACE_PATH is mounted"
   else echo "MySpace path $MY_SPACE_PATH is not mounted"
fi

if isMounted "$MY_SPACE_DEVICE";
   then echo "MySpace device $MY_SPACE_DEVICE is mounted"
   else echo "MySpace device $MY_SPACE_DEVICE is not mounted"
fi
