#!/system/bin/sh

# Delay execution by 3 seconds
sleep 3

# Check if eth0 is connected
ETH0_CONNECTED=$(cat /sys/class/net/eth0/carrier 2>/dev/null)

if [ "$ETH0_CONNECTED" = "1" ]; then
    # eth0 is connected, turn off WiFi
    svc wifi disable
else
    # eth0 is not connected, turn on WiFi
    svc wifi enable
fi
