#!/system/bin/sh
# This script runs at boot to start ADB.

# Enable ADB
# setprop persist.adb.tcp.port 5555

log -t Magisk "[auto-adb] check port configuration"


# Check if persist.adb.tcp.port is configured
adb_port=$(getprop persist.adb.tcp.port)

if [ -z "$adb_port" ]; then
    log -t Magisk "persist.adb.tcp.port is not configured. Setting it to 5555..."
    adb_port="5555"
else
    log -t Magisk "[auto-adb] persist.adb.tcp.port is already configured as $adb_port"
fi

# Apply the ADB port configuration
setprop service.adb.tcp.port ${adb_port}
# Restart ADB to apply changes
stop adbd
start adbd

log -t Magisk "[auto-adb] ADB started on port ${adb_port}"