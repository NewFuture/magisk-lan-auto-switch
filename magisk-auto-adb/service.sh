#!/system/bin/sh
# This script runs at boot to start ADB.

MODPATH=${0%/*}

log -t Magisk "[auto-adb] script started:"

until [ "$(getprop sys.boot_completed)" -eq 1 ]; do
    sleep 1
done

sleep 2

adb_port=$(getprop persist.adb.tcp.port)
if [ -z "$adb_port" ]; then
    L "persist.adb.tcp.port is not configured."
else
    # Apply the ADB port configuration
    setprop service.adb.tcp.port ${adb_port}
else

settings put global adb_enabled 1
settings put global adb_wifi_enabled 1
    
if [ "$(getprop init.svc.adbd)" != "running" ]; then
    # Restart ADB to apply changes
    start adbd
fi

log -t Magisk "[auto-adb] script finished!"
