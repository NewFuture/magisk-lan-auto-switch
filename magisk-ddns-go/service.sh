#!/system/bin/sh

L() {
    log -t Magisk "[ddns-go] $1"
}

L "script started"

until [ "$(getprop init.svc.bootanim)" = "stopped" ]; do 
  sleep 10;
done
sleep 30

LOG_FILE="${TMPDIR:-/data/local/tmp}/ddns-go.log"
PID_FILE="${TMPDIR:-/data/local/tmp}/ddns-go.pid"
rm -f "$LOG_FILE"
rm -f "$PID_FILE"

L "run ddns ..."
ddns >> "$LOG_FILE" 2>&1 &
echo $! > "$PID_FILE"

L "script finished (ddns PID: $!)"
