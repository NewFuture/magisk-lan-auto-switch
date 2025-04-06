
#!/system/bin/sh

MODPATH=${0%/*}

ORIGINAL_BOOT=$MODPATH/backup_boot.img
get_flags
find_boot_image
flash_image $ORIGINAL_BOOT "$BOOTIMAGE"

# ui_print "- Uninstall autoboot"
# . $MODPATH/patch.sh "rm overlay.d/init.autoboot.rc" 
# ui_print "init.autoboot.rc removed!"
# ui_print "Success !"
