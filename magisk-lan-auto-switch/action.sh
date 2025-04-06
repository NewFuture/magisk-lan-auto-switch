#!/system/bin/sh

ui_print "[lan-auto-swith] script started:"

# Check if eth0 is connected
ETH0_CONNECTED=$(cat /sys/class/net/eth0/carrier 2>/dev/null)

ui_print "[lan-auto-swith] eth0/carrier=${ETH0_CONNECTED}"

if [ "$ETH0_CONNECTED" = "1" ]; then
    ui_print "[lan-auto-swith] eth0 is connected. Disabling WiFi."
    svc wifi disable
    settings put global wifi_on 0
    settings put global wifi_scan_always_enabled 0
    cmd -w wifi set-wifi-enabled disabled 
else
    ui_print "[lan-auto-swith] eth0 is not connected. Enabling WiFi."
    svc wifi enable
    settings put global wifi_on 1
    settings put global wifi_scan_always_enabled 1
    cmd -w wifi set-wifi-enabled enabled 
fi

ui_print "[lan-auto-swith] done!"
