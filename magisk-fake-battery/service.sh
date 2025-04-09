#!/system/bin/sh
# wait boot complete and battery service ready

log -t Magisk "[fake-battery] Start"

dumpsys battery set level 100
dumpsys battery set status 5
dumpsys battery set temp 25
dumpsys battery set ac 1
dumpsys battery set present 0

log -t Magisk "[fake-battery] Fake battery done"
