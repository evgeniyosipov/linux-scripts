#!/bin/bash
#Turn off monitor after locking screen
#https://forum.kde.org/viewtopic.php?f=289&t=126643
#Linux Mint 22
#sudo apt-get install qdbus-qt5
#sudo apt-get install qdbus-qt6
DPMS_STATE="`xset -q | grep "DPMS is"`"
DPMS_TIMES="`xset -q | sed '/  Standby/ !d; s/[^0-9]\+/ /g' `"
qdbus org.cinnamon.ScreenSaver /org/cinnamon/ScreenSaver org.cinnamon.ScreenSaver.Lock ""
xset dpms 20 24 30 # standby suspend off
while [ "`qdbus org.cinnamon.ScreenSaver /org/cinnamon/ScreenSaver org.cinnamon.ScreenSaver.GetActive`" = "true" ]; do
   sleep 30
done # this line was the bug
xset dpms $DPMS_TIMES
if [[ "$DPMS_STATE" == *Disabled* ]]; then
   xset -dpms # turn off if it was
fi
