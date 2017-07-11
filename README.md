This repository contains the basic setup for how I like to configure my command line.  It contains my shell setup,
editor settings, and other odds and ends.  In order to get a new machine up and running, simply clone this repository
onto the machine and run the included `install.sh` script.  It will check for missing software and install it, and it
will install its own versions of various important configuration files (e.g., `.profile`, `.vimrc`, etc.).

### Backups

There are a number of commands in `bin` related to backing up your files to a remote drive. If you'd like to use them,
start by running `backup-init.sh`.  It will ask you for various bits of information necessary to configure your backups.
When its finished, you'll want to call `backup-run.sh` whenever you'd like to make a backup.  This command is written
with running from `cron` in mind, and may be safely run that way.
