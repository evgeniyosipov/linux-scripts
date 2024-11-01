#!/bin/bash
#Turn off monitor after locking screen
#https://forum.kde.org/viewtopic.php?f=289&t=126643

DPMS_STATE="`xset -q | grep "DPMS is"`"
DPMS_TIMES="`xset -q | sed '/  Standby/ !d; s/[^0-9]\+/ /g' `"
qdbus org.freedesktop.ScreenSaver /org/freedesktop/ScreenSaver Lock
xset dpms 20 24 30 # standby suspend off
while [ "`qdbus org.freedesktop.ScreenSaver /org/freedesktop/ScreenSaver GetActive`" = "true" ]; do
   sleep 30
done # this line was the bug
xset dpms $DPMS_TIMES
if [[ "$DPMS_STATE" == *Disabled* ]]; then
   xset -dpms # turn off if it was
fi
