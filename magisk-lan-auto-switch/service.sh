#!/system/bin/sh

log -t Magisk "[lan-auto-swith] script started:"

while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 2
done

# Delay execution
sleep 3

# Check if eth0 is connected
ETH0_CONNECTED=$(cat /sys/class/net/eth0/carrier 2>/dev/null)

log -t Magisk "[lan-auto-swith] eth0/carrier=${ETH0_CONNECTED}"

if [ "$ETH0_CONNECTED" = "1" ]; then
    log -t Magisk "[lan-auto-swith] eth0 is connected. Disabling WiFi."
    svc wifi disable
    settings put global wifi_on 0
    settings put global wifi_scan_always_enabled 0
    #cmd -w wifi set-wifi-enabled disabled 
else
    log -t Magisk "[lan-auto-swith] eth0 is not connected. Enabling WiFi."
    svc wifi enable
    settings put global wifi_on 1
    settings put global wifi_scan_always_enabled 1
    #cmd -w wifi set-wifi-enabled enabled 
fi

# cmd wifi force-country-code enabled US
log -t Magisk "[lan-auto-swith] script finished!"
