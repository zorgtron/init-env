#!/bin/bash -x

function die {
    echo $*; exit 1
}
LOCAL_MOUNT="$HOME/.backup-drive"

DRIVE=$(cat ~/.backup-cred)

[[ "$DRIVE" == "" ]] && die "[$(date)] Could not find ~/.backup-cred"

if ! mount | grep -q "$LOCAL_MOUNT"; then
    if [[ -e "$LOCAL_MOUNT" ]]; then
        rmdir "$LOCAL_MOUNT" >/dev/null &2>1 || die "[$(date)] Could not mount to $LOCAL_MOUNT"
    fi
    mkdir -p "$LOCAL_MOUNT"
    mount -t afp "$DRIVE" "$LOCAL_MOUNT" || die "[$(date)] Could not mount backup drive"
fi

