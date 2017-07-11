#!/bin/bash

# This script will automatically be invoked by the backup system from the target directory. Use whatever bash commands
# you like to backup any files needed into the current directory. The following will grab everything from your home
# directory which commonly includes data you may care about. If there are other things you want to save, be sure to
# add them in.

rsync -az --delete /Users/andrew/ ./Users/andrew \
    --exclude .DS_Store \
    --exclude .Trash \
    --exclude .dropbox \
    --exclude Dropbox \
    --exclude Library \
        --include Library/Application\ Support

