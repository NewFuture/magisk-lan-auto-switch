#!/system/bin/sh

MODPATH=${0%/*}

log -t Magisk "[lan-auto-swith] script started:"

while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 2
done

# Delay execution
sleep 1

. $MODPATH/action.sh

log -t Magisk "[lan-auto-swith] script finished!"
