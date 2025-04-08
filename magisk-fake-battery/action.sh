#!/system/bin/sh

MODPATH=${0%/*}

L() {
    echo "[fake-battery] $1"
    log -t Magisk "[fake-battery] $1"
}

L "Check battery level"
# Get the current fake battery level
current_level=$(dumpsys battery | grep "level:" | awk '{print $2}')

if [ "$current_level" -eq 100 ]; then
    L "Resetting battery status..."
    dumpsys battery reset
    L "Battery status reset."
else
    L "$current_level. Reapplying fake battery settings..."
    . $MODPATH/service.sh
    L "Done!"
fi
