#!/bin/sh

SBO_DIR=${SBO_DIR:-/var/lib/sbopkg/SBo/}
SEARCH_STRING=${1:-vbatts}
LIST=$(find $SBO_DIR -type f -name '*.info' | xargs grep $SEARCH_STRING | cut -d : -f 1 | sort -u )

for f in $LIST
do
	basename $f .info
done | \
	sort
