#!/system/bin/sh

log -t Magisk "[lan-auto-swith] script started:"

while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 2
done

# Delay execution
sleep 5

. $MODPATH/service.sh

# cmd wifi force-country-code enabled US
log -t Magisk "[lan-auto-swith] script finished!"
