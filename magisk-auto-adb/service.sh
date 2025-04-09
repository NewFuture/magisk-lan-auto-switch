#!/system/bin/sh
# This script runs at boot to start ADB.

MODPATH=${0%/*}

log -t Magisk "[auto-adb] script started:"

until [ "$(getprop sys.boot_completed)" -eq 1 ]; do
    sleep 1
done

sleep 2
. $MODPATH/action.sh

log -t Magisk "[auto-adb] script finished!"
