#!/bin/sh

for opt in $(cat /proc/cmdline ); do  
  if echo $opt | egrep '^display=' >/dev/null ; then 
    DISPLAY=$(echo $opt | sed 's/.*=//g' )
  else
    DISPLAY=DEFAULT
  fi 
done
if [ ${DISPLAY} = "DEFAULT" ] ; then
  cp /etc/X11/xorg.conf.WORKS_fglrx /etc/X11/xorg.conf
elif [ ${DISPLAY} = "fglrx" ] ; then
  cp /etc/X11/xorg.conf.WORKS_fglrx /etc/X11/xorg.conf
elif [ ${DISPLAY} = "radeon" ] ; then
  cp /etc/X11/xorg.conf.WORKS_radeon /etc/X11/xorg.conf
elif [ ${DISPLAY} = "d1280" ] ; then
  cp /etc/X11/xorg.conf.dualhead /etc/X11/xorg.conf
else
  cp /etc/X11/xorg.conf.WORKS_fglrx /etc/X11/xorg.conf
fi

