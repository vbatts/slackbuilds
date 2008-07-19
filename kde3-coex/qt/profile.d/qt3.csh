#!/bin/csh
# Environment path variables for the Qt3 package:
# Find the newest Qt3 directory and set $QTDIR to that:
foreach qtd ( /usr/lib/qt-3* )
   if ( -d $qtd ) then
       setenv QTDIR $qtd
   endif
end
set path = ( $path $QTDIR/bin )
setenv MANPATH ${MANPATH}:${QTDIR}/doc/man
if ( $?CPLUS_INCLUDE_PATH ) then
    setenv CPLUS_INCLUDE_PATH $QTDIR/include:$CPLUS_INCLUDE_PATH
else
    setenv CPLUS_INCLUDE_PATH $QTDIR/include
endif
