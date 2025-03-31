#!/system/bin/sh

ui_print "[LAS] lan-auto-switch script started:"

# Delay execution
sleep 1

# Check if eth0 is connected
ETH0_CONNECTED=$(cat /sys/class/net/eth0/carrier 2>/dev/null)

if [ "$ETH0_CONNECTED" = "1" ]; then
    # eth0 is connected, turn off WiFi
    ui_print "[LAS] eth0 is connected. Disabling WiFi."
    svc wifi disable
else
    # eth0 is not connected, turn on WiFi
    ui_print "[LAS] eth0 is not connected. Enabling WiFi."
    svc wifi enable
fi

ui_print "[LAS] Script finished!"
