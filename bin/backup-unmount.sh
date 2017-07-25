#!/bin/bash

function die {
    echo $*; exit 1
}
LOCAL_MOUNT="$HOME/.backup-drive"

if mount | grep -q "$LOCAL_MOUNT"; then
    umount "$LOCAL_MOUNT" || die "Could not unmount $LOCAL_MOUNT"
fi
[[ -e "$LOCAL_MOUNT" ]] && rm -r "$LOCAL_MOUNT"

exit 0
