#!/system/bin/sh

ui_print "[fake-battery] check battery level"

# Get the current fake battery level
current_level=$(dumpsys battery | grep "level:" | awk '{print $2}')

if [ "$current_level" -eq 100 ]; then
    ui_print "[fake-battery] Resetting battery status..."
    dumpsys battery reset
    ui_print "[fake-battery] Battery status reset."
else
    ui_print "[fake-battery] $current_level. Reapplying fake battery settings..."
    . $MODPATH/service.sh
    ui_print "set done"
fi
