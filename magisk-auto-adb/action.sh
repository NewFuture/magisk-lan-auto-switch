#!/system/bin/sh
# This script runs to start ADB

L() {
    echo "[auto-adb] $1"
    log -t Magisk "[auto-adb] $1"
}

L "check persist.adb.tcp.port"


# Check if persist.adb.tcp.port is configured
adb_port=$(getprop persist.adb.tcp.port)

if [ -z "$adb_port" ]; then
    L "port is not configured. Setting it to 5555..."
    adb_port="5555"
else
    L "port is already configured as $adb_port"
fi

if [ "$(getprop init.svc.adbd)" = "running" ]; then
    L "ADB is running. Stop ADB."
    stop adbd
fi

# Apply the ADB port configuration
setprop service.adb.tcp.port ${adb_port}
settings put global adb_enabled 1
settings put global adb_wifi_enabled 1

# Restart ADB to apply changes
start adbd

L "ADB started on port ${adb_port}"
