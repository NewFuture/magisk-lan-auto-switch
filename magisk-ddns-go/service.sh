#!/system/bin/sh

L() {
    log -t Magisk "[ddns-go] $1"
}

L "script started"

set -a && . "${MODPATH:-/data/adb/modules/ddns-go}/env" && set +a

rm -f "$DDNS_PID_FILE"

until [ "$(getprop init.svc.bootanim)" = "stopped" ]; do 
  sleep 10;
done
sleep 30

DDNS_GO_ARGS=("-dns" "$DDNS_DNS")
if [ -n "$DDNS_IP_CACHE_TIMES" ] ; then
    DDNS_GO_ARGS+=("-cacheTimes" "$DDNS_IP_CACHE_TIMES")
fi
if [ -n $"DDNS_FREQUENCY"] ; then
    DDNS_GO_ARGS+=("-f" "$DDNS_FREQUENCY")
fi

L "run ddns in low priority: ${DDNS_GO_ARGS[@]}"

nice -n 18 ionice -c3 ddns-go "${DDNS_GO_ARGS[@]}" > "$DDNS_LOG_FILE" 2>&1 &

echo $! > "$DDNS_PID_FILE"

L "script finished (PID: $!)"
