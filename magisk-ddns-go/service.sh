#!/system/bin/sh

L() {
    log -t Magisk "[ddns-go] $@"
}

L "script started"

export DDNS_PID_FILE=/data/log/ddns-go.pid

rm -f "$DDNS_PID_FILE"

until [ "$(getprop init.svc.bootanim)" = "stopped" ]; do 
  sleep 10;
done
sleep 30

ddns

L "script finished"
