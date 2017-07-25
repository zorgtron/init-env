#!/bin/bash

function die {
    echo $*; exit 1
}

LOCAL_MOUNT="$HOME/.backup-drive"
BACKUP_COMMANDS="$HOME/.backup-commands.sh"
STARTED_DATE=$(date)

[[ -x "$BACKUP_COMMANDS" ]] || die "Could not find $BACKUP_COMMANDS"
    
echo "Mounting backup volume..."
./backup-unmount.sh || die
./backup-mount.sh || die
[[ -d "$LOCAL_MOUNT" ]] || die "Could find $LOCAL_MOUNT"

(
    cd "$LOCAL_MOUNT"
    echo "Started backing up at $STARTED_DATE" > backup.log
    "$BACKUP_COMMANDS" >> backup.log 2>&1
)

if [[ "$?" != 0 ]]; then
    echo "ERROR: Backup failed!"
    head -n10 "$LOCAL_MOUNT/backup.log"
    echo "..."
    tail -n10 "$LOCAL_MOUNT/backup.log"
fi

#./backup-unmount.sh || echo "WARNING: Could not unmount $LOCAL_MOUNT! Please check into this!"
echo "Finished backing up at $(date)."

