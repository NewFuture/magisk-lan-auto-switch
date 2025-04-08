#!/system/bin/sh

# ref https://github.com/anasfanani/magisk-autoboot

# make sure /data/adb/magisk/util_functions.sh is sourced
. /data/adb/magisk/util_functions.sh

magiskboot() {
  /data/adb/magisk/magiskboot "$@"
}

get_flags
find_boot_image

# make sure magiskboot exists
test ! -f /data/adb/magisk/magiskboot && abort "- Hmmm... Where is magiskboot binary?"

check_ramdisk() {
  ui_print "- Checking ramdisk status"
  if [ -e ramdisk.cpio ]; then
    magiskboot cpio ramdisk.cpio test
    STATUS=$?
  else
    # Stock A only legacy SAR, or some Android 13 GKIs
    STATUS=0
  fi
  case $((STATUS & 3)) in
    0)  # Stock boot
      ui_print "- Stock boot image detected"
      ;;
    1)  # Magisk patched
      ui_print "- Magisk patched boot image detected"
      ;;
    2)  # Unsupported
      ui_print "! Boot image patched by unsupported programs"
      abort "! Please restore back to stock boot image"
      ;;
  esac
}

if [ ! -z "$BOOTIMAGE" ]; then
  cd $MODPATH
  ui_print "- Target boot image: $BOOTIMAGE"
  [ "$RECOVERYMODE" == "true" ] && ui_print "- Recovery mode is present, the script might patch recovery image..."
  if [ -c "$BOOTIMAGE" ]; then
    nanddump -f "$MODPATH/boot.img" "$BOOTIMAGE" || abort "! Unable to dump boot image"
    BOOTNAND="$BOOTIMAGE"
    BOOTIMAGE="$MODPATH/boot.img"
  else
    dd if="$BOOTIMAGE" of="$MODPATH/boot.img" || abort "! Unable to dump boot image"
  fi
  ui_print "- Unpack boot image"
  cd "$MODPATH" || exit 1
  magiskboot unpack boot.img
  check_ramdisk

  # do patch here
  ARGS="magiskboot cpio ramdisk.cpio"
  for arg in "$@"; do
    ARGS="$ARGS \"$arg\""
  done
  eval "$ARGS"

  ui_print "- Repack boot image"
  magiskboot repack boot.img || abort "! Unable to repack boot image"
  [ -e "$BOOTNAND" ] && BOOTIMAGE="$BOOTNAND"

  # flash new boot image into $BOOTIMAGE
  ui_print "- Flashing new boot image"
  flash_image "$MODPATH/new-boot.img" "$BOOTIMAGE"
  case $? in
    1)
      abort "! Insufficient partition size"
      ;;
    2)
      # mediatek devices don't allow to flash boot image at boot image (from Android system). the only way is flashing through Custom Recovery or Fastboot
      ui_print "! $BOOTIMAGE is read-only"
      abort "! Unable to flash boot image"
      ;;
  esac
  ui_print "- All done!"
else
  ui_print "! Cannot detect target boot image"
fi

magiskboot cleanup
rm -f new-boot.img
