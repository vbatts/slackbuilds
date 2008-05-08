#!/bin/sh
# KDE additions:
KDE4HOME="$HOME/.kde4"
export KDE4HOME
KDE4DIR=/opt/kde4
export KDE4DIR
if [ ! "$XDG_CONFIG_DIRS" = "" ]; then
  XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS:/etc/kde4/xdg
else
  XDG_CONFIG_DIRS=/etc/xdg:/etc/kde4/xdg
fi
export XDG_CONFIG_DIRS
