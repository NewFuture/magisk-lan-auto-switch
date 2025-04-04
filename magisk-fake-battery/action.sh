#!/system/bin/sh

log -t Magisk "[fake-battery] check battery level"

# Get the current fake battery level
current_level=$(dumpsys battery | grep "level:" | awk '{print $2}')

if [ "$current_level" -eq 100 ]; then
    log -t Magisk "[fake-battery] Resetting battery status..."
    dumpsys battery reset
    log -t Magisk "[fake-battery] Battery status reset."
else
    log -t Magisk "[fake-battery] $current_level. Reapplying fake battery settings..."
    . $MODPATH/service.sh
fi