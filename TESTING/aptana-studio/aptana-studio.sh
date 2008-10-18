#!/bin/sh

APTANAHOME=/usr/lib/aptana-studio-1.1

/usr/lib/java/bin/java \
-jar $APTANAHOME/startup.jar \
-os linux \
-ws gtk \
-arch x86 \
-launcher /usr/bin/aptana-studio \
-name Aptana-studio \
-showsplash 600 \
-exitdata 70003 \
-vm /usr/lib/java/bin/java \
-vmargs \
-jar $APTANAHOME/startup.jar 
