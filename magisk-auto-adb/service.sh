#!/system/bin/sh
# This script runs at boot to start ADB.

log -t Magisk "[auto-adb] script started:"

until [ "$(getprop sys.boot_completed)" -eq 1 ]; do
    sleep 5
done

sleep 5

. $MODPATH/action.sh