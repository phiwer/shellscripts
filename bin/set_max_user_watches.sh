#!/bin/bash

# ref: https://askubuntu.com/a/30157/8698
if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

if [ $SUDO_USER ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
fi

# Commands that you don't want running as root would be invoked
# with: sudo -u $real_user
# So they will be run as the user who invoked the sudo command
# Keep in mind if the user is using a root shell (they're logged in as root),
# then $real_user is actually root
# sudo -u $real_user non-root-command

# Commands that need to be ran with root would be invoked without sudo
# root-command


# Source: https://www.ibm.com/docs/en/ahte/4.0?topic=wf-configuring-linux-many-watch-folders
MAX_USER_WATCHES=$(cat /proc/sys/fs/inotify/max_user_watches)
if [ $MAX_USER_WATCHES != 524288 ]
then
    echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf
fi

MAX_USER_INSTANCES=$(cat /proc/sys/fs/inotify/max_user_instances)
if [ $MAX_USER_INSTANCES != 1024 ]
then
    echo "fs.inotify.max_user_instances=1024" >> /etc/sysctl.conf
fi

FILE_MAX=$(cat /proc/sys/fs/file-max)
if [ $FILE_MAX != 2097152 ]
then
    echo "fs.file-max=2097152" >> /etc/sysctl.conf
fi

sysctl -p /etc/sysctl.conf
