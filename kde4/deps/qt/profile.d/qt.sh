#!/bin/sh
# Environment variables for the Qt package.
#
# It's best to use the generic directory to avoid
# compiling in a version-containing path:
if [ -d /usr/lib/qt4 ]; then
  QT4DIR=/usr/lib/qt4
else
  # Find the newest Qt directory and set $QTDIR to that:
  for qtd in /usr/lib/qt-4* ; do
    if [ -d $qtd ]; then
      QT4DIR=$qtd
    fi
  done
fi
if [ ! "$CPLUS_INCLUDE_PATH" = "" ]; then
  CPLUS_INCLUDE_PATH=$QT4DIR/include:$CPLUS_INCLUDE_PATH
else
  CPLUS_INCLUDE_PATH=$QT4DIR/include
fi
PATH="$PATH:$QT4DIR/bin"
export QT4DIR
export CPLUS_INCLUDE_PATH
