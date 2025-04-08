#!/system/bin/sh


L() {
    echo "[lan-auto-swith] $1"
    log -t Magisk "[lan-auto-swith] $1"
}


# Check if eth0 is connected
ETH0_CONNECTED=$(cat /sys/class/net/eth0/carrier 2>/dev/null)

L "eth0/carrier=${ETH0_CONNECTED}"

if [ "$ETH0_CONNECTED" = "1" ]; then
    L "eth0 is connected. Disabling WiFi."
    svc wifi disable
    settings put global wifi_on 0
    cmd -w wifi set-wifi-enabled disabled 
else
    L "eth0 is not connected. Enabling WiFi."
    svc wifi enable
    settings put global wifi_on 1
    cmd -w wifi set-wifi-enabled enabled 
fi

L "Done!"
