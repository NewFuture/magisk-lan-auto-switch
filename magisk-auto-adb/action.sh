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

# Apply the ADB port configuration
setprop service.adb.tcp.port ${adb_port}
# Restart ADB to apply changes
stop adbd
start adbd

L "ADB started on port ${adb_port}"
