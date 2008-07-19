#!/bin/csh
# KDE additions:
if ( ! $?KDEDIR ) then
    setenv KDEDIR /usr
endif
if ( $?XDG_CONFIG_DIRS ) then
    setenv XDG_CONFIG_DIRS ${XDG_CONFIG_DIRS}:/opt/kde3/etc/xdg
else
    setenv XDG_CONFIG_DIRS /etc/xdg:/opt/kde3/etc/xdg
endif
