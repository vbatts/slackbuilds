#!/bin/sh
# Environment variables for the Qt package.
#
# Find the newest Qt3 directory and set $QTDIR to that:
for qtd in /usr/lib/qt-3* ; do
  if [ -d $qtd ]; then
    QTDIR=$qtd
  fi
done
if [ ! "$CPLUS_INCLUDE_PATH" = "" ]; then
  CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$QTDIR/include
else
  CPLUS_INCLUDE_PATH=$QTDIR/include
fi
PATH="$PATH:$QTDIR/bin"
MANPATH="${MANPATH}:$QTDIR/doc/man"
export QTDIR
export CPLUS_INCLUDE_PATH
