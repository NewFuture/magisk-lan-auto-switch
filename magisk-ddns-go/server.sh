#!/system/bin/sh

L() {
    log -t Magisk "[ddns-go] $1"
}

L "Starting ddns-go..."

CONFIG_FILE="${MODPATH:-/data/adb/modules/ddns-go}/config.yaml"

until [ "$(getprop init.svc.bootanim)" = "stopped" ]; do 
  sleep 10;
done

sleep 30

# 设置日志和 PID 文件路径
LOG_FILE="$TMPDIR/ddns-go.log"
PID_FILE="$TMPDIR/ddns-go.pid"

rm -f "$LOG_FILE"
rm -f "$PID_FILE"

L "Starting ddns-go..."

ddns >> "$LOG_FILE" 2>&1 &
echo $! > "$PID_FILE"

L "script finished (PID: $!)"
