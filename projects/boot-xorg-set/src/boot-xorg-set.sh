#!/bin/sh

DISPLAY=DEFAULT

for opt in $(cat /proc/cmdline ); do  
  if echo $opt | egrep '^display=' >/dev/null ; then 
    DISPLAY=${opt/display=/}
  fi 
done
echo "setting display per $DISPLAY"
if [ ${DISPLAY} = "single" ] ; then
  aticonfig --dtop=single
  #cp -v /etc/X11/xorg.conf.WORKS_fglrx /etc/X11/xorg.conf
elif [ ${DISPLAY} = "fglrx" ] ; then
  cp -v /etc/X11/xorg.conf.WORKS_fglrx /etc/X11/xorg.conf
elif [ ${DISPLAY} = "radeon" ] ; then
  cp -v /etc/X11/xorg.conf.WORKS_radeon /etc/X11/xorg.conf
elif [ ${DISPLAY} = "dual" ] ; then
  aticonfig --dtop=horizontal,reverse --screen-layout=left
  #cp -v /etc/X11/xorg.conf.dualhead /etc/X11/xorg.conf
else
  cp -v /etc/X11/xorg.conf.WORKS_fglrx /etc/X11/xorg.conf
fi

