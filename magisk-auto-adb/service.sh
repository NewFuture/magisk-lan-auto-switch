#!/system/bin/sh
# This script runs at boot to start ADB.

MODPATH=${0%/*}

log -t Magisk "[auto-adb] Start:"

sleep 20
. $MODPATH/action.sh

log -t Magisk "[auto-adb] Done!"
