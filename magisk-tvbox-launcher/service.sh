#!/system/bin/sh
# This script runs at boot to find and launch the TVBox app.

MODPATH=${0%/*}

L() {
    echo "[auto-tvbox] $1"
    log -t Magisk "[auto-tvbox] $1"
}

L "script started:"

# Wait for the system to boot completely
until [ "$(getprop sys.boot_completed)" -eq 1 ]; do
    sleep 1
done

# Delay to ensure the system is ready
sleep 3

# Find the package name containing '.tvbox.osc'
PACKAGE_NAME=$(pm list packages | grep '\.tvbox\.osc' | cut -d':' -f2)

if [ -n "$PACKAGE_NAME" ]; then
    L "Found TVBox app: $PACKAGE_NAME"
    monkey -p "$PACKAGE_NAME" -c android.intent.category.LAUNCHER 1
    L "TVBox app launched successfully!"
else
    L "No TVBox app found (with package name containing '.tvbox.osc')."
fi

L "script finished!"