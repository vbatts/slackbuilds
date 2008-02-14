#!/bin/csh
# Environment path variables for the Qt package:
if ( ! $?QT4DIR ) then
    # It's best to use the generic directory to avoid
    # compiling in a version-containing path:
    if ( -d /usr/lib/qt4 ) then
        setenv QT4DIR /usr/lib/qt4
    else
        # Find the newest Qt directory and set $QTDIR to that:
        foreach qtd ( /usr/lib/qt-4* )
            if ( -d $qtd ) then
                setenv QT4DIR $qtd
            endif
        end
    endif
endif
set path = ( $path $QT4DIR/bin )
if ( $?CPLUS_INCLUDE_PATH ) then
    setenv CPLUS_INCLUDE_PATH $QT4DIR/include:$CPLUS_INCLUDE_PATH
else
    setenv CPLUS_INCLUDE_PATH $QT4DIR/include
endif
