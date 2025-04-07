#!/system/bin/sh


L() {
log -t Magisk "[lan-auto-swith] $1"
ui_print "[lan-auto-swith] $1"
}


# Check if eth0 is connected
ETH0_CONNECTED=$(cat /sys/class/net/eth0/carrier 2>/dev/null)

L "eth0/carrier=${ETH0_CONNECTED}"

if [ "$ETH0_CONNECTED" = "1" ]; then
    L "eth0 is connected. Disabling WiFi."
    svc wifi disable
    cmd -w wifi set-wifi-enabled disabled 
else
    L "eth0 is not connected. Enabling WiFi."
    svc wifi enable
    cmd -w wifi set-wifi-enabled enabled 
fi

L "done!"
