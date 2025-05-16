#!/system/bin/sh
set -a && . "${MODPATH:-/data/adb/modules/ddns-go}/env" && set +a


if [ -f "$DDNS_PID_FILE" ]; then
    echo "dns is running"
    PID=$(cat "$DDNS_PID_FILE")
    echo "kill $PID"
    pkill -P $PID & echo "ddns-go is stopped (PID: $PID)"
    rm -f "$DDNS_PID_FILE"
    rm -f "$DDNS_LOG_FILE"
else
    echo "Starting ddns-go..."
    ddns-go -dns 223.5.5.5 >> "$DDNS_LOG_FILE" 2>&1 &
    echo $! > "$DDNS_PID_FILE"
    echo "ddns-go started (PID: $!)"
fi
