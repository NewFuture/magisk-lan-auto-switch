#!/system/bin/sh

export DDNS_PID_FILE=/data/log/ddns-go.pid

if [ -f "$DDNS_PID_FILE" ]; then
    echo "dns is running"
    PID=$(cat "$DDNS_PID_FILE")
    echo "kill $PID"
    pkill -P $PID & echo "ddns-go is stopped (PID: $PID)"
    rm -f "$DDNS_PID_FILE"
else
    ddns
    echo "ddns-go started"
fi
