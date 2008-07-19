#!/bin/sh
# KDE additions:
KDEDIR=/usr
export KDEDIR
if [ ! "$XDG_CONFIG_DIRS" = "" ]; then
  XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS:/opt/kde3/etc/xdg
else
  XDG_CONFIG_DIRS=/etc/xdg:/opt/kde3/etc/xdg
fi
export XDG_CONFIG_DIRS
