#!/system/bin/sh
# Magisk module installation script

VERSION="v1.69.1"

print_modname() {
  ui_print "*****************************************"
  ui_print "              Magisk Rclone         "
  ui_print "   By ChatGPT + Copilot x NewFuture 😎  "
  ui_print "*****************************************"
}

on_install() {
  ui_print "- 检测系统架构..."
  ABI=$(getprop ro.product.cpu.abi)

  case "$ABI" in
    arm64-v8a)
      ARCH_URL_PART="armv8a"
      ;;
    armeabi-v7a)
      ARCH_URL_PART="armv7a"
      ;;
    x86)
      ARCH_URL_PART="x86"
      ;;
    x86_64)
      ARCH_URL_PART="x86_64"
      ;;
    *)
      abort "! 不支持的架构: $ABI"
      ;;
  esac

  ui_print "- 当前架构: $ABI ($ARCH_URL_PART)"

  ui_print "- 创建目录..."
  mkdir -p $MODPATH/system/bin

  # 如果你知道固定版本，可以直接写死

  FILENAME="rclone-android-21-${ARCH_URL_PART}.gz"
  RCLONE_URL="https://beta.rclone.org/${VERSION}/testbuilds/${FILENAME}"

  ui_print "- 下载 rclone: $RCLONE_URL"
  TMP_GZ="/data/local/tmp/rclone.gz"
  curl -L "$RCLONE_URL" -o "$TMP_GZ" || abort "! 下载失败"

  ui_print "- 解压 rclone..."
  gunzip -c "$TMP_GZ" > "$MODPATH/system/bin/rclone" || abort "! 解压失败"

  chmod 755 "$MODPATH/system/bin/rclone"

  ui_print "- 清理临时文件..."
  rm -f "$TMP_GZ"

  ui_print "- 安装完成 🎉"
}

set_permissions() {
  set_perm_recursive $MODPATH 0 0 0755 0644
  set_perm $MODPATH/system/bin/rclone 0 0 0755
}


print_modname
on_install
set_permissions

ui_print "- 检查配置文件..."
USER_CONFIG="/sdcard/.rclone/rclone.config"
MODULE_CONFIG="${MODPATH:-/data/adb/modules/magisk-rclone}/rclone.config"
MODULE_PROP="$MODPATH/module.prop"

if [ -f "$USER_CONFIG" ] || [ -f "$MODULE_CONFIG" ]; then
    ui_print "✅ 已检测到配置文件"
    sed -i 's/^description=\(.\{1,4\}| \)\?/description=✅| /' "$MODULE_PROP"
else
    ui_print "⚙️ 未检测到配置文件，运行 rclone-config 进行配置"
    sed -i 's/^description=\(.\{1,4\}| \)\?/description=⚙️| /' "$MODULE_PROP"
fi