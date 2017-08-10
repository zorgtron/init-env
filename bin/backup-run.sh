#!/bin/bash

function die {
    echo $*; exit 1
}

LOCAL_MOUNT="$HOME/.backup-drive"
BACKUP_COMMANDS="$HOME/.backup-commands.sh"
STARTED_DATE=$(date)
BIN=$(dirname $0)

[[ -x "$BACKUP_COMMANDS" ]] || die "Could not find $BACKUP_COMMANDS"

echo "[$(date)] Mounting backup volume..."
$BIN/backup-mount.sh || die
[[ -d "$LOCAL_MOUNT" ]] || die "Could find $LOCAL_MOUNT"

(
    cd "$LOCAL_MOUNT"
    echo "[$(date)] Running backup..." > backup.log
    "$BACKUP_COMMANDS" >> backup.log 2>&1
)

if [[ "$?" != 0 ]]; then
    echo "[$(date)] ERROR: Backup failed!"
    head -n10 "$LOCAL_MOUNT/backup.log"
    echo "..."
    tail -n10 "$LOCAL_MOUNT/backup.log"
fi

$BIN/backup-unmount.sh || echo "[$(date)] WARNING: Could not unmount $LOCAL_MOUNT! Please check into this!"
echo "[$(date)] Finished backing up"

