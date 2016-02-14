#! /bin/sh
#Script to turn off monitor modes that will power down, standby or blank the screen
#

#Disable modes
/usr/bin/xset -dpms &
/usr/bin/xset s off &
#Re-enable modes
/usr/bin/xset dpms
/usr/bin/xset s on
