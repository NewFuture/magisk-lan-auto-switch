#!/system/bin/sh
set -a && . "${MODPATH:-/data/adb/modules/ddns-go}/env" && set +a

if [ -f "$DDNS_PID_FILE" ]; then
    echo "dns is running"
    PID=$(cat "$DDNS_PID_FILE")
    echo "kill $PID"
    pkill -P $PID & echo "ddns-go is stopped (PID: $PID)"
    rm -f "$DDNS_PID_FILE"
else
    DDNS_GO_ARGS=("-dns" "$DDNS_DNS")
    if [ -n "$DDNS_IP_CACHE_TIMES" ] ; then
        DDNS_GO_ARGS+=("-cacheTimes" "$DDNS_IP_CACHE_TIMES")
    fi
    if [ -n "$DDNS_FREQUENCY" ] ; then
        DDNS_GO_ARGS+=("-f" "$DDNS_FREQUENCY")
    fi
    echo "Starting ddns-go ${DDNS_GO_ARGS[@]}"

    ddns-go "${DDNS_GO_ARGS[@]}" > "$DDNS_LOG_FILE" 2>&1 &
    echo $! > "$DDNS_PID_FILE"
    echo "ddns-go started (PID: $!)"
fi
