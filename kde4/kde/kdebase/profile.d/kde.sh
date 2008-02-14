#!/bin/sh
# KDE additions:
KDE4DIR=/opt/kde4
KDE4DIRS=/opt/kde4
export KDE4DIR KDE4DIRS
if [ ! "$XDG_CONFIG_DIRS" = "" ]; then
  XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS:/etc/kde4/xdg
else
  XDG_CONFIG_DIRS=/etc/xdg:/etc/kde4/xdg
fi
export XDG_CONFIG_DIRS
