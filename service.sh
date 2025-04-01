#!/system/bin/sh

log -t Magisk "[lan-auto-swith] script started:"

# Delay execution
sleep 10

# Check if eth0 is connected
ETH0_CONNECTED=$(cat /sys/class/net/eth0/carrier 2>/dev/null)

if [ "$ETH0_CONNECTED" = "1" ]; then
    log -t Magisk "[lan-auto-swith] eth0 is connected. Disabling WiFi."
    svc wifi disable
else
    log -t Magisk "[lan-auto-swith] eth0 is not connected. Enabling WiFi."
    svc wifi enable
fi

log -t Magisk "[lan-auto-swith] Script finished!"
