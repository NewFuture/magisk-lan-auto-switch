#!/system/bin/sh
# This script runs at boot to ensure rclone mounts are established.

MODPATH=${0%/*}

log -t Magisk "[rclone] service script started:"

# Wait for the system to boot completely
until [ "$(getprop sys.boot_completed)" -eq 1 ]; do
    sleep 2
done

sleep 1

# Call action.sh to manage rclone mounts
. $MODPATH/action.sh

log -t Magisk "[rclone] service script finished!"