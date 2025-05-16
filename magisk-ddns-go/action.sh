#!/system/bin/sh

LOG_FILE="$TMPDIR/ddns-go.log"
PID_FILE="$TMPDIR/ddns-go.pid"


if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    echo "kill $PID"
    pkill -P $PID
    echo "ddns-go is stopped (PID: $PID)"
else
    echo "ddns-go is not running"
    echo "Starting ddns-go..."
    ddns >> "$LOG_FILE" 2>&1 &
    echo $! > "$PID_FILE"
    echo "ddns-go started (PID: $!)"
fi
