#!/bin/csh
# KDE additions:
if ( ! $?KDE4DIR ) then
    setenv KDE4DIR /opt/kde4
endif
if ( $?XDG_CONFIG_DIRS ) then
    setenv XDG_CONFIG_DIRS ${XDG_CONFIG_DIRS}:/etc/kde4/xdg
else
    setenv XDG_CONFIG_DIRS /etc/xdg:/etc/kde4/xdg
endif
