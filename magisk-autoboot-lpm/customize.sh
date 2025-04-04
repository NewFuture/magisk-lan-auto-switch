
ui_print "- Install autoboot to boot.img"

set_perm_recursive $MODPATH/files 0 2000 0644 0755
. $MODPATH/patch.sh "add 0700 overlay.d/init.autoboot.rc files/init.autoboot.rc" 

ui_print "Success !"
