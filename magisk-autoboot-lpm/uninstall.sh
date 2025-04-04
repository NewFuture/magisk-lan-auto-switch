
ui_print "- Uninstall autoboot"

. $MODPATH/patch.sh "rm overlay.d/init.autoboot.rc" 

ui_print "init.autoboot.rc removed!"

ui_print "Success !"
