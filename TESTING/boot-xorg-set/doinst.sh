#!/bin/sh

if [ ! -f /etc/X11/xorg.conf.ORIG ] ; then
    cp /etc/X11/xorg.conf{,.ORIG}
else
    cp /etc/X11/xorg.conf{,.ORIG-$RANDOM}
fi

