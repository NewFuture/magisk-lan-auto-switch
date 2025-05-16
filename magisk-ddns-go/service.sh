#!/system/bin/sh

L() {
    log -t Magisk "[ddns-go] $1"
}

L "script started"

set -a && . "${MODPATH:-/data/adb/modules/ddns-go}/env" && set +a

rm -f "$DDNS_LOG_FILE"
rm -f "$DDNS_PID_FILE"

until [ "$(getprop init.svc.bootanim)" = "stopped" ]; do 
  sleep 10;
done
sleep 30

L "run ddns ..."
ddns-go -dns 223.5.5.5 >> "$DDNS_LOG_FILE" 2>&1 &
echo $! > "$DDNS_PID_FILE"

L "script finished (ddns PID: $!)"
