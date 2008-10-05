#!/bin/sh

DISPLAY=DEFAULT

function addMode() {
cat >> /etc/X11/xorg.conf << xxEOFxx

Section "DRI"
  Group      "video"
  Mode       0666
EndSection

xxEOFxx
}

for opt in $(cat /proc/cmdline ); do  
  if echo $opt | egrep '^display=' >/dev/null ; then 
    DISPLAY=${opt/display=/}
  fi 
done
echo "setting display per $DISPLAY"
if [ ${DISPLAY} = "single" ] ; then
  aticonfig --dtop=single
  #cp -v /etc/X11/xorg.conf.WORKS_fglrx /etc/X11/xorg.conf
  addMode
elif [ ${DISPLAY} = "fglrx" ] ; then
  cp -v /etc/X11/xorg.conf.WORKS_fglrx /etc/X11/xorg.conf
  addMode
elif [ ${DISPLAY} = "fglrx" ] ; then
elif [ ${DISPLAY} = "radeon" ] ; then
  cp -v /etc/X11/xorg.conf.WORKS_radeon /etc/X11/xorg.conf
elif [ ${DISPLAY} = "dual" ] ; then
  aticonfig --dtop=horizontal,reverse --screen-layout=left
  #cp -v /etc/X11/xorg.conf.dualhead /etc/X11/xorg.conf
  addMode
elif [ ${DISPLAY} = "fglrx" ] ; then
else
  cp -v /etc/X11/xorg.conf.WORKS_fglrx /etc/X11/xorg.conf
  addMode
elif [ ${DISPLAY} = "fglrx" ] ; then
fi

echo "Removing fglrx backups"
rm /etc/X11/xorg.conf.fglrx-*
