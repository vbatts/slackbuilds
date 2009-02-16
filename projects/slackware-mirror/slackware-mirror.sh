#!/bin/sh

if [ $UID != 0 ] ; then 
  echo please be root
  exit 1
fi

. /etc/slackware-mirror.conf

echo RSYNC_SOURCE $SLACKWARE_RSYNC_SOURCE
echo RSYNC_DEST $SLACKWARE_RSYNC_DEST

date

rsync -avPHS --exclude '*pasture/*' \
  --exclude '*/kdei/*' \
  --exclude '*/source/*' \
  --exclude '*/testing/*' \
  --delete-after \
  $SLACKWARE_RSYNC_SOURCE $SLACKWARE_RSYNC_DEST
