
ui_print "- Install autoboot to boot.img"

. $MODPATH/patch.sh "add 0700 overlay.d/init.autoboot.rc files/init.autoboot.rc" 

ui_print "Success !"
