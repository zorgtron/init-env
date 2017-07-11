#!/bin/bash

function die {
    echo $*; exit 1
}
LOCAL_MOUNT="$HOME/.backup-drive"

HOST=$(security find-generic-password -a $USER -s backup-host -w)
SHARE=$(security find-generic-password -a $USER -s backup-share -w)
USERNAME=$(security find-generic-password -a $USER -s backup-username -w)
PASSWORD=$(security find-generic-password -a $USER -s backup-password -w)
DRIVE="afp://$USERNAME:$PASSWORD@$HOST/$SHARE"

if ! mount | grep -q "$HOME/$LOCAL_MOUNT"; then
    if [[ -e "$LOCAL_MOUNT" ]]; then
        rm -rf "$LOCAL_MOUNT" || die "Could not mount to $LOCAL_MOUNT"
    fi
    mkdir -p "$LOCAL_MOUNT"
    mount -t afp "$DRIVE" "$LOCAL_MOUNT" || die "Could not mount from $DRIVE"
fi

