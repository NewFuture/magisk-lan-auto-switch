#!/system/bin/sh

CONFIG_PATH="/sdcard/.rclone/rclone.config"

if [ -f "$CONFIG_PATH" ]; then
    echo "Load user configuration(用户配置文件): $CONFIG_PATH"
else
    CONFIG_PATH="${MODPATH:-/data/adb/modules/rclone}/rclone.config"
    echo "Load module configuration(模块配置文件): $CONFIG_PATH"
fi

 rclone config --config "$CONFIG_PATH"