#!/bin/bash

BACKUP_COMMANDS="$HOME/.backup-commands.sh"
BIN_DIR=$(dirname $0)

read -p "Enter your backup drive host: "        HOST
read -p "Enter your backup drive share: "       SHARE
read -p "Enter your backup drive username: "    USERNAME
read -p "Enter your backup drive password: " -s PASSWORD

MASKED_PASSWORD=$(echo $PASSWORD | sed "s/./*/g")

echo; read -p "Backup to afp://$USERNAME:$MASKED_PASSWORD@$HOST/$SHARE? (Y/n): " CONFIRM
[[ "$CONFIRM" == "" ]] && CONFIRM="Y"
CONFIRM=$(echo $CONFIRM | tr "a-z" "A-Z")
if [[ "$CONFIRM" != "Y" ]]; then
    echo "Aborting backup init."
    exit 1
fi

security add-generic-password -a $USER -s backup-host     -w "$HOST"
security add-generic-password -a $USER -s backup-share    -w "$SHARE"
security add-generic-password -a $USER -s backup-username -w "$USERNAME"
security add-generic-password -a $USER -s backup-password -w "$PASSWORD"

cp $BIN_DIR/backup-commands.default.sh "$BACKUP_COMMANDS"
chmod u+x "$BACKUP_COMMANDS"

echo; echo ">>>> PLEASE READ THIS! <<<<"
echo "The file '.backup-commands.sh' has been created in your home directory."
echo "Please review it to be sure it covers everything you want to back up."
read -p "(press enter to continue)"

