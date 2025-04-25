#!/system/bin/sh

MODPATH=${0%/*}

L() {
    echo "[rclone] $1"
    log -t Magisk "[rclone] $1"
}

CONFIG_PATH="/sdcard/.rclone/rclone.config"

if [ -f "$CONFIG_PATH" ]; then
    L "Load user configuration(用户配置文件): $CONFIG_PATH"
else
    CONFIG_PATH="${MODPATH}/rclone.config"
    L "Load module configuration(模块配置文件): $CONFIG_PATH"
fi

MODULE_PROP="${MODPATH}/module.prop"


run_unmount() {
    L "rclone 正在运行，正在卸载所有挂载..."
    mount | grep "rclone" | awk '{print $3}' | while read -r mountpoint; do
        umount -l "$mountpoint"
    done
    L "所有挂载已卸载。"
    sed -i 's/^description=\(.\{1,4\}| \)\?/description=⏹️| /' "$MODULE_PROP"
}

mount_from_to(){

  REMOTE=$1
  MOUNT_POINT=$2
  rclone mount "$REMOTE" "$MOUNT_POINT" \
    --config "$CONFIG_PATH" \
    --daemon \
    --allow-other \
    --buffer-size=32M \
    --dir-cache-time=24h \
    --vfs-cache-max-age=12h \
    --vfs-cache-max-size=1024M \
    --vfs-read-chunk-size=64M \
    --vfs-read-chunk-size-limit=2G \
    --vfs-cache-mode=full \
    --attr-timeout=3s"
}

RCLONE_MOUNT_OPTS="
  
run_mount() {
    L "rclone 未运行，正在读取配置并挂载目录..."
    rclone listremotes --config "$CONFIG_PATH" | sed 's/:$//' | while read -r remote; do
        MOUNT_POINT="/sdcard/$remote"
        if [ ! -d "$MOUNT_POINT" ]; then
            mkdir -p "$MOUNT_POINT"
            mount_from_to ""$remote:" "$MOUNT_POINT"
            L "已挂载: $remote 到 $MOUNT_POINT"
        elif [ -z "$(ls -A "$MOUNT_POINT")" ]; then
            mount_from_to ""$remote:" "$MOUNT_POINT"
            L "已挂载: $remote 到 $MOUNT_POINT"
        else
            # 检查子目录
            for dir in "$MOUNT_POINT"/*; do
                [ -d "$dir" ] || continue
                if [ -z "$(ls -A "$dir")" ]; then
                    rclone_name=$(basename "$dir")
                    mount_from_to ""$remote:$clone_name" "$dir"
                    L "已挂载: $remote:$rclone_name 到 $dir"
                else
                    L "❌ 子目录不为空，无法挂载: $dir"
                fi
            done
        fi
    done
    L "所有指定目录已挂载。"
    sed -i 's/^description=\(.\{1,4\}| \)\?/description=🚀| /' "$MODULE_PROP"
}

if pidof rclone >/dev/null; then
     run_unmount
else
     run_mount
fi